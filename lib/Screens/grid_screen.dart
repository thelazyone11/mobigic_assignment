import 'package:flutter/material.dart';

class GridScreen extends StatefulWidget {
  final Map<int, String> alphabetMap;
  final int column;
  final int row;
  const GridScreen(
      {Key? key,
      required this.alphabetMap,
      required this.row,
      required this.column})
      : super(key: key);

  @override
  _GridScreenState createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  List listOfAlphabets = [];
  Map<int, bool> finalls = {};

  @override
  void initState() {
    // add alphabetmap into an list initialy
    for (var i in widget.alphabetMap.values) {
      listOfAlphabets.add(i);
    }

    super.initState();
  }

  // Function to search Alphabet from list
  void searchWord(String s) {
    finalls = {};
    List listOfString = s.split('');
    Map<int, String> vertical = {};
    Map<int, String> horizontal = {};
    Map<int, String> diagonal = {};

    for (var i = listOfAlphabets.indexWhere((element) => element == s[0]);
        i < listOfAlphabets.length;
        i += widget.column) {
      vertical[i] = listOfAlphabets[i];
    }

    for (var i = listOfAlphabets.indexWhere((element) => element == s[0]);
        i < widget.row;
        i++) {
      // print(listOfAlphabets[i]);

      horizontal[i] = listOfAlphabets[i];
    }

    for (var i = listOfAlphabets.indexWhere((element) => element == s[0]);
        i < listOfAlphabets.length;
        i += widget.column + 1) {
      print(listOfAlphabets[i]);

      diagonal[i] = listOfAlphabets[i];
    }

    for (var i in listOfString) {
      try {
        finalls[vertical.keys.firstWhere((element) => vertical[element] == i)] =
            vertical.values.contains(i);
      } catch (e) {
        finalls[-1] = false;
      }
    }
    if (finalls.values.contains(false)) {
      finalls = {};
      for (var i in listOfString) {
        // print(i);

        try {
          finalls[diagonal.keys
                  .firstWhere((element) => diagonal[element] == i)] =
              diagonal.values.contains(i);
        } catch (e) {
          finalls[-1] = false;
        }
      }
    }

    if (finalls.values.contains(false)) {
      finalls = {};
      for (var i in listOfString) {
        print(i);

        try {
          finalls[horizontal.keys
                  .firstWhere((element) => horizontal[element] == i)] =
              horizontal.values.contains(i);
        } catch (e) {
          finalls[-1] = false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobigic"),
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextField(
                decoration: new InputDecoration(hintText: 'Search word'),
                onSubmitted: (v) {
                  searchWord(v);
                  setState(() {});
                },
              )),
          Expanded(
            child: Container(
              color: Colors.grey.shade300,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.column,
                ),
                itemCount: (widget.column * widget.row),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: finalls.keys.contains(index) &&
                                  finalls.values.contains(false) != true
                              ? Colors.amber.shade300
                              : Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      alignment: Alignment.center,
                      child: Text(" ${widget.alphabetMap[index]}"),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
