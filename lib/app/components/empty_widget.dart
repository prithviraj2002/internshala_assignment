import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/assets.dart';

class EmptyWidget extends StatelessWidget{
  String title; String subTitle;
  EmptyWidget({this.title = "", this.subTitle = "", super.key});

  @override
  Widget build(BuildContext context){
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(Assets.pngsNoData),
            const SizedBox(height: 10,),
            Text(title, style: TextStyle(fontSize:20)),
            const SizedBox(height: 6,),
            Text(subTitle),
          ]
      ),);
  }
}