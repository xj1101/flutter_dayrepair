import 'package:flutter/material.dart';

import '../my/MyCell.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text("帮助中心"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            MycellPage(
              leftTitle: "质保协议",
              cb: (){
                
              },
            ),
            Divider(height: 0),
            MycellPage(
              leftTitle: "维修协议",
              cb: (){
                
              },
            ),
            Divider(height: 0),
            MycellPage(
              leftTitle: "常见问题",
              cb: (){
                
              },
            ),
            Divider(height: 0),
            MycellPage(
              leftTitle: "建议与投诉",
              cb: (){
                
              },
            ),
            Divider(height: 0),
          ],
        ),
      ),
    );
  }
}