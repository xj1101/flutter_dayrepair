import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/XJExtension.dart';
import '../../services/ScreenAdaper.dart';
import '../../services/XJVerCodeButton.dart';

class NewlyTextView extends StatelessWidget {

  ///标题文字
  final String leftTitle;
  ///提示文字
  final String hintText;
  ///键盘类型
  final TextInputType keyboardType;
  ///格式类型
  final List<TextInputFormatter> inputFormatters;
  ///右边类型控件
  final int index;
  //用户点击时的回调函数
  final Function onTapCallback;  
  ///内容
  final String labelText;
  ///监听内容变化
  final Object onChanged;
  ///是否允许编辑
  final enabled;

  final TextEditingController controller;
  ///lable内容
  final String addContent;
  //able内容点击时的回调函数
  final Function addContentTapCallback;  

  const NewlyTextView(
    {this.leftTitle="手机号",
    this.hintText="请输入内容",
    this.keyboardType=TextInputType.text,
    this.inputFormatters=null,
    this.index=0,
    this.onTapCallback=null,
    this.labelText,
    this.onChanged,
    this.enabled,
    this.controller,
    this.addContent="选择您的地区",
    this.addContentTapCallback=null}
  );
  
  Widget _rightWidget(){
    switch (this.index) {
      case 1:
        return XJVerCodeButton(
          available: true,
          onTapCallback: (){
            print("回调成功");
          },
        );
        break;
      case 2:
        return InkWell(
          onTap: this.onTapCallback,
          child: Container(
            margin: EdgeInsets.only(right: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(Icons.place,color: TextColor.drBrightTextColor,),
                Text("自动获取",style: TextStyle(
                  fontSize: ScreenAdaper.size(24),
                  color: TextColor.drBrightTextColor
                ))
              ],
            ),
          ),
        );
        break;
      default:
        return Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
      height: ScreenAdaper.height(100),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12
          )
        )
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenAdaper.width(105),
            child: Text(this.leftTitle,style: TextStyle(
              fontSize: ScreenAdaper.size(30),
              color: TextColor.drDarkTextTwoColor
            )),
          ),
          Container(
            width: 1,
            height: ScreenAdaper.height(45),
            color: Colors.black12,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
              child: this.index!=2?TextField(
                controller: this.controller,
                keyboardType: this.keyboardType,
                autocorrect: true,
                inputFormatters: this.inputFormatters,
                enabled: this.enabled,
                maxLength: null,
                style: TextStyle(
                  fontSize: ScreenAdaper.size(28),
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  labelText: this.labelText,
                  labelStyle: TextStyle(
                    fontSize: ScreenAdaper.size(28),
                    // color: Colors.black87
                  ),
                  hintText: this.hintText,
                  hintStyle: TextStyle(
                    fontSize: ScreenAdaper.size(28),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none
                  ),
                ),
                onChanged: this.onChanged,
              ):InkWell(
                onTap: this.addContentTapCallback,
                child: Container(
                  height: double.infinity,
                  margin: EdgeInsets.only(left: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(this.addContent,style:TextStyle(
                      fontSize: ScreenAdaper.size(28),
                      color: this.addContent=="选择您的地区"?Colors.black54:null
                    )),
                  ),
                ),
              ),
            ),
          ),
          _rightWidget()
        ],
      ),
    );
  }
}