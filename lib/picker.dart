import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';

class ImagePickerUI extends StatefulWidget {
  ImagePickerUI({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _ImagePickerUIState();

}

class _ImagePickerUIState extends State<ImagePickerUI> {
  File _image;

  final String AspEndPoint = 'yoursite';
  bool showButton = false;

//get an image from the gallery
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      _image = image;        //show the selected image and the send button
      showButton = true;
    });

  }
//A multipart/form-data request. Such a request has both string fields, which function as normal form fields,
// and  streamed) binary files.
  Future sendImagetoServer() async{
    // open a bytestream
    var stream = new http.ByteStream(DelegatingStream.typed(_image.openRead()));

    final int length = await _image.length();

    // Response response = request.send();
    final request = new http.MultipartRequest('POST', Uri.parse(AspEndPoint))
      ..files.add(
          new http.MultipartFile('UploadedImage', stream, length, filename: 'test')
      );
    http.Response response = await http.Response.fromStream(await request.send());

    setState(() {
      showButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Column(
        children: [

             Container(
              height: 300,
              child: _image == null ? Text('No image selected.') : Image.file(_image),
          ),


          Row(
            children: <Widget>[
              new  FloatingActionButton(
                onPressed: getImage,
                tooltip: 'Pick Image',
                child: Icon(Icons.add_a_photo),
              ),
              showButton == true ?
              new  FloatingActionButton(
              onPressed: sendImagetoServer,
              tooltip: 'Pick Image',
              child: Icon(Icons.email),
              ) : Container()
          ]
          )
        ]
      )

    );
  }
}
