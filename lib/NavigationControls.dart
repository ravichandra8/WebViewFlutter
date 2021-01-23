import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NavigationControls extends StatelessWidget {
  final InAppWebViewController _webView;

  const NavigationControls(this._webView);

  Future<bool> onBack() async {
    var value = await _webView.canGoBack();
    if (value) {
      _webView.goBack();
      return false;
    }
    return true;
  }

  Future<bool> _onForward() async {
    var value = await _webView.canGoForward();
    if (value) {
      _webView.goForward();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: onBack,
          //_webView==null ? null : () async{ await _webView.canGoBack() ? _webView.goBack() },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: _onForward,
        ),
      ],
    );
  }
}