import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';

import '../../services/ScreenAdaper.dart';
import '../../services/XJExtension.dart';
import '../../network/Network.dart';
import '../../model/MallModel.dart';


class MallPage extends StatefulWidget {
  MallPage({Key key}) : super(key: key);

  _MallPageState createState() => _MallPageState();
}

class _MallPageState extends State<MallPage> {

  //商城首页模型
  MallModel _mallModel;
  //是否允许滚动
  bool _isNeverScrollableScrollPhysics = false;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() { 
    super.initState();
    _postHomeData();

    print(ScreenAdaper.height(850));
    _scrollController.addListener((){
       print(_scrollController.position.pixels); //获取滚动条下拉的距离
       print(_scrollController.position.pixels);
       if(_scrollController.position.pixels>ScreenAdaper.height(870)){
         setState(() {
           this._isNeverScrollableScrollPhysics = true;
         });
       }
    });
  }
  
  //获取商城首页数据
  _postHomeData() async{
     var api = Network.domain + Network.drmallIndexUrl;
     var result = await Dio().post(api,options: Network.aaHeaders);
     Map<String, dynamic> resultJson = json.decode(result.data);
     var model = MallModel.fromJson(resultJson);
     
     setState(() {
       this._mallModel = model;
     });
  }

  //轮播图
  Widget _swiperWidget() {
    // List<Map> imgList = [
    //   {"url": "https://www.itying.com/images/flutter/1.png"},
    //   {"url": "https://www.itying.com/images/flutter/2.png"},
    //   {"url": "https://www.itying.com/images/flutter/3.png"},
    //   {"url": "https://www.itying.com/images/flutter/4.png"}
    // ];
  return Container(
      width: ScreenAdaper.getScreenWidth()-30,
      height: ScreenAdaper.height(300),
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      child: AspectRatio(
        aspectRatio: 2/1,
        child: Swiper(
            itemBuilder: (BuildContext context, int index) {
            String pic = this._mallModel.data.banner[index].adCode;
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "${pic}",
                fit: BoxFit.fill,
              ),
            );
          },
          itemCount: this._mallModel.data.banner.length,
          pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
              color: Colors.blue,
            ),
            alignment: Alignment.bottomCenter 
          ),
          autoplay: true,
        ),
      ),
    );
  }

  //标题
  Widget _titleWidget(){
    List titleArray = ["配置保证","售后无忧","诺希自营"];
    return Container(
      height: ScreenAdaper.height(100),
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: titleArray.map((value){
          return Row(
            children: <Widget>[
              Image.asset("images/drx_smallLogon.png",fit: BoxFit.cover),
              SizedBox(width: 5),
              Text(value,style: TextStyle(
                fontSize: ScreenAdaper.size(28),
                color: TextColor.drBrightTextColor
              ))
            ],
          );
        }).toList(),
      ),
    );
  }

  //分类功能
  Widget _categoryWidget(itemWidth){
    return Container(
      height: ScreenAdaper.height(450),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      // color: Colors.red,
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: this._mallModel.data.goodsCategory.map((value){
          return InkWell(
            child: Container(
              width: itemWidth,
              height: itemWidth+25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: itemWidth,
                    child:Image.network(value.img,fit: BoxFit.cover),
                  ),
                  Text(value.name)
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  //选项卡切换
  Widget _sengMentWidget(){
    return Container(
      width: double.infinity,
      height: ScreenAdaper.height(300)+ScreenAdaper.getScreenHeight(),
      child: DefaultTabController(
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
                  Text("22222"),
                  Text("33333"),
                  Text("44444"),
                  Text("55555"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    //计算右侧宽高逼
    var itemWidth = (ScreenAdaper.getScreenWidth()-50)/4;
    return Scaffold(
       appBar: AppBar(
         elevation: 0.0,
         title: InkWell(
           child: Container(
            width: ScreenAdaper.getScreenWidth()-60,
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
         ),
         actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart,size: 28,color: Colors.black87),
            onPressed: null,
          )
        ],
       ),
       body: ListView(
        controller: this._scrollController,
        physics: this._isNeverScrollableScrollPhysics?NeverScrollableScrollPhysics():null,
        children: <Widget>[
          this._mallModel!=null?_swiperWidget():Center(child: Text("加载中....")),
          _titleWidget(),
          this._mallModel!=null?_categoryWidget(itemWidth):Center(child: Text("加载中....")),
          Container(
            height: ScreenAdaper.height(20),
            color: XJColors.hexColor(0xf4f4f4),
          ),
          _sengMentWidget()
        ],
      ),
    );
  }
}