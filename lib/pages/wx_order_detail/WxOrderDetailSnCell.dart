import 'package:flutter/material.dart';

import '../../services/XJExtension.dart';
import '../../services/ScreenAdaper.dart';
import '../../model/WxOrderDetailModel.dart';

class WxSnCellPage extends StatelessWidget {

  final WxOrderDetailModel model;

  const WxSnCellPage(this.model,{Key key}) : super(key: key);

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("订单编号：${this.model.orderSn}",style: TextStyle(
                  fontSize: ScreenAdaper.size(26),
                  color: TextColor.drDarkTextTwoColor
                )),
                Text(this.model.fault.length==0?"快速订单":model.statusName,style: TextStyle(
                  fontSize: ScreenAdaper.size(26),
                  color: TextColor.drBrightTextColor
                ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text("下单日期：${this.model.addTime}",style: TextStyle(
              fontSize: ScreenAdaper.size(26),
              color: TextColor.drDarkTextTwoColor
            )),
          ),
          this.model.serverTime.length==0?SizedBox():Container(
            margin: EdgeInsets.only(top: 10),
            child: Text("上门时间：${this.model.serverTime}",style: TextStyle(
              fontSize: ScreenAdaper.size(26),
              color: TextColor.drDarkTextTwoColor
            )),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text("服务方式：${this.model.serverType}",style: TextStyle(
              fontSize: ScreenAdaper.size(26),
              color: TextColor.drDarkTextTwoColor
            )),
          ),
        ],
      ),
    );
  }
}