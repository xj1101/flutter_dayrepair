import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart';  

import '../../services/ScreenAdaper.dart';
import '../../services/XJExtension.dart';
import '../../model/CouponListModel.dart';

class CouponListNCell extends StatelessWidget {

  final CouponListItemModel model;

  const CouponListNCell({Key key,this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    DateTime useStartDateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(this.model.useStartTime)*1000);
    String useStartTime =DateUtil.formatDate(useStartDateTime,format: "yyyy.MM.dd");
    DateTime useEndDateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(this.model.useEndTime)*1000);
    String useEndTime =DateUtil.formatDate(useEndDateTime,format: "yyyy.MM.dd");
    return Column(
      children: <Widget>[
        Container(
          height: 150,
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Stack(
            children: <Widget>[
              Image.asset("images/drx_couponN.png",fit: BoxFit.cover),
              Positioned(
                left: 15,
                top: 17.5,
                child: Text("维修专业劵",style: TextStyle(
                  fontSize: ScreenAdaper.size(24),
                  color: TextColor.drBrightTextColor
                )),
              ),
              Positioned(
                left: 25,
                top: 45,
                child: Text("¥${this.model.money}",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenAdaper.size(56),
                  color: TextColor.drBrightTextColor
                )),
              ),
              Positioned(
                left: 50,
                top: 85,
                child: Text("优惠券",style: TextStyle(
                  fontSize: ScreenAdaper.size(28),
                  color: TextColor.drBrightTextColor
                )),
              ),
              Positioned(
                left: 10,
                bottom: 10,
                child: Text("当前下单仅限使用一张",style: TextStyle(
                  fontSize: ScreenAdaper.size(24),
                  color: Colors.white
                )),
              ),
              Positioned(
                left: ScreenAdaper.width(350),
                top: 30,
                child: Text("满${this.model.condition}元使用",style: TextStyle(
                  fontSize: ScreenAdaper.size(24),
                  color: TextColor.drBrightTextColor
                )),
              ),
              Positioned(
                left: ScreenAdaper.width(350),
                top: 60,
                child: Text("使用期限:",style: TextStyle(
                  fontSize: ScreenAdaper.size(24),
                  color: TextColor.drBrightTextColor
                )),
              ),//2018.12.30-2019.06.01
              Positioned(
                left: ScreenAdaper.width(350),
                top: 80,
                child: Text("${useStartTime}-${useEndTime}",style: TextStyle(
                  fontSize: ScreenAdaper.size(24),
                  color: TextColor.drBrightTextColor
                )),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        
      ],
    );
  }
}