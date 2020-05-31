import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemListPage extends StatefulWidget {
  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  String itemName, itemColor;

  readData() {
    DocumentReference documentReference =
        Firestore.instance.collection('ItemData').document(itemName);

    documentReference.get().then(
      (datasnapshot) {
        print(datasnapshot.data['itemName']);
        print(datasnapshot.data['itemColor']);
      },
    );
  }

  updateData() {
    print('Data Updated');
    DocumentReference itemNameReference =
        Firestore.instance.collection('ItemData').document(itemName);

    // Creating Map
    Map<String, dynamic> items = {
      "itemName": itemName,
      "itemColor": itemColor,
    };

    itemNameReference.setData(items).whenComplete(
          () => {
            print('$itemName updated'),
          },
        );
  }

  deleteData() {
    DocumentReference documentReference =
        Firestore.instance.collection('ItemData').document(itemName);

    documentReference.delete().whenComplete(() {
      print('Item Deleted');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    'Item Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Item Color',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Action',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream: Firestore.instance.collection('ItemData').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data.documents[index];

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          documentSnapshot['itemName'] ?? 'Item Name',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          documentSnapshot['itemColor'] ?? 'Item Color',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        FlatButton.icon(
                          onPressed: deleteData,
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
