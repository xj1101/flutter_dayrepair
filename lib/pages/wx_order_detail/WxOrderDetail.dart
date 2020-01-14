import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/XJExtension.dart';
import '../../services/IsLoginSerVices.dart';
import '../../network/Network.dart';
import '../../services/Storage.dart';
import '../../services/EventBus.dart';
import '../../services/XJLoadingEmpty.dart';
import '../../model/WxOrderDetailModel.dart';

import 'WxOrderDetailSnCell.dart';
import 'WxOrderDetailiPhoneCell.dart';
import 'WxOrderDetailMemberCell.dart';
import 'WxOrderDetailStoreCell.dart';

class WxOrderDetailPage extends StatefulWidget {
  
  final Map arguments;
  
  WxOrderDetailPage({Key key,this.arguments}) : super(key: key);

  _WxOrderDetailPageState createState() => _WxOrderDetailPageState();
}

class _WxOrderDetailPageState extends State<WxOrderDetailPage> {

  //订单详情模型
  WxOrderDetailModel detailModel;

  @override
  void initState() { 
    super.initState();
    _getIsLoginToken();
  }

  ///获取登录token请求数据
  _getIsLoginToken() {
    var loginToken =  IsLoginSerVices.getLoginToken();
    loginToken.then((var token) async{
      Options header = Network.aaHeadersDevice(token.toString());
       Map parameters = {
        "order_id":widget.arguments["orderId"],
      };
      var api = Network.domain + Network.drOrderDetailUrl;
      var result = await Dio().post(api,data: parameters,options: header);
      Map<String, dynamic> resultJson = json.decode(result.data);
      // print("=======分割线============${result.data}");
      if(resultJson["status"]==1){
        var model = WxOrderDetailModel.fromJson(resultJson["data"]);
        // print("=======分割线============${model.phoneCat}");
        setState(() {
          this.detailModel = model;
        });
      }else if(resultJson["status"]==-20){
        Storage.remove("isLogin");
        eventBus.fire(UserEvent("重新登录"));
        Fluttertoast.showToast(
          msg: resultJson["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        Navigator.pop(context);
      }
    });
  }

  //分割线
  Widget _lineWidget(){
    return Container(
      height: 10,
      margin: EdgeInsets.only(top: 10),
      color: XJColors.hexColor(0x1F000000,alpha: 0.05),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("订单详情"),
       ),
       body: this.detailModel==null?XJLoadingEmpty():ListView(
         children: <Widget>[
           WxSnCellPage(this.detailModel),
           _lineWidget(),
           this.detailModel.fault.length>0?WxIphoneCellPage(this.detailModel):SizedBox(),
           this.detailModel.fault.length>0?_lineWidget():SizedBox(),
           WxMemberCellPage(this.detailModel),
           _lineWidget(),
           WxStoreCellPage(this.detailModel)
         ],
       ),
    );
  }
}