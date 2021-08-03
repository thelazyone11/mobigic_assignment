import 'package:flutter/material.dart';

class GridBoxItem extends StatefulWidget {
  final int index;
  final Function addToAlphabets;
  const GridBoxItem(
      {Key? key, required this.index, required this.addToAlphabets})
      : super(key: key);

  @override
  _GridBoxItemState createState() => _GridBoxItemState();
}

class _GridBoxItemState extends State<GridBoxItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          // alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FittedBox(child: Text("${(widget.index + 1).toString()}")),
              Container(
                height: 20,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: TextField(
                  keyboardType: TextInputType.text,
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  onChanged: (e) {
                    widget.addToAlphabets(widget.index, e);
                  },
                  decoration:
                      new InputDecoration(counterText: "", hintText: "Enter"),
                ),
              ),
            ],
          )),
    );
  }
}
