import 'package:flutter/material.dart';
import 'package:flutterinternship/components/ItemCard.dart';
import 'package:flutterinternship/screens/MultipleImages.dart';

class ItemDetails extends StatefulWidget {
  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int _count = 1;

  // void _addNewItemCard() {
  //   setState(
  //     () {
  //       _count = _count + 1;
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    List<Widget> _itemList = List.generate(
      _count,
      (int i) => ItemCard(),
    );
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          MultipleImages(),
          LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 350,
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
        ],
      ),
    );
  }
}
