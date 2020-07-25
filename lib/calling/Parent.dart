import 'package:flutter/material.dart';
import 'package:flutterinternship/calling/Child.dart';

class Parent extends StatefulWidget {
  @override
  _ParentState createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  String parentString = 'Parent String';

  void parentChange(String newString) {
    setState(() {
      parentString = newString;
    });
  }

  void anotherParentFunction() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(parentString),
              Child(
                text: 'Text From Parent',
                customFunction: parentChange,
                customFunction2: anotherParentFunction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
