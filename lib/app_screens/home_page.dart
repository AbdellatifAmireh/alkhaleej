import 'dart:io';
import 'package:flutter/material.dart';

import '../src/web_view_stack.dart';
//import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

/*   @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //controlle?.goBack();
        return true;
      },
      child: const SafeArea(
        child: Scaffold(
          body: WebViewStack(),
        ),
      ),
    );
  }
}
