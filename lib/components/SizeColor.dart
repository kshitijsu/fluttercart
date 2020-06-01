import 'package:flutter/material.dart';

class SizeColor extends StatefulWidget {
  @override
  _SizeColorState createState() => _SizeColorState();
}

class _SizeColorState extends State<SizeColor> {
  String itemColor;

  // Drop Down Initial Value
  String dropdownValue = 'Red';
  String size = 'S';

  void getItemColor(String itemColor) {
    this.itemColor = itemColor;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            color: Colors.blueAccent,
          ),
          onChanged: (String newValue) {
            setState(
              () {
                dropdownValue = newValue;
                getItemColor(newValue);
              },
            );
          },
          items: <String>['Red', 'Blue', 'Green', 'Yellow']
              .map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
        ),
        DropdownButton<String>(
          value: size,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            color: Colors.blueAccent,
          ),
          onChanged: (String newValue) {
            setState(
              () {
                size = newValue;
                getItemColor(newValue);
              },
            );
          },
          items: <String>['S', 'M', 'L', 'XL'].map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
