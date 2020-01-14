import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/EventBus.dart';
import 'Storage.dart';

class XJAlertStatus{
  static alertStatus(String msg,BuildContext context){
    Storage.remove("isLogin");
    Storage.remove("token");
    eventBus.fire(UserEvent("重新登录"));
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
    Future.delayed(Duration(seconds: 1),(){
      Navigator.pop(context);
    });
  }
}