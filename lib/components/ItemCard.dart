import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:io';

class ItemCard extends StatefulWidget {
  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  // Drop Down Initial Value
  String dropdownValue = 'Red';
  // Firebase Image Upload
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }

  Future uploadImage(BuildContext context) async {
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadImage = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadImage.onComplete;
    print(taskSnapshot);

    setState(() {
      print('Image Uploaded');
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Image Uploaded'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: (_image != null)
                  ? Image.file(
                      _image,
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      'https://images.unsplash.com/photo-1581068466660-e6585b8afa97?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
                      height: 100,
                      width: 100),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Enter Item'),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(
                        () {
                          dropdownValue = newValue;
                        },
                      );
                    },
                    items: <String>['Red', 'Blue', 'Green', 'Yellow']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {
                      getImage();
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                RaisedButton(
                  onPressed: () {
                    uploadImage(context);
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
