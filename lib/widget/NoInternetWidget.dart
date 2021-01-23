import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
            body: Center(
              child: Text(
                  "No internet Connection. Please note that this app works with internet only."),
            )));
  }
}