import 'package:flutter/material.dart';

import '../../services/ScreenAdaper.dart';
import '../../services/XJExtension.dart';
import '../../services/XJButton.dart';
import '../../model/HomeDataModel.dart';

class HomeZXPage extends StatefulWidget {
  //首页数据模型
  final HomeDataModel _homeDataModel;
  final String _bannerImg;

  HomeZXPage(this._homeDataModel,this._bannerImg,{Key key}) : super(key: key);

  _HomeZXPageState createState() => _HomeZXPageState();
}

class _HomeZXPageState extends State<HomeZXPage> with AutomaticKeepAliveClientMixin{
  HomeDataModel _homeDataModel;
  String _bannerImg;

  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState() {
    super.initState();
    this._homeDataModel = widget._homeDataModel;
    this._bannerImg = widget._bannerImg;
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    var itemIwdth = (ScreenAdaper.getScreenWidth() - 60)/2;
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            height: ScreenAdaper.height(300),
            child: Image.network(this._bannerImg,fit: BoxFit.cover),
          ),
          SizedBox(height: 15),
          Text("挑战更优惠",textAlign: TextAlign.center,style: TextStyle(
            fontSize: ScreenAdaper.size(36),
            color: XJColors.hexColor(0x282828)
          )),
          Container(
            margin: EdgeInsets.all(20),
            child: Wrap(
              runSpacing: 10,
              spacing: 20,
              children: this._homeDataModel.data.couponList.map((value){
                var conditionInt =  double.parse(value.condition).toInt();
                return InkWell(
                  onTap: (){

                  },
                  child: Container(
                    width: itemIwdth,
                    child: Stack(
                      children: <Widget>[
                        Image.asset("images/drx_pmsp.png",fit: BoxFit.cover),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                          child: Row(
                            children: <Widget>[
                              Text("￥${value.money}",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenAdaper.size(42),
                                color: XJColors.hexColor(0x3475ec)
                              )),
                              Container(
                                margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                child: Text("优惠券",style: TextStyle(
                                  fontSize: ScreenAdaper.size(24),
                                  color: XJColors.hexColor(0x282828)
                                )),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 50, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text("满${conditionInt}元即可使用",style: TextStyle(
                                fontSize: ScreenAdaper.size(22),
                                color: XJColors.hexColor(0x282828)
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: XJButton(
              color: XJColors.hexColor(0x3475ec),
              text: "立即下单",
              height: ScreenAdaper.height(90),
            ),
          )
        ],
      ),
    );
  }
}