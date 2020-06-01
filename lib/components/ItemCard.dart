import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'dart:io';

// classes
class ItemCard extends StatefulWidget {
  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  // Firebase Image Upload
  File _image;
  // List Count
  int _countColor = 1;

  void _addNewColor() {
    setState(
      () {
        _countColor = _countColor + 1;
      },
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(
      () {
        _image = image;
        print('Image Path $_image');
      },
    );
  }

  // Future uploadImage(BuildContext context) async {
  //   String fileName = basename(_image.path);
  //   StorageReference firebaseStorageRef =
  //       FirebaseStorage.instance.ref().child(fileName);
  //   StorageUploadTask uploadImage = firebaseStorageRef.putFile(_image);
  //   StorageTaskSnapshot taskSnapshot = await uploadImage.onComplete;
  //   print(taskSnapshot);

  //   setState(
  //     () {
  //       print('Image Uploaded');
  //       Scaffold.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Image Uploaded'),
  //         ),
  //       );
  //     },
  //   );
  // }

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
                            height: 150,
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
