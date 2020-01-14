import 'dart:convert';
import 'package:dayrepair/services/XJExtension.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../services/ScreenAdaper.dart';
import '../../model/RepairDeviceModel.dart';
import '../../network/Network.dart'; //网络配置

class RepairDevice extends StatefulWidget {
  RepairDevice({Key key}) : super(key: key);

  _RepairDeviceState createState() => _RepairDeviceState();
}

class _RepairDeviceState extends State<RepairDevice> {

  List<RepairDeviceDataListModel> _listModelArray = [];
  List<PhoneDataModel> _phoneDataArray = [];
  //type: type=1表示手机 【默认1】 type=2 表示ipad
  String _type = "1";
  ///搜索的关键词
  String _keyword = "";
  ///记录左边点击的下标
  int _leftSelectedIndex=0;
  ///判断是否处于iPad系列
  bool _isiPad = false;

  @override
  void initState() { 
    super.initState();
    _postRepairData();
  }
  //获取首页数据
  _postRepairData() async{
     var api = Network.domain + Network.drxphoneTypeUrl;
     var result = await Dio().post(api,options: Network.aaHeaders,queryParameters: {"type":this._type,"keyword":this._keyword});
     Map<String, dynamic> resultJson = json.decode(result.data);
     var model = RepairDeviceModel.fromJson(resultJson);
     
     setState(() {
       this._listModelArray = model.data.list;
       this._phoneDataArray = model.data.list.first.phoneData;
     });

  }
  //搜索框
  Widget _searchWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: ScreenAdaper.getScreenWidth()-130,
          height: ScreenAdaper.height(70),
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 1,
              color: XJColors.hexColor(0xa1a1a1)
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("请输入您选择的机型",style: TextStyle(
                fontSize: ScreenAdaper.size(24),
                color: XJColors.hexColor(0xa1a1a1)
              )),
              SizedBox(width: 10),
              Icon(Icons.search,color: XJColors.hexColor(0xa1a1a1))
            ],
          ),
        ),
        InkWell(
          onTap: (){
            this._isiPad = !this._isiPad;
            this._leftSelectedIndex=0;
            this._type=this._isiPad?"2":"1";
            this._postRepairData();
          },
          child: Text(this._isiPad?"手机系列":"iPad系列",style: TextStyle(
            fontSize: ScreenAdaper.size(32),
            color: XJColors.hexColor(0x3475ec)
          )),
        )
      ],
    );
  }

  //左侧 
  Widget _leftViewWidget(width){
    if(this._listModelArray.length>0){
      return Container(
        width: width,
        height: double.infinity,
        child: ListView.builder(
          itemCount: this._listModelArray.length,
          itemBuilder: (context,index){
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: (){
                    setState(() {
                      this._leftSelectedIndex = index;
                      this._phoneDataArray = this._listModelArray[index].phoneData;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: ScreenAdaper.height(80),
                    color: this._leftSelectedIndex==index?Colors.white:XJColors.hexColor(0xa1a1a1,alpha: 0.1),
                    child: Center(
                      child: Text(this._listModelArray[index].name,style: TextStyle(
                        fontSize: ScreenAdaper.size(28),
                        color: XJColors.hexColor(0x282828)
                      )),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1.5,
                  color: this._leftSelectedIndex==index?XJColors.hexColor(0x3475ec):XJColors.hexColor(0xa1a1a1,alpha: 0.1),
                )
              ],
            );
          },
        ),
      );
    }else{
      return Container(
        width: width,
        height: double.infinity,
        child: Text(""),
      );
    }
    
  }

  //右侧
  Widget _rightViewWidget(width){
    return Expanded(
      flex: 1,
      child: Container(
        height: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: ScreenAdaper.height(80),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("---------"),
                  Text("品牌机型",style: TextStyle(
                        fontSize: ScreenAdaper.size(30),
                        color: XJColors.hexColor(0x282828)
                      )),
                  Text("---------")
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ListView(
                  children: <Widget>[
                    Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: this._phoneDataArray.map((value){
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).pop(value.name);
                          },
                          child: Container(
                            width: width,
                            height: ScreenAdaper.height(70),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: XJColors.hexColor(0xa1a1a1,alpha: 0.1),
                            ),
                            child: Center(
                              child: Text(value.name,style: TextStyle(
                                fontSize: ScreenAdaper.size(24),
                                color: XJColors.hexColor(0x282828,alpha: 1)
                              )),
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    //计算右侧宽高逼
    var leftWidth = ScreenAdaper.getScreenWidth()/4;
    var rightItemWidth = (ScreenAdaper.getScreenWidth()-leftWidth-30)/2;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("维修设备"),
      ),
      body: Column(
        children: <Widget>[
          _searchWidget(),
          SizedBox(height: 10),
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                _leftViewWidget(leftWidth),
                _rightViewWidget(rightItemWidth)
              ],
            ),
          )
        ],
      )
    );
  }
}