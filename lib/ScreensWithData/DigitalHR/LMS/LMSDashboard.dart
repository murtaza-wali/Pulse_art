import 'dart:io';

import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class TabScreen3 extends StatelessWidget {
  TabScreen3(this.listType);

  final String listType;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LMSDashboardWidget());
  }
}

class LMSDashboardWidget extends StatefulWidget {
  @override
  _LMSDashboardWidgetState createState() => new _LMSDashboardWidgetState();
}

class _LMSDashboardWidgetState extends State<LMSDashboardWidget> with AutomaticKeepAliveClientMixin<LMSDashboardWidget> {
  final GlobalKey webViewKey = GlobalKey();
  final Set<Factory> gestureRecognizers = [Factory(() => EagerGestureRecognizer())].toSet();

  @override
  bool get wantKeepAlive => true;
  InAppWebViewController webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /* appBar: new CustomAppBarImage(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainMenuPopUp()),
            );
          },
          Title: 'Digital HR',
          image_bar: 'assets/images/hrms_logo2.png',
        ),*/
        /*  appBar: AppBar(title: Text("Emilliners")),*/
        /* bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.keyboard_arrow_left),
                label: 'Back',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.refresh),
                label: 'Refresh',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chevron_right),
                label: 'Forward',
              ),
            ],
          ),*/
        body: SafeArea(
            child: Column(children: <Widget>[
      /*   TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search)
                  ),
                  controller: urlController,
                  keyboardType: TextInputType.url,
                  onSubmitted: (value) {
                    var url = Uri.parse(value);
                    if (url.scheme.isEmpty) {
                      url = Uri.parse("");
                    }
                    webViewController?.loadUrl(
                        urlRequest: URLRequest(url: url));
                  },
                ),*/
      Expanded(
        child: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              gestureRecognizers: gestureRecognizers,
              initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      "https://artlive.artisticmilliners.com:8081/ords/f?p=402:528")),
              initialOptions: options,
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                if (mounted) {
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                }
              },
              androidOnPermissionRequest:
                  (controller, origin, resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                var uri = navigationAction.request.url;
                if (![
                  "http",
                  "https",
                  "file",
                  "chrome",
                  "data",
                  "javascript",
                  "about"
                ].contains(uri.scheme)) {
                  if (await canLaunch(url)) {
                    // Launch the App
                    await launch(
                      url,
                    );
                    // and cancel the request
                    return NavigationActionPolicy.CANCEL;
                  }
                }
                return NavigationActionPolicy.ALLOW;
              },
              onLoadStop: (controller, url) async {
                pullToRefreshController.endRefreshing();
                if (mounted) {
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                }
              },
              onLoadError: (controller, url, code, message) {
                pullToRefreshController.endRefreshing();
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  pullToRefreshController.endRefreshing();
                }
                if (mounted) {
                  setState(() {
                    this.progress = progress / 100;
                    urlController.text = this.url;
                  });
                }
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                if (mounted) {
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                }
              },
              onConsoleMessage: (controller, consoleMessage) {
                print(consoleMessage);
              },
            ),
            progress < 1.0
                ? LinearProgressIndicator(value: progress)
                : Container(),
          ],
        ),
      ),
      /*      ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      child: Icon(Icons.arrow_back),
                      onPressed: () {
                        webViewController?.goBack();
                      },
                    ),
                    ElevatedButton(
                      child: Icon(Icons.arrow_forward),
                      onPressed: () {
                        webViewController?.goForward();
                      },
                    ),
                    ElevatedButton(
                      child: Icon(Icons.refresh),
                      onPressed: () {
                        webViewController?.reload();
                      },
                    ),
                  ],
                ),*/
    ])));
  }
}
