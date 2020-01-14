import 'package:flutter/material.dart';

import '../../services/XJExtension.dart';

class WxOrderTopPage extends StatelessWidget {

  final Object cb;

  const WxOrderTopPage({Key key,this.cb=null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            child: Row(
              children: <Widget>[
                Text("服务方式"),
                Icon(Icons.arrow_drop_down,color: XJColors.hexColor(0x1F000000,alpha: 0.5))
              ],
            ),
            onTap: (){
              
            }
          ),
          InkWell(
            child: Row(
              children: <Widget>[
                Text("订单状态"),
                Icon(Icons.arrow_drop_down,color: XJColors.hexColor(0x1F000000,alpha: 0.5))
              ],
            ),
            onTap: this.cb,
          )
        ],
      ),
    );
  }
}