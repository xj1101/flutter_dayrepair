import 'package:flutter/material.dart';
import 'package:flui/flui.dart';

import 'ScreenAdaper.dart';
import 'XJExtension.dart';

class XJLoadingEmpty extends StatelessWidget {

  final int dataCount;
  const XJLoadingEmpty({Key key,this.dataCount=-1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return this.dataCount!=0?FLEmptyContainer(
      showLoading: true,
      title: '正在加载中...',
      titleStyle: TextStyle(
        fontSize: ScreenAdaper.size(28)
      ),
      customLoadingWidget: CircularProgressIndicator(
        strokeWidth: 3.0,
        valueColor: AlwaysStoppedAnimation(TextColor.drBrightTextColor),
      ),
    ):FLEmptyContainer(
      image: Image.asset("images/n_order.png",width: 100,height: 100),
      title: "暂无数据",
      titleStyle: TextStyle(
        fontSize: ScreenAdaper.size(28)
      ),
    );
  }
}