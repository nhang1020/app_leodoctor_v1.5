import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// ignore: must_be_immutable
class WebView_Page extends StatefulWidget {
  String url;
  WebView_Page({super.key, required this.url});

  @override
  State<WebView_Page> createState() => _WebView_PageState();
}

class _WebView_PageState extends State<WebView_Page> {
  late InAppWebViewController inApp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            supportZoom: true,
            disableHorizontalScroll: true,
            horizontalScrollBarEnabled: false,
          ),
          android: AndroidInAppWebViewOptions(
            initialScale: 100,
          ),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          inApp = controller;
        },
        onLoadStart: (InAppWebViewController controller, url) {},
        onLoadStop: (InAppWebViewController controller, url) {},
      ),
    );
  }
}
