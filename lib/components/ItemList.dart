import 'package:flutter/material.dart';
import 'package:flutterinternship/components/ItemCard.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ItemCard(),
        ],
      ),
    );
  }
}
