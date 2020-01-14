import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../thirdLibrary/drop_select_menu/drop_select_header.dart';
import '../../thirdLibrary/drop_select_menu/drop_select_menu.dart';
import '../../thirdLibrary/drop_select_menu/drop_select_widget.dart';
// import '../../thirdLibrary/drop_select_menu/drop_select_controller.dart';
// import '../../thirdLibrary/drop_select_menu/drop_select_demo_data.dart';
// import '../../thirdLibrary/drop_select_menu/drop_select_expanded_menu.dart';
// import '../../thirdLibrary/drop_select_menu/drop_select_object.dart';
import '../../services/XJExtension.dart';
import '../../services/ScreenAdaper.dart';
import '../../model/WxOrderTypeModel.dart';
import '../../services/EventBus.dart';
import '../../services/IsLoginSerVices.dart';
import '../../network/Network.dart';
import '../../network/AAHttpManager.dart';
import '../../services/Storage.dart';
import '../../services/XJLoadingEmpty.dart';
import '../../model/WxOrderListModel.dart';

import 'WxOrderAlertView.dart';
import 'WxOrderCell.dart';

class WxOrderPage extends StatefulWidget {
  WxOrderPage({Key key}) : super(key: key);
  
  _WxOrderPageState createState() => _WxOrderPageState();
}

class _WxOrderPageState extends State<WxOrderPage> {
  
  ///服务方式数据源
  List<WxOrderTypeModel> fwfsArray = [];
  ///订单状态数据源
  List<WxOrderTypeModel> orderStatusArray = [];
  ///维修订单列表数据
  List<WxOrderListItemModel> dataModelArray = [];
  ///订单状态
  String orderStatus='';
  ///服务类型
  String orderType='';
  ///页码,默认为 0
  int pages=0;
  ///取的个数,默认20个
  String limit='10';
  EasyRefreshController _controller;
  ///记录事件监听事件，用于取消事件监听
  var _eventBusOn;
  int _dataCount = -1;
  @override
  void dispose() {
    this._eventBusOn.cancel();//取消事件监听
    super.dispose();
  }
  @override
  void initState() { 
    super.initState();
     _controller = EasyRefreshController();
    _loadData();
    _postOrderListRequest();
    //监听登录后改变登录状态
    this._eventBusOn=eventBus.on<WxOrderEvent>().listen((event){
      switch (event.index) {
        case -1:
          {
            //取消(服务方式)
            if(this.orderType==""){
              for(var i=0;i<this.fwfsArray.length;i++){
                this.fwfsArray[i].isSelected = false;
              }
            }else{
              for(var i=0;i<this.fwfsArray.length;i++){
                if(!this.orderType.contains(this.fwfsArray[i].typeId)){
                  this.fwfsArray[i].isSelected = false;
                }else{
                  this.fwfsArray[i].isSelected = true;
                }
              }
            }
          }
          break;
        case 1:
          {
            //确定(服务方式)
            List<String> orderTypeArray = [];
            for(var i=0;i<this.fwfsArray.length;i++){
              if(this.fwfsArray[i].isSelected){
                orderTypeArray.add(this.fwfsArray[i].typeId);
              }
            }
            this.orderType = orderTypeArray.join(",");
            this.pages=0;
            _postOrderListRequest();
          }
          break;
        case -2:
          {
            //取消(订单状态)
            if(this.orderStatus==""){
              for(var i=0;i<this.orderStatusArray.length;i++){
                this.orderStatusArray[i].isSelected = false;
              }
            }else{
              for(var i=0;i<this.orderStatusArray.length;i++){
                if(!this.orderStatus.contains(this.orderStatusArray[i].typeId)){
                  this.orderStatusArray[i].isSelected = false;
                }else{
                  this.orderStatusArray[i].isSelected = true;
                }
              }
            }
          }
          break;
        case 2:
          {
            //确定(订单状态)
            List<String> orderstArray = [];
            for(var i=0;i<this.orderStatusArray.length;i++){
              if(this.orderStatusArray[i].isSelected){
                orderstArray.add(this.orderStatusArray[i].typeId);
              }
            }
            this.orderStatus = orderstArray.join(",");
            this.pages=0;
            _postOrderListRequest();
          }
          break;
        default:
          break;
      }
    });
  }
  
  ///获取维修订单列表数据
  _postOrderListRequest(){
    var loginToken =  IsLoginSerVices.getLoginToken();
    loginToken.then((var token) async{
        AAHttpManager.postHttpHeaderRequest(
        params: {
          "order_status":this.orderStatus,
          "order_type":this.orderType,
          "pages":this.pages.toString(),
          "limit":this.limit
        },
        context: context,
        url: Network.drOrderListUrl,
        token: token.toString()
      ).then((resultJson){
        if(resultJson!=null){
          var model = WxOrderListModel.fromJson(resultJson["data"]);
          print("=======分割线============${model.list}");
          setState(() {
            if(this.pages==0){
              this.dataModelArray = model.list;
            }else{
              this.dataModelArray.addAll(model.list);
            }
            this._dataCount = this.dataModelArray.length;
            _controller.resetLoadState();
            _controller.finishRefresh();
          });
        }
      });
    });
  }

  _loadData(){
     //服务方式
     Future<String> typeString = DefaultAssetBundle.of(context).loadString("data/WxOrderType.json");
     typeString.then((String value){
       List dataArray = json.decode(value);
       for(var i=0;i<dataArray.length;i++){
         WxOrderTypeModel model = WxOrderTypeModel.fromJson(dataArray[i]);
         this.fwfsArray.add(model);
       }
     });

     Future<String> statusString = DefaultAssetBundle.of(context).loadString("data/WxOrderStatus.json");
     statusString.then((String value){
       List dataArray = json.decode(value);
       for(var i=0;i<dataArray.length;i++){
         WxOrderTypeModel model = WxOrderTypeModel.fromJson(dataArray[i]);
         this.orderStatusArray.add(model);
       }
     });
  }

  DropSelectHeader renderDropSelectHeader() {
    return new DropSelectHeader(
      titles: ["", ""],
      primaryColor: TextColor.drBrightTextColor,
      showTitle: (_, index) {
        switch (index) {
          case 0:
            return "服务方式";
          case 1:
            return "订单状态";
        }
        return "服务方式";
      },
    );
  }
  
  DropSelectMenu renderDropSelectMenu() {
    return new DropSelectMenu(
      maxMenuHeight: MediaQuery.of(context).size.height,
      menus: [
        DropSelectMenuBuilder(
          builder: (BuildContext context){
            return WxOrderWrapListMenu(
              title: "服务方式",
              menuWidget: _typeWidget(this.fwfsArray),
              widgetIndex: 0,
            );
          },
          height: 251
        ),
        DropSelectMenuBuilder(
          builder: (BuildContext context){
            return WxOrderWrapListMenu(
              title: "订单状态",
              menuWidget: _typeWidget(this.orderStatusArray),
              widgetIndex: 1,
            );
          },
          height: 251
        )
      ]
    );
  }
  
  Widget _typeWidget(List<WxOrderTypeModel> array){
    var itemIwdth = (ScreenAdaper.getScreenWidth() - 50)/3;
    return Wrap(
      spacing: 10,
      runSpacing: 20,
      children: array.map((model){
        return InkWell(
          onTap: (){
            setState(() {
              model.isSelected = !(model.isSelected);
            });
          },
          child: Container(
            width: itemIwdth,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: model.isSelected?TextColor.drBrightTextColor:Colors.white,
            ),
            child: Center(
              child: Text(model.typeName,style: TextStyle(
                color: model.isSelected?Colors.white:TextColor.drDarkTextTwoColor
              )),
            ),
          ),
        );
      }).toList(),
    );
  }

  Future <void> _onRefresh() async {
    this.pages = 0;
    return _postOrderListRequest();
  }

  Future <void> _onLoadingMore() async {
    this.pages += 1;
    return _postOrderListRequest();
  }
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
       appBar: AppBar(
         title: Text("维修订单"),
       ),
       body: Container(
         child: DropSelectMenuContainer(
           child: Column(
            children: <Widget>[
              renderDropSelectHeader(),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    this.dataModelArray.length>0?EasyRefresh(
                      child: ListView(
                        children: this.dataModelArray.map((value){
                          return WxOrderCellPage(value);
                        }).toList(),
                      ),
                      footer: ClassicalFooter(
                        enableInfiniteLoad: false
                      ),
                      controller: _controller,
                      onRefresh: _onRefresh,
                      onLoad: _onLoadingMore,
                    ):XJLoadingEmpty(
                      dataCount: this._dataCount,
                    ),
                    Column(
                      children: <Widget>[
                        Expanded(child: renderDropSelectMenu())
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
         )
       ),
    );
  }
}
