import 'dart:typed_data';

import 'package:art/APIUri/BaseUrl.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../TransactionLineScreen.dart';

class ImageAttachmentsScreenApp extends StatefulWidget {
  @override
  _ImageAttachmentsState createState() => _ImageAttachmentsState();
}

class _ImageAttachmentsState extends State<ImageAttachmentsScreenApp> {
  bool _isLoading = true;
  String BaseUrl = BaseURL().Auth;
  int id;
  Uint8List bytes;

  @override
  void initState() {
    super.initState();
    MySharedPreferences.instance
        .getIntValue("fileId")
        .then((name) => setState(() {
              id = name;
              loadDocument(id);
            }));
    //
  }

  loadDocument(int id_) async {
    final ByteData imageData = await NetworkAssetBundle(
            Uri.parse(BaseUrl + "approval/attachements/" + id_.toString()))
        .load("");
    bytes = imageData.buffer.asUint8List();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Willpopwidget().getWillScope(Scaffold(
      appBar: new CustomAppBarImage(
        onPressed: () {
          MySharedPreferences.instance.removeValue('fileId');
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => TransactionLine()),
          );
        },
        Title: 'Attachment',
        image_bar: 'assets/images/eapprovals.png',
      ),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Image.memory(bytes),
      ),
    ));
  }
}
