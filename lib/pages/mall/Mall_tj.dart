import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import '../../services/ScreenAdaper.dart';
import '../../services/XJExtension.dart';
import '../../model/MallModel.dart';
import 'Mall_item.dart';
import '../../provider/Mall_provider.dart';

class MallTJPage extends StatefulWidget {

  //商城首页模型
  MallDataModel _dataModel;

  MallTJPage(this._dataModel,{Key key}) : super(key: key);

  _MallTJPageState createState() => _MallTJPageState();
}

class _MallTJPageState extends State<MallTJPage> with AutomaticKeepAliveClientMixin{

  MallDataModel _dataModel;

  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState() { 
    super.initState();
    _dataModel = widget._dataModel;
  }
  //轮播图
  Widget _swiperWidget() {
    List<Map> imgList = [
      {"url": "https://www.itying.com/images/flutter/1.png"},
      {"url": "https://www.itying.com/images/flutter/2.png"},
      {"url": "https://www.itying.com/images/flutter/3.png"},
      {"url": "https://www.itying.com/images/flutter/4.png"}
    ];
  return Container(
      width: double.infinity,
      height: ScreenAdaper.height(340),
      // margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: AspectRatio(
        aspectRatio: 2/1,
        child: Swiper(
            itemBuilder: (BuildContext context, int index) {
            String pic = this._dataModel.favouriteGoods[index].originalImg;
            return ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.network(
                "${pic}",
                fit: BoxFit.cover,
              ),
            );
          },
          itemCount: this._dataModel.favouriteGoods.length,
          autoplay: false,
        ),
      ),
    );
  }

  //限时抢购标题
  Widget _xsqgWidget(){
    return Container(
      margin: EdgeInsets.fromLTRB(15, 15, 0, 15),
      child: Row(
        children: <Widget>[
          Text("限时抢购",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: ScreenAdaper.size(30)
          ))
        ],
      ),
    );
  }

  //热卖推荐标题
  Widget _rmtjWidget(){
    return Container(
      margin: EdgeInsets.fromLTRB(15, 15, 0, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.access_alarm),
          Text("热卖推荐",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: ScreenAdaper.size(30),
            color: TextColor.drBrightTextColor
          ))
        ],
      ),
    );
  }

  //商品组件
  Widget _productWidget(width,height,List dataModelArray){
    return Wrap(
      runSpacing: 20,
      spacing: 5,
      children: dataModelArray.map((value){
        return MallItemPage(
          width: width,
          height: height,
          imageUrl: value.originalImg,
          name: value.goodsName,
          price: value.shopPrice,
          cb: (){
            print(value.goodsId);
            Navigator.pushNamed(context, "/commodityDetails",arguments: {
              "goodsId":value.goodsId
            });
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<MallTJProvider>(context);
    ScreenAdaper.init(context);
    //计算宽高
    var itemWidth = (ScreenAdaper.getScreenWidth()-50)/2;
    return ListView(
      // shrinkWrap: true,
      physics: cartProvider.isScroller?null:NeverScrollableScrollPhysics(),
      children: <Widget>[
        _swiperWidget(),
        _xsqgWidget(),
        _productWidget(itemWidth, itemWidth+70,this._dataModel.timeLimitGoods),
        _rmtjWidget(),
        _productWidget(itemWidth, itemWidth+70,this._dataModel.hotGoods),
        SizedBox(height: 20)
      ],
    );
  }
}