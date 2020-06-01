import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'SizeColor.dart';

// classes
class ItemCard extends StatefulWidget {
  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  // List Count
  int _countColor = 1;

  void _addNewColor() {
    setState(
      () {
        _countColor = _countColor + 1;
      },
    );
  }

  // Storing data
  String itemName;

  void getItemName(String name) {
    this.itemName = name;
  }

  createData() {
    print('Data Created');
    DocumentReference itemNameReference =
        Firestore.instance.collection('ItemData').document(itemName);

    // Creating Map
    Map<String, dynamic> items = {
      "itemName": itemName,
    };

    itemNameReference.setData(items).whenComplete(
          () => {
            print('$itemName created'),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _sizeColor = List.generate(
      _countColor,
      (int i) => SizeColor(),
    );
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Item Name',
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (String name) {
                getItemName(name);
              },
            ),
            Column(
              children: <Widget>[
                LayoutBuilder(
                  builder: (context, constraint) {
                    return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 200,
                            child: ListView(
                              children: _sizeColor,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _addNewColor();
                  },
                  child: Text('Add Color'),
                ),
                // RaisedButton(
                //   onPressed: () {
                //     createData();
                //     uploadImage(context);
                //     FocusScope.of(context).requestFocus(FocusNode());
                //   },
                //   child: Text('Submit'),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
