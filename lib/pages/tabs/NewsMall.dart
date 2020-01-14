import 'dart:math' as math;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../../services/ScreenAdaper.dart';
import '../../services/XJExtension.dart';
import '../../network/Network.dart';
import '../../model/MallModel.dart';

import '../mall/Mall_tj.dart';
import '../mall/Mall_product.dart';
import '../../provider/Mall_provider.dart';
class MallPage extends StatefulWidget {
  MallPage({Key key}) : super(key: key);

  _MallPageState createState() => _MallPageState();
}

class _MallPageState extends State<MallPage> with SingleTickerProviderStateMixin,WidgetsBindingObserver,AutomaticKeepAliveClientMixin{

  //商城首页模型
  MallModel _mallModel;
  //选项卡index下标
  int _sengMentIndex=0;
  String _customeId = "";
  //监听滚动
  ScrollController _scrollController = ScrollController();
  //监听TabController
  TabController _tabController;
  var cartProvider;
  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState() { 
    super.initState();
    _postHomeData();
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
    
     Thems them = Thems();
     them.url = "";
     them.id = "-1";
     them.logo = "";
     them.name = "推荐";
     this._mallModel.data.thems.insert(0, them);
     this._customeId = this._mallModel.data.thems.first.id;

      print("====${ScreenAdaper.height(870)}");
     _scrollController.addListener((){
       if(_scrollController.position.pixels==ScreenAdaper.height(870)){
         this.cartProvider.setIsScroller(true);
       }else{
         this.cartProvider.setIsScroller(false);
       }
     });



    //  _tabController = TabController(
    //    length: this._mallModel.data.thems.length,
    //    vsync: this
    //  );
    //  _tabController.addListener((){
    //    setState(() {
    //       this._sengMentIndex = _tabController.index;
    //       this._customeId = this._mallModel.data.thems[_tabController.index].id;
    //       print("_customeId========${_customeId}");
    //       print("_customeId22========${this._customeId}");
    //    });
    //  });
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

  //头部视图信息
  List<Widget> _sliverHeaderBuilder(BuildContext context, bool innerBoxIsScrolled){
    //计算宽高
    var itemWidth = (ScreenAdaper.getScreenWidth()-50)/4;
    return <Widget>[
      SliverPersistentHeader(
        delegate: DDSliverHeaderDelegate(
          maxHeight: ScreenAdaper.height(300),
          minHeight: ScreenAdaper.height(300),
          snapConfig: FloatingHeaderSnapConfiguration(
            vsync: this,
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 10),
          ),
          child: this._mallModel!=null?_swiperWidget():Center(child: Text("加载中....")),
        ),
      ),
      SliverPersistentHeader(
        delegate: DDSliverHeaderDelegate(
          maxHeight: ScreenAdaper.height(100),
          minHeight: ScreenAdaper.height(100),
          snapConfig: FloatingHeaderSnapConfiguration(
            vsync: this,
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 10),
          ),
          child: _titleWidget(),
        ),
      ),
      SliverPersistentHeader(
        delegate: DDSliverHeaderDelegate(
          maxHeight: ScreenAdaper.height(450),
          minHeight: ScreenAdaper.height(450),
          snapConfig: FloatingHeaderSnapConfiguration(
            vsync: this,
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 10),
          ),
          child: this._mallModel!=null?_categoryWidget(itemWidth):Center(child: Text("加载中....")),
        ),
      ),
      SliverPersistentHeader(
        delegate: DDSliverHeaderDelegate(
          maxHeight: ScreenAdaper.height(20),
          minHeight: ScreenAdaper.height(20),
          snapConfig: FloatingHeaderSnapConfiguration(
            vsync: this,
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 10),
          ),
          child: Container(
            height: ScreenAdaper.height(20),
            color: XJColors.hexColor(0xf4f4f4),
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: DDSliverHeaderDelegate(
          maxHeight: ScreenAdaper.height(0),
          minHeight: ScreenAdaper.height(0),
          snapConfig: FloatingHeaderSnapConfiguration(
            vsync: this,
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 10),
          ),
          child: Text("")
          // child: Container(
          //   height: ScreenAdaper.height(90),
            // decoration: BoxDecoration(
            //   border: Border(
            //     bottom: BorderSide(
            //       width: 0.4,
            //       color: Colors.black26
            //     )
            //   ),
            //   color: Colors.white
            // ),
          //   child: this._mallModel!=null?ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: this._mallModel.data.thems.length,
          //     itemBuilder: (_,index){
          //       return InkWell(
          //         onTap: (){
          //           WidgetsBinding.instance.addPostFrameCallback(_onAfterRendering);
          //           setState(() {
          //             this._sengMentIndex = index;
          //             print(this._mallModel.data.thems[index].id);
          //           });
          //         },
          //         child: Container(
          //           margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          //           child: Center(
          //             child: Text(
          //               this._mallModel.data.thems[index].name,
          //               style: TextStyle(
          //               fontSize: this._sengMentIndex==index?ScreenAdaper.size(32):ScreenAdaper.size(28),
          //               color: this._sengMentIndex==index?TextColor.drBrightTextColor:Colors.black26
          //             )),
          //           ),
          //         ),
          //       );
          //     },
          //   ):Text(""),
          // ),
        ),
      ),
    ];
  }

  //选项卡切换
  Widget _sengMentWidget(){
    return DefaultTabController(
        length: this._mallModel.data.thems.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(ScreenAdaper.getScreenWidth(), ScreenAdaper.height(100)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: ScreenAdaper.getScreenWidth(),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.4,
                        color: Colors.black26
                      )
                    ),
                    color: Colors.white
                  ),
                  child: TabBar(
                    onTap: (index){
                      setState(() {
                        this._sengMentIndex = index;
                        this._customeId = this._mallModel.data.thems[index].id;
                        print("id1===============${this._customeId}");
                      });
                    },
                    // controller: _tabController,
                    indicatorColor: Colors.blue,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.black87,
                    isScrollable: true, //是否允许滚动
                    labelPadding: EdgeInsets.fromLTRB(11, 0, 11, 0),
                    tabs: this._mallModel.data.thems.map((value){
                      return Tab(
                        child: Text(value.name,style: TextStyle(
                          fontSize: this._customeId==value.id?ScreenAdaper.size(32):ScreenAdaper.size(28),
                        ))
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
          body: Stack(
            children: <Widget>[
              TabBarView(
                // controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
                children: this._mallModel.data.thems.asMap().keys.map((index){
                  return index==0?MallTJPage(this._mallModel.data):MallProductPage(this._mallModel.data.thems[index].id);
                }).toList(),
              )
            ],
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    cartProvider = Provider.of<MallTJProvider>(context);
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
       body: Container(
         child: NestedScrollView(
           physics: AlwaysScrollableScrollPhysics(),
           headerSliverBuilder: _sliverHeaderBuilder,
           controller: _scrollController,
          //  body: this._mallModel!=null?Swiper(
          //     itemBuilder: (BuildContext context, int index) {
          //     return Container(
          //       width: ScreenAdaper.getScreenWidth(),
          //       child: Center(
          //         child: index==0?MallTJPage(this._mallModel.data):MallProductPage(),
          //       ),
          //     );
          //   },
          //   itemCount: this._mallModel.data.thems.length,
          //   autoplay: true,
          //   controller: this._swiperController,
          // ):Text(""),
          body: this._mallModel!=null?_sengMentWidget():Text(""),
         ),
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