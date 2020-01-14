import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/ScreenAdaper.dart';
import '../../services/XJExtension.dart';
import '../../pages/my/MyOrderItem.dart';
import '../../pages/my/MyCell.dart';
import '../../services/IsLoginSerVices.dart';
import '../../services/EventBus.dart';

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin{

  bool isLogin = false;
  List userInfo = [];

  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState() { 
    super.initState();
    _getIsLogin();

    //监听登录后改变登录状态
    eventBus.on<UserEvent>().listen((event){
      _getIsLogin();
    });
  }

  _getIsLogin() async {
    var isLogin = await IsLoginSerVices.getIsLoginState();
    var userInfo =  IsLoginSerVices.getUserInfo();
    userInfo.then((var userInfo) {
       this.userInfo = userInfo;
      }).catchError((error)=> error);
    setState(() {
      this.isLogin = isLogin;
    });
    
  }

  //头部信息
  Widget _headerWidget(){
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 0, 15),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          // this.userInfo.length>0?Image.network(this.userInfo.first["head_pic"],fit: BoxFit.cover,):Image.asset("images/drx_no_login.png",fit: BoxFit.cover),
          Container(
            width: 75,
            height: 75,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(75),
              child: this.userInfo.length>0?Image.network(this.userInfo.first["head_pic"],fit: BoxFit.cover,):Image.asset("images/drx_no_login.png",fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(this.userInfo.length>0?this.userInfo.first["nickname"]:"点击登录",style: TextStyle(
                fontSize: ScreenAdaper.size(42)
              )),
              Text(this.userInfo.length>0?this.userInfo.first["slogan"]:"登陆后可保存数据",style: TextStyle(
                fontSize: ScreenAdaper.size(28)
              ))
            ],
          )
        ],
      ),
    );
  }

  //维修订单
  Widget _wxOrderWidget(){
    var imageArray = [
      {"image":"images/my_wxdd.png","title":"维修订单"},
      {"image":"images/my_yhj.png","title":"优惠券"},
      {"image":"images/my_fwdz.png","title":"服务地址"}
    ];
    return Container(
      height: ScreenAdaper.height(160),
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: imageArray.asMap().keys.map((index){
          return MyOrderItemPage(
            title: imageArray[index]["title"],
            imageStr: imageArray[index]["image"],
            cb: (){
              if(index==0){
                Navigator.pushNamed(context, "/wxOrder");
              }
              if(index==1){
                Navigator.pushNamed(context, "/couponList");
              }
              if(index==2){
                Navigator.pushNamed(context, "/addressList");
              }
              print(imageArray[index]["title"]);
            },
          );
        }).toList(),
      ),
    );
  }

  //商城订单
  Widget _mallOrderWidget(){
    return Container(
      height: ScreenAdaper.height(160),
      margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          MyOrderItemPage(
            title: "商城订单",
            imageStr: "images/my_order.png",
            cb: (){
            },
          ),
          MyOrderItemPage(
            title: "待支付",
            ishiddenTitle: false,
            numStr: this.userInfo.length>0?this.userInfo.first["count_waitpay"]:"0",
            cb: (){
            },
          ),
          MyOrderItemPage(
            title: "代发货",
            ishiddenTitle: false,
            numStr: this.userInfo.length>0?this.userInfo.first["count_waitsend"]:"0",
            cb: (){
            },
          ),
          MyOrderItemPage(
            title: "待收货",
            ishiddenTitle: false,
            numStr: this.userInfo.length>0?this.userInfo.first["count_waitreceive"]:"0",
            cb: (){
            },
          ),
          MyOrderItemPage(
            title: "待评价",
            ishiddenTitle: false,
            numStr: this.userInfo.length>0?this.userInfo.first["count_waitccomment"]:"0",
            cb: (){
            },
          )
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
       appBar: AppBar(
         elevation: 0.0,
         actions: <Widget>[
           IconButton(
             icon: Icon(Icons.email),
             onPressed: (){},
           ),
           IconButton(
             icon: Icon(Icons.settings),
             onPressed: (){},
           ),
         ],
       ),
       body: Container(
         color: Colors.white,
         child: ListView(
          children: <Widget>[
            _headerWidget(),
            _wxOrderWidget(),
            _mallOrderWidget(),
            Divider(height: 0),
            MycellPage(
              leftTitle: "联系客服",
              rightTitle: "400-107-8186",
              cb: (){
                if(this.isLogin==false){
                  Navigator.pushNamed(context, "/login");
                }
              },
            ),
            Divider(height: 0),
            MycellPage(
              leftTitle: "维修网点",
              cb: (){
                Navigator.pushNamed(context, "/repairList");
              },
            ),
            Divider(height: 0),
            MycellPage(
              leftTitle: "服务流程",
              cb: (){
                Navigator.pushNamed(context, "/login");
              },
            ),
            Divider(height: 0),
            MycellPage(
              leftTitle: "帮助中心",
              cb: (){
                
              },
            ),
            Divider(height: 0),
          ],
        ),
       ),
    );
  }
}