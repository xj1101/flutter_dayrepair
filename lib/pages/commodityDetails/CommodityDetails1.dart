import 'dart:math' as math;
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../services/ScreenAdaper.dart';
import '../../services/XJExtension.dart';

const APPBAR_SCROLL_OFFSET = 200;
class CommodityDetailsPage extends StatefulWidget {
  CommodityDetailsPage({Key key}) : super(key: key);

  _CommodityDetailsPageState createState() => _CommodityDetailsPageState();
}

class _CommodityDetailsPageState extends State<CommodityDetailsPage> with SingleTickerProviderStateMixin,WidgetsBindingObserver{

  //定义一个AppBar 的透明度默认值
  double appBarAlpha = 0;
  //记录滚动视图滑动的距离
  double webOffset = 0;

  //轮播图
  Widget _swiperWidget() {
    List<Map> imgList = [
      {"url": "https://www.itying.com/images/flutter/1.png"},
      {"url": "https://www.itying.com/images/flutter/2.png"},
      {"url": "https://www.itying.com/images/flutter/3.png"},
      {"url": "https://www.itying.com/images/flutter/4.png"}
    ];
    if(imgList.length>0){
      return Container(
        height: double.infinity,
        child: AspectRatio(
          aspectRatio: 2/1,
          child: Swiper(
              itemBuilder: (BuildContext context, int index) {
              // String pic = imgList[index]["url"];
              String pic = imgList[index]["url"];
              return ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.network(
                  "${pic}",
                  fit: BoxFit.fill,
                ),
              );
            },
            itemCount: imgList.length,
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
          Text("大水坑加点辣椒偶尔反反复复发了看了看发斯蒂芬奥术大师多",style: TextStyle(
            fontFamily: "SourceHanSansCNRegular",
            fontSize: ScreenAdaper.size(28),
            color: TextColor.drDarkTextTwoColor
          )),
          Text("￥0.00",style: TextStyle(
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
    // return Container(
    //   height: 1000,
    //   child: InAppWebView(
    //     initialUrl: "https://www.baidu.com",
    //     initialHeaders: {},
    //     initialOptions: InAppWebViewWidgetOptions(),
    //     onLoadStart: (InAppWebViewController controller, String url) async {
    //       controller.evaluateJavascript(source: "function getImagesHeight(screenWidth){var imagesHeight = 0;for(i=0;i <document.images.length;i++){var image = document.images[i];var imgW = image.width;var imgH = image.height;var realImgH = screenWidth*imgH/imgW;imagesHeight += realImgH;} window.webkit.messageHandlers.getWebHeight.postMessage(imagesHeight)}");
          
    //     },
    //   ),
    // );
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialUrl: "https://www.baidu.com",
              initialHeaders: {},
              initialOptions: InAppWebViewWidgetOptions(),
              onLoadStart: (InAppWebViewController controller, String url) async {
                controller.evaluateJavascript(source: "function getImagesHeight(screenWidth){var imagesHeight = 0;for(i=0;i <document.images.length;i++){var image = document.images[i];var imgW = image.width;var imgH = image.height;var realImgH = screenWidth*imgH/imgW;imagesHeight += realImgH;} window.webkit.messageHandlers.getWebHeight.postMessage(imagesHeight)}");
                
              },
            ),
          )
        ],
      ),
    );
  }

  //头部视图信息
  List<Widget> _sliverHeaderBuilder(BuildContext context, bool innerBoxIsScrolled){
    return <Widget>[
      SliverPersistentHeader(
        delegate: DDSliverHeaderDelegate(
          maxHeight: ScreenAdaper.height(500),
          minHeight: ScreenAdaper.height(500),
          snapConfig: FloatingHeaderSnapConfiguration(
            vsync: this,
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 10),
          ),
          child: _swiperWidget(),
        ),
      ),
      SliverPersistentHeader(
        delegate: DDSliverHeaderDelegate(
          maxHeight: ScreenAdaper.height(270),
          minHeight: ScreenAdaper.height(270),
          snapConfig: FloatingHeaderSnapConfiguration(
            vsync: this,
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 10),
          ),
          child: _commodityTitleWidget(),
        ),
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    double webHieght = ScreenAdaper.height(500)+20+28.59813084112146;
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
              child: Container(
                child: NestedScrollView(
                  // physics: AlwaysScrollableScrollPhysics(),
                  headerSliverBuilder: _sliverHeaderBuilder,
                  body: _footerWebWidget(),
                ),
              ),
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
              Container(
                margin: EdgeInsets.fromLTRB(5, 30, 0, 0),
                child: Icon(Icons.navigate_before,size: 45,),
              ),
             ],
           ),
           Positioned(
             bottom: 0,
             child: Container(
               width: ScreenAdaper.getScreenWidth(),
               height: 40,
               color: Colors.red
             ),
           )
         ],
       ),
    );
  }
}

///动态头部处理
class DDSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  DDSliverHeaderDelegate(
      {@required this.minHeight,
      @required this.maxHeight,
      @required this.snapConfig,
      this.child,
      this.builder,
      this.changeSize = false});

  final double minHeight;
  final double maxHeight;
  final Widget child;
  final Builder builder;
  final bool changeSize;
  final FloatingHeaderSnapConfiguration snapConfig;
  AnimationController animationController;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (builder != null) {
      return builder(context, shrinkOffset, overlapsContent);
    }
    return child;
  }

  @override
  bool shouldRebuild(DDSliverHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => snapConfig;
}

typedef Widget Builder(
    BuildContext context, double shrinkOffset, bool overlapsContent);