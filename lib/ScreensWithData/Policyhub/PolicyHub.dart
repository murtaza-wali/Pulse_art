//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/policy_hub_model.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Policyhub/iPolicy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';


class policyhub extends StatefulWidget {
  _policyhubState createState() => _policyhubState();
}

class _policyhubState extends State<policyhub> {
  List<policyHubMode> policy_hub_list = [];
  String selectedSpinnerItem;
  int selected_unit_id;
  int getID;
  String employeeCode;
  bool _isLoading = true;
 // PDFDocument document;



  PDFView pdfView;

  PDF pdf;
  String cdt, docNo, attachmentfile;


  @override
  void initState() {
    super.initState();
    MySharedPreferences.instance
        .getStringValue("cdt")
        .then((name) => setState(() {
              cdt = name;
              MySharedPreferences.instance
                  .getStringValue("docNo")
                  .then((name) => setState(() {
                        docNo = name;
                        MySharedPreferences.instance
                            .getStringValue("attachmentFile")
                            .then((name) => setState(() {
                                  attachmentfile = name;
                                  LoadPDF('https://artlive.artisticmilliners.com:8081/policyhub/${cdt}/${docNo}/${attachmentfile}');

                                  setState(() {


                                    aniHoleCode =   'https://artlive.artisticmilliners.com:8081/policyhub/${cdt}/${docNo}/${attachmentfile}';
                                    print(aniHoleCode);
                                  });
                                }));

                      }));
            }));
  }

  LoadPDF(String url) async {
    setState(() => _isLoading = true);
     PDF().cachedFromUrl(url);
    setState(() => _isLoading = false);
  }


  Widget chip(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: ReColors().appMainColor,
            ),
          ),
        ),
      ],
    );
  }
  String aniHoleCode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new CustomAppBarImage(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => IPolicyHub()),
            );
          },
          Title: 'POLICY HUB',
          image_bar: 'assets/images/policymanage_logo.png',
        ),
        body: Willpopwidget().getWillScope(Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator(valueColor:
          AlwaysStoppedAnimation<Color>(ReColors().appMainColor),))
              : PDF(
              nightMode: true,
            fitPolicy: FitPolicy.BOTH
          ).cachedFromUrl(aniHoleCode)
        )
        ));
  }
}
