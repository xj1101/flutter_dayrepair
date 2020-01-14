import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:device_info/device_info.dart';

import '../../services/ScreenAdaper.dart';
import '../../services/XJExtension.dart';
import '../../services/XJDeviceType.dart';
import '../../model/HomeDataModel.dart';

class HomeTJPage extends StatefulWidget {

  //首页数据模型
  final HomeDataModel _homeDataModel;

  HomeTJPage(this._homeDataModel,{Key key}) : super(key: key);

  _HomeTJPageState createState() => _HomeTJPageState();
}

class _HomeTJPageState extends State<HomeTJPage> with AutomaticKeepAliveClientMixin{

  HomeDataModel _homeDataModel;
  String _deviceName = "11";//设备名称

  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState(){ 
    super.initState();
    this._homeDataModel = widget._homeDataModel;
    print(this._homeDataModel.data.banner[0].adCode);

    getDeviceInfo();
  }
  void getDeviceInfo() async{
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    if(Platform.isIOS){
      print('IOS设备：');
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      setState(() {
        this._deviceName = IphoneType.iphoneType(iosInfo.utsname.machine);
      });
    }else if(Platform.isAndroid){
      print('Android设备');
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    }
  }

  //轮播图
  Widget _swiperWidget() {
    // List<Map> imgList = [
    //   {"url": "https://www.itying.com/images/flutter/1.png"},
    //   {"url": "https://www.itying.com/images/flutter/2.png"},
    //   {"url": "https://www.itying.com/images/flutter/3.png"},
    //   {"url": "https://www.itying.com/images/flutter/4.png"}
    // ];
    if(this._homeDataModel.data.banner.length>0){
      return Container(
        width: ScreenAdaper.getScreenWidth()-30,
        height: ScreenAdaper.height(300),
        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)
        ),
        child: AspectRatio(
          aspectRatio: 2/1,
          child: Swiper(
              itemBuilder: (BuildContext context, int index) {
              // String pic = imgList[index]["url"];
              String pic = this._homeDataModel.data.banner[index].adCode;
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "${pic}",
                  fit: BoxFit.fill,
                ),
              );
            },
            itemCount: this._homeDataModel.data.banner.length,
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                color: Colors.blue,
              ),
              alignment: Alignment.bottomRight 
            ),
            autoplay: true,
          ),
        ),
      );
    }else{
      return Text("加载中....");
    }
  }

  //检测机型
  Widget _detectionTypeWidget() {
    var buttonWidth = (ScreenAdaper.getScreenWidth()-30)/2;
    var viewWidth= ScreenAdaper.getScreenWidth()-30;
    return Container(
      width: viewWidth,
      height: ScreenAdaper.height(300),
      margin: EdgeInsets.fromLTRB(15, 15, 15, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            color: Color.fromARGB(20, 0, 0, 0),
          )
        ]
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: ScreenAdaper.height(142),
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 15, 0, 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        Text("已检测到你当前的机型为:",style: TextStyle(
                          fontSize: ScreenAdaper.size(28),
                          color: XJColors.hexColor(0x282828)
                        )),
                        SizedBox(height: 5),
                        Text(this._deviceName,style: TextStyle(
                          fontWeight: FontWeight.bold
                        )),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 21,
                  margin: EdgeInsets.fromLTRB(0, 25, 15, 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset("images/join_tc.png",fit: BoxFit.cover),
                  ),
                )
              ],
            ),
          ),
          Divider(height: 1),
          Container(
            height: ScreenAdaper.height(142),
            child: Row(
              children: <Widget>[
                Container(
                  width: buttonWidth,
                  child: Container(
                    height: 35,
                    margin: EdgeInsets.fromLTRB(35, 10, 35, 10),
                    padding: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: XJColors.hexColor(0x3475ec),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: InkWell(
                      onTap: (){

                      },
                      child: Text("维修下单",textAlign:TextAlign.center,style: TextStyle(
                        fontSize: ScreenAdaper.size(28),
                        color: Colors.white
                      )),
                    ),
                  ),
                ),
                Container(
                  width: buttonWidth,
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, "/repairDevice").then((onValue){
                        if(onValue != null){
                          this._deviceName = onValue;
                        }
                      });
                    },
                    child: Container(
                      height: 35,
                      margin: EdgeInsets.fromLTRB(35, 10, 35, 10),
                      decoration: BoxDecoration(
                        color: XJColors.hexColor(0xe5e5e5),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(
                        child: Text("更换机型",textAlign:TextAlign.center,style: TextStyle(
                          fontSize: ScreenAdaper.size(28),
                          color: XJColors.hexColor(0x282828)
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
    );
  }

  //热门维修
  Widget _hotwxTitleWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.loyalty,color: XJColors.hexColor(0x3475ec)),
        SizedBox(width: 5),
        Text("热门维修",style: TextStyle(
          fontSize: ScreenAdaper.size(32),
          color: XJColors.hexColor(0x282828)
        ))
      ],
    );
  }

  //热门维修(内容)
  Widget _hotwxContentWidget(){
    return Container(
      width: double.infinity,
      height: ScreenAdaper.height(450),
      child: Swiper(
          itemBuilder: (BuildContext context, int index) {
          List<HotRepair> hotRepairArray = this._homeDataModel.data.hotRepair[index];
          return Row(
            children: <Widget>[
              
              _hotwxLeftWidget(ScreenAdaper.width(440),ScreenAdaper.height(400),hotRepairArray[0]),
              Column(
                children: <Widget>[
                  _hotwxRightWidget(ScreenAdaper.width(200),ScreenAdaper.height(179),hotRepairArray[1]),
                  _hotwxRightWidget(ScreenAdaper.width(200),ScreenAdaper.height(179),hotRepairArray[2]),
                ],
              )
            ],
          );
        },
        itemCount: this._homeDataModel.data.hotRepair.length,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colors.blue,
            activeColor: Colors.grey
          ),
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.all(0) 
        ),
        autoplay: true,
      ),
    );
  }
  //热门维修(左边控件)
  Widget _hotwxLeftWidget(width,height,hotRepair){
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.fromLTRB(ScreenAdaper.width(20), ScreenAdaper.width(20), 0, ScreenAdaper.width(50)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            color: Color.fromARGB(20, 0, 0, 0),
          )
        ]
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: ScreenAdaper.height(270),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)
              ),
              child: Image.network(
                hotRepair.img,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  hotRepair.faultName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:TextStyle(
                    fontSize: ScreenAdaper.size(28),
                    color: XJColors.hexColor(0x282828)
                  ),
                ),
              ),
              SizedBox(width: 5),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              SizedBox(width: 5),
              Text("￥${hotRepair.price}",style: TextStyle(
                fontSize: ScreenAdaper.size(28),
                color: XJColors.hexColor(0x3475ec)
              )),
              Container(
                width: ScreenAdaper.width(130),
                height: ScreenAdaper.height(40),
                margin: EdgeInsets.fromLTRB(width-120, 0, 0, 0),
                padding: EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: XJColors.hexColor(0x3475ec),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: InkWell(
                  onTap: (){

                  },
                  child: Text("立即下单",textAlign:TextAlign.center,style: TextStyle(
                    fontSize: ScreenAdaper.size(24),
                    color: Colors.white
                  )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  //热门维修(右边控件)
  Widget _hotwxRightWidget(width,height,hotRepair){
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.fromLTRB(ScreenAdaper.width(20), ScreenAdaper.width(20), 0, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            color: Color.fromARGB(20, 0, 0, 0),
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Text(hotRepair.faultName,textAlign: TextAlign.center,style:TextStyle(
              fontSize: ScreenAdaper.size(22)
            )),
          ),
          Container(
            width: ScreenAdaper.width(130),
            height: ScreenAdaper.height(40),
            // margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            padding: EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: XJColors.hexColor(0x3475ec),
              borderRadius: BorderRadius.circular(5)
            ),
            child: InkWell(
              onTap: (){

              },
              child: Text("立即下单",textAlign:TextAlign.center,style: TextStyle(
                fontSize: ScreenAdaper.size(22),
                color: Colors.white
              )),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Text("￥${hotRepair.price}",textAlign: TextAlign.center,style:TextStyle(
              fontSize: ScreenAdaper.size(22)
            )),
          ),
        ],
      ),
    );
  }

  //底部广告图
  Widget _bottomBannerWidget(){
    return Container(
      height: ScreenAdaper.height(200),
      margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: InkWell(
        onTap: (){

        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            this._homeDataModel.data.bottomImg,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  //底部展示图
  Widget _bottomZSWidget(){
    List<Map> buttonList = [
      {"img": "images/zxxd.png","title":"在线下单"},
      {"img": "images/kfdl.png","title":"客服电联"},
      {"img": "images/gcssm.png","title":"工程师上门"},
      {"img": "images/wczf.png","title":"完成支付"},
      {"img": "images/rspj.png","title":"如实评价"}
    ];
    return Container(
      height: ScreenAdaper.height(150),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: buttonList.length,
        itemBuilder: (context,index){
          return Container(
            width: ScreenAdaper.getScreenWidth()/5,
            child: Column(
              children: <Widget>[
                Image.asset(buttonList[index]["img"]),
                SizedBox(height: 5),
                Text(buttonList[index]["title"],style: TextStyle(
                  fontSize: ScreenAdaper.size(24),
                  color: XJColors.hexColor(0x282828)
                ))
              ],
            ),
          );
        },
      ),
    );
  }
  //底部联系方式
  Widget _bottomPhoneWidget(){
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("如下单有任何疑问,请电联",style: TextStyle(
            fontSize: ScreenAdaper.size(24),
            color: XJColors.hexColor(0x282828)
          )),
          InkWell(
            onTap: (){
              print("400-107-8186");
            },
            child: Text("400-107-8186",style: TextStyle(
              fontSize: ScreenAdaper.size(24),
              color: XJColors.hexColor(0x3475ec)
            )),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Container(
      color: Colors.white,
       child: ListView(
         children: <Widget>[
           Container(
             margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
             child: Text("尊敬的当日修用户:",style: TextStyle(
               fontSize: ScreenAdaper.size(28),
               color: XJColors.hexColor(0x282828)
             )),
           ),
           Container(
             margin: EdgeInsets.fromLTRB(10, 2, 10, 0),
             child: Row(
               children: <Widget>[
                 Expanded(
                   flex: 1,
                   child: Text(NightType.nightTime(),style: TextStyle(
                     fontSize: ScreenAdaper.size(52),
                     color: XJColors.hexColor(0x282828)
                   )),
                 ),
                 Expanded(
                   flex: 1,
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: <Widget>[
                       Container(
                         width: ScreenAdaper.width(180),
                         height: ScreenAdaper.height(60),
                         decoration: BoxDecoration(
                           color: XJColors.hexColor(0xe5e5e5),
                           borderRadius: BorderRadius.circular(10)
                         ),
                         child: InkWell(
                           onTap: (){
                             print('立即下单');
                           },
                           child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Text("立即下单",style: TextStyle(
                                fontSize: ScreenAdaper.size(28),
                                color: XJColors.hexColor(0x282828),
                              )),
                              // SizedBox(width: ScreenAdaper.width(5)),
                              Icon(Icons.play_arrow,color: Colors.black54,)
                            ],
                          ),
                         ),
                       )
                     ],
                   )
                 )
               ],
             ),
           ),
          _swiperWidget(),
          _detectionTypeWidget(),
          _hotwxTitleWidget(),
          _hotwxContentWidget(),
          _bottomBannerWidget(),
          _bottomZSWidget(),
          _bottomPhoneWidget()
         ],
       ),
    );
  }
}