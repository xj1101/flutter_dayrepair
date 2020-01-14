

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/ScreenAdaper.dart';
import '../../services/XJExtension.dart';
import '../../services/Storage.dart';
import '../../services/EventBus.dart';
import '../../network/Network.dart';
import '../../model/CommodityDetailsModel.dart';

const APPBAR_SCROLL_OFFSET = 200;
class CommodityDetailsPage extends StatefulWidget {

  final Map arguments;
  CommodityDetailsPage({Key key,this.arguments}) : super(key: key);

  _CommodityDetailsPageState createState() => _CommodityDetailsPageState();
}

class _CommodityDetailsPageState extends State<CommodityDetailsPage> {

  //定义一个AppBar 的透明度默认值
  double appBarAlpha = 0;
  //记录滚动视图滑动的距离
  double webOffset = 0;
  InAppWebViewController _controller;
  //商品详情模型
  CommodityDetailsModel detailsModel;

  @override
  void initState() { 
    super.initState();
    _postHomeData();

    
  }
    //获取首页数据
  _postHomeData() async{
    Map parameters = {
      "goods_id":widget.arguments["goodsId"],
    };
    var api = Network.domain + Network.drGoodsDetailUrl;
    var result = await Dio().post(api,options: Network.aaHeaders,data: parameters);
    Map<String, dynamic> resultJson = json.decode(result.data);
    if(resultJson["status"]==1){
      var model = CommodityDetailsModel.fromJson(resultJson);
      setState(() {
        this.detailsModel = model;
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
  }

  //轮播图
  Widget _swiperWidget() {
    List<Map> imgList = [
      {"url": "https://www.itying.com/images/flutter/1.png"},
      {"url": "https://www.itying.com/images/flutter/2.png"},
      {"url": "https://www.itying.com/images/flutter/3.png"},
      {"url": "https://www.itying.com/images/flutter/4.png"}
    ];
    if(this.detailsModel.data.goodsImageUrl.length>0){
      return Container(
        height: ScreenAdaper.height(500),
        child: AspectRatio(
          aspectRatio: 2/1,
          child: Swiper(
              itemBuilder: (BuildContext context, int index) {
              // String pic = imgList[index]["url"];
              String pic = this.detailsModel.data.goodsImageUrl[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.network(
                  "${pic}",
                  fit: BoxFit.fill,
                ),
              );
            },
            itemCount: this.detailsModel.data.goodsImageUrl.length,
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                color: Colors.blue,
              ),
              alignment: Alignment.bottomCenter 
            ),
            autoplay: false,
          ),
        ),
      );
    }else{
      return Text("");
    }
  }

  //商品标题
  Widget _commodityTitleWidget(){
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(this.detailsModel.data.goodsName,style: TextStyle(
            fontFamily: "SourceHanSansCNRegular",
            fontSize: ScreenAdaper.size(28),
            color: TextColor.drDarkTextTwoColor
          )),
          Text("￥${this.detailsModel.data.shopPrice}",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: ScreenAdaper.size(36),
            color: XJColors.hexColor(0xff1313)
          )),
          Divider(),
          Text("商品详情",style: TextStyle(
            fontFamily: "SourceHanSansCNRegular",
            fontSize: ScreenAdaper.size(32),
            color: TextColor.drDarkTextTwoColor
          )),
        ],
      ),
    );
  }

  ///尾部web
  Widget _footerWebWidget(){
    return Container(
      height: 10000,
      child: InAppWebView(
        initialUrl: this.detailsModel.data.goodsContent,
        initialHeaders: {},
        initialOptions: InAppWebViewWidgetOptions(),
        onWebViewCreated: (InAppWebViewController controller) {
          _controller = controller;
          _setJSHandler(_controller);
          
        },
        onLoadStart: (InAppWebViewController controller, String url) async {
          // controller.addJavaScriptHandler(
          //   handlerName: "getWebHeight",
          //   callback: (list){
          //     print("list======================${list}");
          //   }
          // );
        },
        onLoadStop: (InAppWebViewController controller, String url) async {
          // controller.evaluateJavascript(source: "function getImagesHeight(screenWidth){var imagesHeight = 0;for(i=0;i <document.images.length;i++){var image = document.images[i];var imgW = image.width;var imgH = image.height;var realImgH = screenWidth*imgH/imgW;imagesHeight += realImgH;} window.webkit.messageHandlers.getWebHeight.postMessage(imagesHeight)}");
          // String str2= "getImagesHeight"+ScreenAdaper.getScreenWidth().toString();
          // controller.evaluateJavascript(
          //   source: str2
          // );
          // 页面加载完成后注入js方法, 获取页面总高度 
          controller.evaluateJavascript(
            source: """
            window.flutter_inappbrowser.callHandler('test1', document.body.scrollHeight));
            """
          );
          // controller.injectJavascriptFileFromAsset(
          //   assetFilePath: "data/CommodityDetails.js"
          // );
        },
      ),
    );
  }

  void _setJSHandler(InAppWebViewController controller) {
    print("11111111111111");
    controller.addJavaScriptHandler(
      handlerName: "test1",
      callback: (list) async{
        print("22222222222222222");
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
       body: Stack(
         children: <Widget>[
           MediaQuery.removePadding(
             removeTop: true,
             context: context,
             // 监听列表的滚动
             child: NotificationListener(
               // 滚动的回调
               onNotification: (scrollNotifation){
                 // 判断ListView滚动的效果
                 if(scrollNotifation is ScrollUpdateNotification && scrollNotifation.depth == 0){
                   // 滚动且是列表滚动的的的时候
                   double offset =  scrollNotifation.metrics.pixels;
                   double  alpha =  offset / APPBAR_SCROLL_OFFSET;
                    if(alpha>1){
                      alpha =  1;
                    }else if(alpha<0){
                      alpha =  0;
                    }
                    setState(() {
                      this.appBarAlpha = alpha;
                      this.webOffset = offset;
                    });
                 }
               },
              child: this.detailsModel!=null?ListView(
                children: <Widget>[
                  _swiperWidget(),
                  _commodityTitleWidget(),
                  _footerWebWidget(),
                ],
              ):Text(""),
             ),
           ),
           Stack(
             children: <Widget>[
               Opacity(
                opacity: appBarAlpha,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Text("商品详情",style: TextStyle(
                        fontFamily: "SourceHanSansCNBold",
                        fontSize: 20
                      )),
                    ),
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 30, 0, 0),
                  child: Icon(Icons.navigate_before,size: 45),
                ),
                onTap: (){
                  Navigator.pop(context);
                },
              )
             ],
           ),
           this.detailsModel!=null?Positioned(
             bottom: 0,
             child: Container(
               width: ScreenAdaper.getScreenWidth(),
               height: 60,
               color: Colors.red
             ),
           ):Text("")
         ],
       ),
    );
  }
}