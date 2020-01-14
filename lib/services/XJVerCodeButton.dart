import 'dart:async';

import 'package:flutter/material.dart';

import 'XJExtension.dart';
import 'ScreenAdaper.dart';

class XJVerCodeButton extends StatefulWidget {
  
  final int countdown; //倒计时的秒数，默认60秒
  final Function onTapCallback; //用户点击时的回调函数
  final bool available;

  XJVerCodeButton(
    {this.countdown=60,
    this.onTapCallback,
    this.available=false}
  );

  _XJVerCodeButtonState createState() => _XJVerCodeButtonState();
}

class _XJVerCodeButtonState extends State<XJVerCodeButton> {

  Timer _timer; //倒计时的计时器
  int _seconds; //当前倒计时的秒数
  String _verifyStr = "获取验证码"; ////当前墨水瓶（"InkWell"）的文本
  bool isClickDisable=false;//防止点击过快导致Timer出现无法停止的问题

  @override
  void initState() {
    _seconds = widget.countdown;
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  //启动倒计时计时器
  void _startTimer() {
    isClickDisable=true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _seconds = widget.countdown;
        _verifyStr = "重新发送";
        setState(() {});
        _cancleTimer();
        return;
      }
      _seconds--;
      _verifyStr = "已发送$_seconds" + "s";
      setState(() {});
    });
  }
   
   //取消到倒计时的计时器
  void _cancleTimer() {
    isClickDisable=false;
    _timer?.cancel();
  }
  
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return widget.available?InkWell(
      onTap: (_seconds == widget.countdown)&&!isClickDisable?(){
        _startTimer();
        _verifyStr = "已发送$_seconds" + "s";
        setState(() {});
        widget.onTapCallback();
      }:null,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
        width: 90,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: TextColor.drBrightTextColor
          ),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Center(
          child: Text(_verifyStr,style: TextStyle(
            fontSize: ScreenAdaper.size(26),
            color: TextColor.drBrightTextColor
          )),
        ),
      ),
    ):Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
      width: 90,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: TextColor.drBrightTextColor
        ),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Center(
        child: Text("获取验证码",style: TextStyle(
          fontSize: ScreenAdaper.size(26),
          color: TextColor.drBrightTextColor
        )),
      ),
    );
  }
}