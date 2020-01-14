import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../services/XJAlertStatus.dart';
import 'Network.dart';

class AAHttpManager{
  ///===========POST网络请求(自定义请求头)============
  static postHttpHeaderRequest({
    Map<String, dynamic> params,
    String token,
    String url,
    BuildContext context
  })async{
    Options header = Network.aaHeadersDevice(token);
    var api = Network.domain + url;
    var result = await Dio().post(api,data: params,options: header);
    Map<String, dynamic> resultJson = json.decode(result.data);
    if(resultJson["status"]==1){
        return resultJson;
    }else if(resultJson["status"]==-20){
      XJAlertStatus.alertStatus(resultJson["msg"], context);
    }
  }

  ///===========POST网络请求(自定义请求头)============
  static postHttpRequest({
    Map<String, dynamic> params,
    String url,
    BuildContext context
  })async{
    var api = Network.domain + url;
    var result = await Dio().post(api,data: params,options: Network.aaHeaders);
    Map<String, dynamic> resultJson = json.decode(result.data);
    if(resultJson["status"]==1){
        return resultJson;
    }else if(resultJson["status"]==-20){
      XJAlertStatus.alertStatus(resultJson["msg"], context);
    }
  }
}