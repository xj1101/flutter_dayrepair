import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdaper{
  static init(context){
    ScreenUtil.instance = ScreenUtil(width: 720, height: 1284)..init(context);
  }

  static height(double value){
    return ScreenUtil.getInstance().setHeight(value);
  }

  static width(double value){
    return ScreenUtil.getInstance().setWidth(value);
  }

  ///当前设备高度dp
  static getScreenHeight(){
    return ScreenUtil.screenHeightDp;
  }

  ///当前设备宽度dp
  static getScreenWidth(){
    return ScreenUtil.screenWidthDp;
  }

  ///状态栏高度 dp 刘海屏会更高
  static getStatusBarHeight(){
    return ScreenUtil.statusBarHeight;
  }

  ///底部安全区距离 dp
  static getBottomBarHeight(){
    return ScreenUtil.bottomBarHeight;
  }

  /*设置字体大小 */
  static size(double vaule){
    return ScreenUtil.getInstance().setSp(vaule);
  }
}