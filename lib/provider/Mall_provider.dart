import 'dart:core';
import 'package:flutter/material.dart';

class MallTJProvider with ChangeNotifier{

  bool _isScroller = false; //判断是否允许滚动

  bool get isScroller => this._isScroller;

  MallTJProvider(){
    this.init();
  }

  //初始化
  init(){
    this.setIsScroller(false);
    notifyListeners();
  }

  //设置是否允许滚动
  setIsScroller(value){
    this._isScroller = value;
    notifyListeners();
  }

}