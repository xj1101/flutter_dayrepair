import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ScreenAdaper.dart'; 

class XJalertView{
  static showAlertDialog(BuildContext context,String title,String content,void onConfirmback()){
    ScreenAdaper.init(context);
    showDialog(
      context: context,
      builder: (context){
        return CupertinoAlertDialog(
          title: Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(title),
          ),
          content: Container(
            child: Text(content,style: TextStyle(
              fontFamily: "SourceHanSansCNRegular",
              fontSize: ScreenAdaper.size(26)
            )),
          ),
          actions: <Widget>[
            CupertinoButton(
              child: Text("取消",style: TextStyle(
                color: Colors.red
              )),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            CupertinoButton(
              child: Text("确定"),
              onPressed: (){
                Navigator.pop(context);
                onConfirmback();
              },
            )
          ],
        );
      }
    );
  }
}