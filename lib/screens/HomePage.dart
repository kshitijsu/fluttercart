import 'package:flutter/material.dart';
import 'package:flutterinternship/screens/ItemListPage.dart';

import 'ItemPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    ItemPage(),
    ItemListPage(),
  ];

  void onTabTapped(int index) {
    setState(
      () {
        _currentIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Cart'),
      ),
      body: _children[_currentIndex],
      // FlutterDB(),
      // ItemPage(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.create_new_folder),
            title: new Text('Insert Items'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.list),
            title: new Text('List Items'),
          ),
        ],
      ),
    );
  }
}
