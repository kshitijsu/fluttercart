import 'package:flutter/material.dart';
import 'package:flutterinternship/calling/Parent.dart';

import 'screens/HomePage.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Cart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Parent(),
      //  ProfilePage(),
      // HomePage(),
    );
  }
}
