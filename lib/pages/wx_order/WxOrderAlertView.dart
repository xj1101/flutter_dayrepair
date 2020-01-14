import 'package:dayrepair/thirdLibrary/drop_select_menu/drop_select_controller.dart';
import 'package:flutter/material.dart';

import '../../model/WxOrderTypeModel.dart';
import '../../services/XJExtension.dart';
import '../../services/XJButton.dart';
import '../../services/EventBus.dart';

import '../../thirdLibrary/drop_select_menu/drop_select_widget.dart';

typedef Widget MenuItemBuilder<T extends WxOrderTypeModel>(
    BuildContext context, T data);

const double kDropSelectMenuItemHeight = 45.0;

class WxOrderWrapListMenu<T extends WxOrderTypeModel> extends DropSelectWidget {
  final List<T> data;
  final MenuItemBuilder itemBuilder;
  final bool singleSelected;
  final double itemExtent;
  final Widget menuWidget;
  final String title;
  final int widgetIndex;
  WxOrderWrapListMenu(
      {this.data,
      this.singleSelected=false,
      this.itemBuilder,
      this.itemExtent:kDropSelectMenuItemHeight,
      this.menuWidget,
      this.title,
      this.widgetIndex=0}
    );

   @override
  DropSelectState<DropSelectWidget> createState() {
    return new _WxOrderMenuListState<T>();
  }
}

class _WxOrderMenuListState<T extends WxOrderTypeModel> extends DropSelectState<WxOrderWrapListMenu<T>> {
  int _selectIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: XJColors.hexColor(0x1F000000,alpha: 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
            child: Text(widget.title),
          ),
          Container(
            height: 150,
            margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
            child:  widget.menuWidget,
          ),
          XJButton( //135
            radius: 0,
            height: 50,
            color: TextColor.drBrightTextColor,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            text: "确定",
            cb: (){
              if(widget.widgetIndex==0){
                this._selectIndex = 1;
              }else{
                this._selectIndex = 2;
              }
              controller.hide();
            },
          )
        ],
      ),
    );
  }

  @override
  void onEvent(DropSelectEvent event) {
    switch (event) {
      case DropSelectEvent.SELECT:
        {}
        break;
      case DropSelectEvent.HIDE:
        {
          // eventBus.fire(WxOrderEvent(this._selectIndex));
          // this._selectIndex = 0;
          if(widget.widgetIndex==0){
            if(this._selectIndex == 1){
              this._selectIndex = 1;
            }else{
              this._selectIndex = -1;
            }
          }else{
            if(this._selectIndex == 2){
              this._selectIndex = 2;
            }else{
              this._selectIndex = -2;
            }
          }
          eventBus.fire(WxOrderEvent(this._selectIndex));
          print("消失消失消失");
        }
        break;
      case DropSelectEvent.ACTIVE:
        {}
        break;
    }
  }
}
