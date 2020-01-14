import 'package:flutter/material.dart';

import '../../services/XJExtension.dart';
import '../../services/ScreenAdaper.dart';
import '../../model/WxOrderListModel.dart';

class WxOrderCellPage extends StatelessWidget {
  
  final WxOrderListItemModel model;
  const WxOrderCellPage(this.model,{Key key}) : super(key: key);

  ///绘制虚线
  Widget _xuxianWidget(){
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 10.0;
        final dashHeight = 2.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor()+5;
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: XJColors.hexColor(0xa1a1a1)),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }

  //按钮
  Widget _wxButtonWidget(String title,cb){
    return InkWell(
      onTap: cb,
      child: Container(
        height: 32,
        width: 100,
        margin: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 1,
            color: TextColor.drBrightTextColor
          )
        ),
        child: Center(
          child: Text(title,style: TextStyle(
            fontSize: ScreenAdaper.size(26),
            color: TextColor.drBrightTextColor
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Column(
      children: <Widget>[
        Container(
          height: 10,
          color: XJColors.hexColor(0x1F000000,alpha: 0.05),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("订单编号：${model.orderSn}",style: TextStyle(
                        fontSize: ScreenAdaper.size(26),
                        color: TextColor.drDarkTextTwoColor
                      )),
                      Text(model.isQuick=="1"?"快速订单":model.statusName,style: TextStyle(
                        fontSize: ScreenAdaper.size(26),
                        color: TextColor.drBrightTextColor
                      ))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text("下单日期：${model.addTime}",style: TextStyle(
                    fontSize: ScreenAdaper.size(26),
                    color: TextColor.drDarkTextTwoColor
                  )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text("上门时间：${model.serverTime}",style: TextStyle(
                    fontSize: ScreenAdaper.size(26),
                    color: TextColor.drDarkTextTwoColor
                  )),
                ),
                model.isQuick=="1"?SizedBox():Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("iPhone6",style: TextStyle(
                        fontSize: ScreenAdaper.size(26),
                        color: TextColor.drDarkTextTwoColor
                      )),
                      Text("深空灰",style: TextStyle(
                        fontSize: ScreenAdaper.size(26),
                        color: XJColors.hexColor(0x7b7b7b)
                      ))
                    ],
                  ),
                ),
                model.isQuick=="1"?SizedBox():Column(
                  children: model.fault.map((value){
                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(value.faultName,style: TextStyle(
                            fontSize: ScreenAdaper.size(26),
                            color: TextColor.drDarkTextTwoColor
                          )),
                          Text("￥${value.price}",style: TextStyle(
                            fontSize: ScreenAdaper.size(26),
                            color: TextColor.drDarkTextTwoColor
                          ))
                        ],
                      ),
                    );
                  }).toList(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: _xuxianWidget(),
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
                      Text("￥${model.totalPrice}",style: TextStyle(
                        fontSize: ScreenAdaper.size(38),
                      color: TextColor.drBrightTextColor
                    ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    _wxButtonWidget("联系客服",(){

                    }),
                    _wxButtonWidget("订单详情",(){
                      Navigator.pushNamed(context, "/wxOrderDetail",arguments: {
                        "orderId":model.orderId
                      });
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20)
      ],
    );
  }
}