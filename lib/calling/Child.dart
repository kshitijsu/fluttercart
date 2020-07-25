import 'package:flutter/material.dart';

class Child extends StatefulWidget {
  final String text;
  final customFunction;
  final customFunction2;
  Child({Key key, this.text, this.customFunction, this.customFunction2})
      : super(key: key);
  @override
  _ChildState createState() => _ChildState();
}

class _ChildState extends State<Child> {
  customFunction2() {
    print('I am form child, Custom Function 2');
  }

  @override
  Widget build(BuildContext context) {
    String childText = widget.text != null ? widget.text : 'No Text';
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(childText),
          RaisedButton(
            onPressed: () {
              widget.customFunction('String From Child');
              customFunction2();
            },
            child: Text('Click Here'),
          )
        ],
      ),
    );
  }
}
