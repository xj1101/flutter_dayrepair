import 'package:flutter/material.dart';

import '../../services/XJExtension.dart';
import '../../services/ScreenAdaper.dart';
import '../../services/XJDottedLine.dart';
import '../../model/WxOrderDetailModel.dart';

class WxIphoneCellPage extends StatelessWidget {

  final WxOrderDetailModel model;

  const WxIphoneCellPage(this.model,{Key key}) : super(key: key);

  //机型信息item组件
  Widget _iphoneItemWidget(Fault falutModel){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("${falutModel.faultName}",style: TextStyle(
                fontSize: ScreenAdaper.size(26),
                color: TextColor.drDarkTextTwoColor
              )),
              Text("￥${falutModel.price}",style: TextStyle(
                fontSize: ScreenAdaper.size(26),
                color: TextColor.drDarkTextTwoColor
              ))
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text("初步方案:",style: TextStyle(
            fontSize: ScreenAdaper.size(26),
            color: TextColor.drDarkTextTwoColor
          )),
        ),
        Column(
          children: falutModel.faultData.map((dataModel){
            return Container(
              margin: EdgeInsets.only(top: 5,left: 15),
              child: Text("${dataModel.solutionName}",style: TextStyle(
                fontSize: ScreenAdaper.size(26),
                color: TextColor.drDarkTextTwoColor
              )),
            );
          }).toList(),
        )
      ],
    );
  }
  
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
            child: Text("机型信息",style: TextStyle(
              fontSize: ScreenAdaper.size(32),
              color: TextColor.drBrightTextColor
            )),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("${this.model.phoneName}",style: TextStyle(
                  fontSize: ScreenAdaper.size(26),
                  color: TextColor.drDarkTextTwoColor
                )),
                Text("${this.model.colorName}",style: TextStyle(
                  fontSize: ScreenAdaper.size(26),
                  color: TextColor.drDarkTextTwoColor
                ))
              ],
            ),
          ),
          Container(
            child: Column(
              children: this.model.fault.map((value){
                return _iphoneItemWidget(value);
              }).toList(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: DottedLine(),
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Text("预估价格:",style: TextStyle(
                      fontSize: ScreenAdaper.size(26),
                      color: TextColor.drDarkTextTwoColor
                    )),
                  ),
                  Text("￥${this.model.predictPrice}",style: TextStyle(
                    fontSize: ScreenAdaper.size(38),
                  color: TextColor.drBrightTextColor
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}