import 'package:flutter/material.dart';

import '../../services/ScreenAdaper.dart';
import '../../services/XJExtension.dart';

class MycellPage extends StatelessWidget {

  final String leftTitle;
  final String rightTitle;
  final Object cb;
  const MycellPage({Key key,this.leftTitle="",this.rightTitle="",this.cb=null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Container(
      height: ScreenAdaper.height(80),
      margin: EdgeInsets.only(bottom: ScreenAdaper.height(20)),
      child: ListTile(
        onTap: this.cb,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(this.leftTitle,style: TextStyle(
              fontSize: ScreenAdaper.size(28),
              color: XJColors.hexColor(0x000000)
            )),
            Text(this.rightTitle,style: TextStyle(
              fontSize: ScreenAdaper.size(28),
              color: XJColors.hexColor(0xa1a1a1)
            ))
          ],
        ),
        trailing: Icon(Icons.navigate_next),
      ),
    );
  }
}