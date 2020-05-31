import 'package:flutter/material.dart';

class Sample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            color: Colors.red,
            height: 100,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            color: Colors.blue,
            height: 100,
            width: MediaQuery.of(context).size.width,
          ),
        ],
      ),
    );
  }
}
