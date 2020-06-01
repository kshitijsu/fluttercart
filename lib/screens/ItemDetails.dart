import 'package:flutter/material.dart';
import 'package:flutterinternship/components/ItemCard.dart';

class ItemDetails extends StatefulWidget {
  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int _count = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> _itemList = List.generate(
      _count,
      (int i) => ItemCard(),
    );

    void _addNewItemCard() {
      setState(
        () {
          _count = _count + 1;
        },
      );
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 600,
                      child: ListView(
                        children: _itemList,
                        scrollDirection: Axis.vertical,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          RaisedButton(
            onPressed: _addNewItemCard,
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
