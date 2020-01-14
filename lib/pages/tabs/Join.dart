import 'package:flutter/material.dart';

import '../../services/ScreenAdaper.dart';
import '../../services/XJExtension.dart';

class JoinPage extends StatefulWidget {
  JoinPage({Key key}) : super(key: key);

  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    var titleArray = ["・本人身份证","・手持证件照","・营业许可证(工程师加盟可不用)"];
    var imageArray = [
      {"image":"images/join_dp.png","title":"店铺加盟"},
      {"image":"images/join_gcsjm.png","title":"工程师加盟"}
    ];
    return Scaffold(
      //  appBar: AppBar(
      //    elevation: 0.0,
      //    title: Text(''),
      //  ),
       body: ListView(
         children: <Widget>[
           SizedBox(height: ScreenAdaper.getStatusBarHeight()),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Image.asset("images/drx_smallLogon.png",fit: BoxFit.cover),
               SizedBox(width: 5),
               Text("当日修提示您",style: TextStyle(
                 fontSize: ScreenAdaper.size(48),
                 color: TextColor.drBrightTextColor
               ))
             ],
           ),
           Container(
             margin: EdgeInsets.fromLTRB(15, 20, 15, 10),
             child: Text("填写资料预计需要 3~5分钟，为确保您能够顺利提交加盟申请，请您准备好申请所需要的如下资质证件，并确保您提供的资料及填写信息真实有效：",style: TextStyle(
               fontSize: ScreenAdaper.size(28),
               color: TextColor.drDarkTextTwoColor
             )),
           ),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: titleArray.map((value){
               return Container(
                 margin: EdgeInsets.fromLTRB(30, 0, 0, 10),
                 child: Text(value,style: TextStyle(
                   fontSize: ScreenAdaper.size(26),
                   color: TextColor.drBrightTextColor
                 )),
               );
             }).toList(),
           ),
           Container(
             margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: imageArray.map((value){
                return InkWell(
                  child: Container(
                    width: (ScreenAdaper.getScreenWidth()-110)/2,
                    height: (ScreenAdaper.getScreenWidth()-110)/2-30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 1,
                          color: Color.fromARGB(20, 0, 0, 0),
                        )
                      ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          // margin: EdgeInsets.only(top: ScreenAdaper.height(40)),
                          width: 36,
                          height: 36,
                          child: Image.asset(value["image"],fit: BoxFit.cover),
                        ),
                        Container(
                          // margin: EdgeInsets.only(bottom: ScreenAdaper.height(30)),
                          child: Text(value["title"],style: TextStyle(
                            color: TextColor.drBrightTextColor
                          )),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
           ),
           Container(
             height: 100,
             margin: EdgeInsets.only(top: ScreenAdaper.height(240)),
             child: Column(
               children: <Widget>[
                 Image.asset("images/join_tc.png",fit: BoxFit.cover),
                 InkWell(
                   child: Container(
                     margin: EdgeInsets.only(top: 10),
                     child: Text("《当日修加盟协议》",style: TextStyle(
                      color: TextColor.drBrightTextColor,
                      decoration: TextDecoration.underline
                    )),
                   ),
                 )
               ],
             ),
           )
         ],
       ),
    );
  }
}