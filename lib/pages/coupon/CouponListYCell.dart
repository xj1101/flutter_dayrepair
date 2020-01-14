import 'package:flutter/material.dart';

import '../../services/ScreenAdaper.dart';
import '../../services/XJExtension.dart';

class CouponListYCell extends StatelessWidget {
  const CouponListYCell({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Column(
      children: <Widget>[
        Container(
          height: 150,
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Stack(
            children: <Widget>[
              Image.asset("images/drx_couponY.png",fit: BoxFit.cover),
              Positioned(
                left: 15,
                top: 17.5,
                child: Text("维修专业劵",style: TextStyle(
                  fontSize: ScreenAdaper.size(24),
                  color: Colors.white
                )),
              ),
              Positioned(
                left: 25,
                top: 45,
                child: Text("¥30",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenAdaper.size(56),
                  color: Colors.white
                )),
              ),
              Positioned(
                left: 50,
                top: 85,
                child: Text("优惠券",style: TextStyle(
                  fontSize: ScreenAdaper.size(28),
                  color: Colors.white
                )),
              ),
              Positioned(
                left: 10,
                bottom: 10,
                child: Text("该优惠券已过期",style: TextStyle(
                  fontSize: ScreenAdaper.size(24),
                  color: TextColor.drBrightTextColor
                )),
              ),
              Positioned(
                left: ScreenAdaper.width(350),
                top: 30,
                child: Text("满500元使用",style: TextStyle(
                  fontSize: ScreenAdaper.size(24),
                  color: Colors.white
                )),
              ),
              Positioned(
                left: ScreenAdaper.width(350),
                top: 60,
                child: Text("使用期限:",style: TextStyle(
                  fontSize: ScreenAdaper.size(24),
                  color: Colors.white
                )),
              ),
              Positioned(
                left: ScreenAdaper.width(350),
                top: 80,
                child: Text("2018.12.30-2019.06.01",style: TextStyle(
                  fontSize: ScreenAdaper.size(24),
                  color: Colors.white
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