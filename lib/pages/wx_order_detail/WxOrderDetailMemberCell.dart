import 'package:flutter/material.dart';

import '../../services/XJExtension.dart';
import '../../services/ScreenAdaper.dart';
import '../../model/WxOrderDetailModel.dart';

class WxMemberCellPage extends StatelessWidget {
  
  final WxOrderDetailModel model;

  const WxMemberCellPage(this.model,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    var address = this.model.userAddress.provinceName+this.model.userAddress.cityName+this.model.userAddress.areaName+this.model.userAddress.addressDetail;
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text("会员信息",style: TextStyle(
              fontSize: ScreenAdaper.size(32),
              color: TextColor.drBrightTextColor
            )),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Text("${this.model.userAddress.consignee}",style: TextStyle(
                  fontSize: ScreenAdaper.size(26),
                  color: TextColor.drDarkTextTwoColor
                )),
                SizedBox(width: 50),
                Text("${this.model.userAddress.mobile}",style: TextStyle(
                  fontSize: ScreenAdaper.size(26),
                  color: TextColor.drDarkTextTwoColor
                ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(address,style: TextStyle(
              fontSize: ScreenAdaper.size(26),
              color: TextColor.drDarkTextTwoColor
            )),
          )
        ],
      )
    );
  }
}