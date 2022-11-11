import 'package:art/APIUri/BaseUrl.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

import '../TransactionLineScreen.dart';

class AttachmentsScreenApp extends StatefulWidget {
  @override
  _AttachmentsScreenState createState() => _AttachmentsScreenState();
}

class _AttachmentsScreenState extends State<AttachmentsScreenApp> {
  bool _isLoading = true;
 // PDFDocument document;

  PDFView pdfView;
  String BaseUrl = BaseURL().Auth;
  int id;


  @override
  void initState() {
    super.initState();
    MySharedPreferences.instance.getIntValue("fileId").then((name) =>
        setState(() {
              id = name;
              loadDocument(id);
              print('id is ${id}');
              fileid = id;
            }));
    //
  }

  loadDocument(int id_) async {

      PDF().cachedFromUrl(BaseUrl + "approval/attachements/" + id_.toString());

   // document = await PDFDocument.fromURL(
     // BaseUrl + "approval/attachements/" + id_.toString(),
      /* cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 10,
          ),
        ), */
    //);

  //  setState(() => _isLoading = false);
  }

  int fileid;
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
        child:
             PDF().cachedFromUrl(BaseUrl + "approval/attachements/" + fileid.toString()),
      ),
    ));
  }
}
