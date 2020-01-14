import 'package:flutter/material.dart';

class XJColors {
   /// 十六进制颜色，
   /// hex, 十六进制值，例如：0xffffff,
   /// alpha, 透明度 [0.0,1.0]
   static Color hexColor(int hex,{double alpha = 1}){
    if (alpha < 0){
      alpha = 0;
    }else if (alpha > 1){
      alpha = 1;
    }
    return Color.fromRGBO((hex & 0xFF0000) >> 16 ,
         (hex & 0x00FF00) >> 8,
         (hex & 0x0000FF) >> 0,
         alpha);
   }
}

//判断当前时间处于什么阶段(早上，下午，晚上)
class NightType{
  static String nightTime(){
    DateTime time = DateTime.now();
    if(time.hour >= 0 && time.hour < 12){
      return "早上好。";
    }else if(time.hour >= 12 && time.hour < 18){
      return "下午好。";
    }else{
      return "晚上好。";
    }
  }
}

class TextColor{
  //文字亮色 
  static Color drBrightTextColor = XJColors.hexColor(0x3475ec);
  //文字暗色
  static Color drDarkTextTwoColor = XJColors.hexColor(0x282828);
  //文字暗色
  static Color drDarkTextColor = XJColors.hexColor(0xa1a1a1);
}

