import 'package:flutter/material.dart';

import '../../services/ScreenAdaper.dart';
import '../../services/XJExtension.dart';

class MyOrderItemPage extends StatelessWidget {

  final String title; 
  final String imageStr;
  final Object cb;
  final bool ishiddenTitle;
  final String numStr;

  const MyOrderItemPage({Key key,this.title="",this.imageStr="",this.cb=null,this.ishiddenTitle=true,this.numStr="0"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Container(
      child: InkWell(
        onTap: this.cb,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              // margin: EdgeInsets.only(top: ScreenAdaper.height(35)),
              child: this.ishiddenTitle?Image.asset(this.imageStr):Text(this.numStr,style: TextStyle(
                fontSize: ScreenAdaper.size(42),
                color: XJColors.hexColor(0x000000)
              )),
            ),
            Container(
              // margin: EdgeInsets.only(bottom: ScreenAdaper.height(20)),
              child: Text(this.title,style: TextStyle(
                color: XJColors.hexColor(0x000000),
                fontSize: ScreenAdaper.size(26)
              )),
            )
          ],
        ),
      ),
    );
  }
}

