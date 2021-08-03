import 'package:flutter/material.dart';
import 'package:mobigic_assignment/Screens/grid_screen.dart';
import 'package:mobigic_assignment/Widget/gride_box_item.dart';
import 'package:mobigic_assignment/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController mRow = new TextEditingController();
  TextEditingController nColumn = new TextEditingController();

  Map<int, String> alphabets = new Map<int, String>();

  void addToAlphabets(int index, String alphabet) {
    alphabets[index] = alphabet;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await showLoaderDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: null,
              decoration: BoxDecoration(color: Colors.blue),
            ),
            InkWell(
              onTap: () {
                RestartWidget.restartApp(context);
              },
              child: ListTile(
                leading: Text('Restart'),
                trailing: Icon(Icons.restart_alt),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Mobigic"),
        actions: [
          checkvalue()
              ? ElevatedButton(
                  onPressed: () {
                    if (alphabets.length !=
                        (int.parse(nColumn.text) * int.parse(mRow.text))) {
                      showErrorDialog(context);
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GridScreen(
                          alphabetMap: alphabets,
                          column: int.parse(nColumn.text),
                          row: int.parse(mRow.text),
                        ),
                      ));
                    }
                  },
                  child: Text("Save"))
              : Container()
        ],
      ),
      body: checkvalue()
          ? Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: int.parse(nColumn.text),
                ),
                itemCount: (int.parse(nColumn.text) * int.parse(mRow.text)),
                itemBuilder: (context, index) {
                  return GridBoxItem(
                    index: index,
                    addToAlphabets: addToAlphabets,
                  );
                },
              ))
          : Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Invalid Input'),
                  TextButton(
                      onPressed: () {
                        RestartWidget.restartApp(context);
                      },
                      child: Text('Restart'))
                ],
              ),
            ),
    );
  }

  /// dailog to take number of column and rows.
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter Nummber m and n.",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: mRow,
              maxLength: 2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 16, right: 16),
                  labelText: "Enter Number of Row(m)"),
            ),
            TextField(
              controller: nColumn,
              maxLength: 2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 16, right: 16),
                  labelText: "Enter Number of Column(n)"),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                child: Text('Create'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {});
                },
              ),
            )
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /// Function to check the input values are valid or not.
  bool checkvalue() {
    try {
      int.parse(nColumn.text);
      int.parse(mRow.text);
      return true;
    } catch (e) {
      return false;
    }
  }

  showErrorDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: new Container(
            alignment: Alignment.center,
            child: Text("Please input value to all the boxes."),
          )),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
