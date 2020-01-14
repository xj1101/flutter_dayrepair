import 'package:flutter/material.dart';

import '../../services/XJExtension.dart';
import '../../services/ScreenAdaper.dart';
import '../../model/WxOrderDetailModel.dart';

class WxStoreCellPage extends StatelessWidget {

  final WxOrderDetailModel model;

  const WxStoreCellPage(this.model,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text("门店信息",style: TextStyle(
              fontSize: ScreenAdaper.size(32),
              color: TextColor.drBrightTextColor
            )),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Text("${this.model.storeData.storeName}",style: TextStyle(
                  fontSize: ScreenAdaper.size(26),
                  color: TextColor.drDarkTextTwoColor
                )),
                SizedBox(width: 50),
                Text("${this.model.storeData.mobile}",style: TextStyle(
                  fontSize: ScreenAdaper.size(26),
                  color: TextColor.drDarkTextTwoColor
                ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text("${this.model.storeData.address}",style: TextStyle(
              fontSize: ScreenAdaper.size(26),
              color: TextColor.drDarkTextTwoColor
            )),
          )
        ],
      )
    );
  }
}