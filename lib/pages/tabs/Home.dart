import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:date_format/date_format.dart';
import 'package:amap_location/amap_location.dart';

import '../../services/ScreenAdaper.dart'; //屏幕适配
import '../../network/Network.dart'; //网络配置

import '../home/Home_tj.dart'; //推荐
import '../home/Home_zx.dart'; //屏幕专修
import '../home/Home_other.dart'; //其它

import '../../model/HomeDataModel.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //首页数据模型
  HomeDataModel _homeDataModel;

  @override
  void initState() { 
    super.initState();
    _postHomeData();
    _loactionMap();
  }

  void _loactionMap()async{
  await AMapLocationClient.startup(new AMapLocationOption( desiredAccuracy:CLLocationAccuracy.kCLLocationAccuracyHundredMeters  ));
  await AMapLocationClient.getLocation(true);
}

  //获取首页数据
  _postHomeData() async{
     var api = Network.domain + Network.drxserviceIndexUrl;
     var result = await Dio().post(api,options: Network.aaHeaders);
     Map<String, dynamic> resultJson = json.decode(result.data);
     var model = HomeDataModel.fromJson(resultJson);
     
     setState(() {
       this._homeDataModel = model;
     });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenAdaper.getScreenWidth()-40,
                child: TabBar(
                  indicatorColor: Colors.blue,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.black87,
                  isScrollable: true, //是否允许滚动
                  labelPadding: EdgeInsets.fromLTRB(11, 0, 11, 0),
                  tabs: <Widget>[
                    Tab(child: Text("推荐")),
                    Tab(child: Text("屏幕专修")),
                    Tab(child: Text("电池换新")),
                    Tab(child: Text("内存升级")),
                    Tab(child: Text("其它")),
                  ],
                ),
              )
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            TabBarView(
              children: <Widget>[
                this._homeDataModel != null?HomeTJPage(this._homeDataModel):Text(""),
                this._homeDataModel != null?HomeZXPage(this._homeDataModel,this._homeDataModel.data.replaceScreenImg):Text(""),
                this._homeDataModel != null?HomeZXPage(this._homeDataModel,this._homeDataModel.data.replaceBatteryImg):Text(""),
                this._homeDataModel != null?HomeZXPage(this._homeDataModel,"http://img.dangrixiu.cn/memory_top_image.png"):Text(""),
                HomeOtherPage()
              ],
            )
          ],
        ),
      ),
    );
  }
}