import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier{

  //判断是否登录了
  bool _isLogined = false;

  bool get isLogined => this._isLogined;

  UserProvider(){
    this.init();
  }

  //初始化
  init(){
    this.setIsLogined(false);
    notifyListeners();
  }

  //设置是否登了
  setIsLogined(value){
    this._isLogined = value;
    notifyListeners();
  }

}