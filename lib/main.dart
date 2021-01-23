import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'LoaderWidget.dart';
import 'NavigationControls.dart';
import 'widget/NoInternetWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: WebViewJothi(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WebViewJothi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WebViewState();
  }
}

class WebViewState extends State<WebViewJothi> {
  InAppWebViewController webView;
  bool _isLoading = true;

  bool _isInternetConnected = true;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        setState(() => _isInternetConnected = true);
        break;
      case ConnectivityResult.none:
      default:
        setState(() => _isInternetConnected = false);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_isInternetConnected
        ? NoInternetWidget()
        : WillPopScope(
            child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    "webview Example",
                  ),
                  actions: <Widget>[NavigationControls(webView)],
                ),
                body: SafeArea(
                  top: true,
                  child: LoadgerWidget(
                    child: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Stack(
                          children: [
                            InAppWebView(
                              initialUrl:
                                  "https://www.onlinejyotish.com/ampindex.html",
                              onWebViewCreated:
                                  (InAppWebViewController controller) {
                                webView = controller;
                              },
                              onLoadStop: (InAppWebViewController controller,
                                  String data) {
                                pageFinishedLoading();
                              },
                            ),
                          ],
                        )),
                    showLoader: _isLoading,
                  ),
                )),
            onWillPop: NavigationControls(webView).onBack);
  }

  void pageFinishedLoading() {
    setState(() {
      _isLoading = false;
    });
  }
}




