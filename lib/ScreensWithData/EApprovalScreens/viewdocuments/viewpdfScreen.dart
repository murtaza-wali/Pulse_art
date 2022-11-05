import 'package:art/APIUri/BaseUrl.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:flutter/material.dart';
//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

import '../TransactionLineScreen.dart';

class AttachmentsScreenApp extends StatefulWidget {
  @override
  _AttachmentsScreenState createState() => _AttachmentsScreenState();
}

class _AttachmentsScreenState extends State<AttachmentsScreenApp> {
  bool _isLoading = true;
 // PDFDocument document;
  String BaseUrl = BaseURL().Auth;
  int id;

  @override
  void initState() {
    super.initState();
    MySharedPreferences.instance.getIntValue("fileId").then((name) =>
        setState(() {
              id = name;
              loadDocument(id);
            }));
    //
  }

  loadDocument(int id_) async {
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
        child: Text('PDF')
        /*_isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(
                document: document,
                zoomSteps: 1,
                //uncomment below line to preload all pages
                // lazyLoad: false,
                // uncomment below line to scroll vertically
                // scrollDirection: Axis.vertical,

                //uncomment below code to replace bottom navigation with your own
                *//* navigationBuilder:
                      (context, page, totalPages, jumpToPage, animateToPage) {
                    return ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.first_page),
                          onPressed: () {
                            jumpToPage()(page: 0);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            animateToPage(page: page - 2);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            animateToPage(page: page);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.last_page),
                          onPressed: () {
                            jumpToPage(page: totalPages - 1);
                          },
                        ),
                      ],
                    );
                  }, *//*
              ),*/
      ),
    ));
  }
}
