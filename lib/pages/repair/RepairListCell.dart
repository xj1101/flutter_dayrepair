import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/XJExtension.dart';
import '../../services/ScreenAdaper.dart';

import '../../model/RepairListModel.dart';

class RepairListCell extends StatelessWidget {
  final RepairListItemModel model;

  const RepairListCell({Key key,this.model}) : super(key: key);

  ///自定义按钮
  Widget _inkWellButonWidget(String title,IconData icons,cb){
    return InkWell(
      onTap: cb,
      child: Row(
        children: <Widget>[
          Icon(icons,color: TextColor.drBrightTextColor,size: 20,),
          Text(title,style: TextStyle(
            fontSize: ScreenAdaper.size(26),
            color: TextColor.drBrightTextColor
          ))
        ],
      ),
    );
  }

  _launchURL(String url) async {
    // const url = 'tel:${this.model.suppliersPhone}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.black12
              ),
              top: BorderSide(
                width: 1,
                color: Colors.black12
              )
            )
          ),
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(this.model.suppliersName,style: TextStyle(
                  fontSize: ScreenAdaper.size(30),
                  color: TextColor.drDarkTextTwoColor,
                  fontFamily: "SourceHanSansCNBold"
                )),
                SizedBox(height: 5),
                Text("服务热线：${this.model.suppliersPhone}",style: TextStyle(
                  fontSize: ScreenAdaper.size(28),
                  color: TextColor.drDarkTextTwoColor,
                )),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("服务地址：",style: TextStyle(
                      fontSize: ScreenAdaper.size(28),
                      color: TextColor.drDarkTextTwoColor,
                    )),
                    Expanded(
                      child: Text(this.model.address,style: TextStyle(
                        fontSize: ScreenAdaper.size(28),
                        color: TextColor.drDarkTextTwoColor,
                        fontFamily: "SourceHanSansCNRegular"
                      )),
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    _inkWellButonWidget("联系客服", Icons.phone, (){
                      _launchURL('tel:${this.model.suppliersPhone}');
                    }),
                    SizedBox(width: 10),
                    _inkWellButonWidget("查看地址", Icons.pin_drop, (){
                       Navigator.pushNamed(context, "/webView",arguments: {
                         "url":this.model.url,
                         "title":this.model.suppliersName
                       });
                    })
                  ],
                ) 
              ],
            ),
          ),
        ),
        SizedBox(height: 15,)
      ],
    );
  }
}