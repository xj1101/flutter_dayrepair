import 'dart:async';
import 'dart:convert';
import 'package:dayrepair/services/XJExtension.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../../services/ScreenAdaper.dart';
import '../../network/Network.dart';
import '../../model/MallTypeModel.dart';

import 'Mall_item.dart';

class MallProductPage extends StatefulWidget {
  //品牌id
  String _id = "";

  MallProductPage(this._id,{Key key}) : super(key: key);

  _MallProductPageState createState() => _MallProductPageState();
}

class _MallProductPageState extends State<MallProductPage> with AutomaticKeepAliveClientMixin{

  MallTypeModel _typeModel;
  List<MallTypeItemModel> _itemModelArray = [];
  //品牌id
  String _id;
  //分页
  int _pages = 0;
  //每页请求数量
  String _limit = "10";
  
  Timer _countdownTimer;
  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState() { 
    super.initState();
    this._id = widget._id;
    // if(this._id != "-1"){
    //   this._postMallTypeData();
    // }
    this._postMallTypeData();
  }

  // @override
  // void dispose() {
  //   _countdownTimer?.cancel();
  //   _countdownTimer = null;
  //   super.dispose();
  // }


  //获取商城首页数据
  _postMallTypeData() async{
      //{"id":this._id,"pages":this._pages,"limit":this._limit}
      print("id2===============${this._id}");
     var api = Network.domain + Network.drgoodsCategoryListUrl;
     var result = await Dio().post(api,options: Network.aaHeaders,queryParameters:{"id":this._id,"pages":this._pages,"limit":this._limit} );
     Map<String, dynamic> resultJson = json.decode(result.data);
     var model = MallTypeModel.fromJson(resultJson);
     
     setState((){
        this._typeModel = model;
        this._itemModelArray = model.data;
        print("id3===============${this._id}");
      });

      // _countdownTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      //   if (mounted){
      //     setState(() {
      //       this._typeModel = model;
      //       this._itemModelArray = model.data;
      //       print("id3===============${this._id}");
      //     });
      //   }
      // });    
     
  }

  //顶部商品
  Widget _topProductWidget(){
    
    MallTypeItemModel itemModel = this._itemModelArray.first;
    return InkWell(
      child: Container(
        height: ScreenAdaper.height(250),
        margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              color: Color.fromARGB(20, 0, 0, 0),
            )
          ],
          color: Colors.white
        ),
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1/1,
              child: Image.network(itemModel.originalImg,fit: BoxFit.cover),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(itemModel.goodsName,maxLines: 2,overflow: TextOverflow.ellipsis,),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Text("抢购价:"),
                        Text("￥${itemModel.shopPrice}",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: TextColor.drBrightTextColor
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Container(
                      height: ScreenAdaper.height(70),
                      decoration: BoxDecoration(
                        color: TextColor.drBrightTextColor,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: InkWell(
                        child: Center(
                          child: Text("立即参与",style: TextStyle(
                            fontSize: ScreenAdaper.size(30),
                            color: Colors.white
                          )),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //商品组件
  Widget _productWidget(width,height,List dataModelArray){
    List<MallTypeItemModel> tempArray = [];
    for(int i=0;i<dataModelArray.length;i++){
      if(i>0){
        tempArray.add(dataModelArray[i]);
      }
    }
    return Wrap(
      runSpacing: 20,
      spacing: 5,
      children: tempArray.map((value){
        return MallItemPage(
          width: width,
          height: height,
          imageUrl: value.originalImg,
          name: value.goodsName,
          price: value.shopPrice.toString(),
          cb: (){
            print(value.goodsName);
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    //计算宽高
    var itemWidth = (ScreenAdaper.getScreenWidth()-50)/2;
    return ListView(
      children: <Widget>[
        this._itemModelArray.length>0?_topProductWidget():Center(child: Text("加载中...")),
        this._itemModelArray.length>0?_productWidget(itemWidth, itemWidth+70,this._typeModel.data):Center(child: Text("加载中...")),
        SizedBox(height: 20)
      ],
    );
  }
}