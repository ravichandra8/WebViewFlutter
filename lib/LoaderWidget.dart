import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadgerWidget extends StatelessWidget{
  final Widget child;
  final bool showLoader;

  LoadgerWidget({
    @required this.child,
    @required this.showLoader
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = new List<Widget>();
    widgetList.add(child);
    if(showLoader){
     final loaderWidget= new Center(child: CircularProgressIndicator());
      widgetList.add(loaderWidget);
    }
    return Stack(children: widgetList);
  }


}