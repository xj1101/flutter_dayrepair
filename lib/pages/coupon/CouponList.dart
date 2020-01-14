import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../services/ScreenAdaper.dart';
import '../../services/XJExtension.dart';
import '../../services/IsLoginSerVices.dart';
import '../../services/XJLoadingEmpty.dart';
import '../../network/Network.dart';
import '../../network/AAHttpManager.dart';
import '../../model/CouponListModel.dart';

import 'CouponListNCell.dart';
import 'CouponListYCell.dart';

class CouponListPage extends StatefulWidget {
  CouponListPage({Key key}) : super(key: key);

  _CouponListPageState createState() => _CouponListPageState();
}

class _CouponListPageState extends State<CouponListPage> {

  ///记录选项卡按钮的坐标
  int _sengMentIndex = 0;
  ///数据源数组
  List<CouponListItemModel> _dataArray = [];
  ///刷新
  EasyRefreshController _controller;
  int _dataCount = -1;

  ///使用类型（0->未使用，1->已使用）
  String useType = "0";
  ///订单id(去支付时才传订单id)
  String orderid = "";
  ///分页
  int pages = 0;
  

  @override
  void initState() { 
    super.initState();
    _controller = EasyRefreshController();
    _postCouponListRequest();
  }

  ///获取优惠券列表数据
  _postCouponListRequest(){
    var loginToken =  IsLoginSerVices.getLoginToken();
    loginToken.then((var token) async{
        AAHttpManager.postHttpHeaderRequest(
        params: {
          "use_type":this.useType,
          "order_id":this.orderid,
          "pages":this.pages.toString(),
          "limit":"10"
        },
        context: context,
        url: Network.drCouponListUrl,
        token: token.toString()
      ).then((resultJson){
        if(resultJson!=null){
          var model = CouponListModel.fromJson(resultJson["data"]);
          setState(() {
            if(this.pages==0){
              this._dataArray = model.list;
            }else{
              this._dataArray.addAll(model.list);
            }
            this._dataCount = this._dataArray.length;
            _controller.resetLoadState();
            _controller.finishRefresh();
          });
        }
      });
    });
  }
  
  ///扫一扫控件
  Widget _scanWidget(){
    return Container(
      height: ScreenAdaper.height(100),
      decoration: BoxDecoration(
        border:Border(
          bottom: BorderSide(
            width: 1,
            color: XJColors.hexColor(0xececec),
          )
        )
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 60,
            height: double.infinity,
            child: InkWell(
              child: Icon(Icons.fullscreen,size: 32,color: TextColor.drBrightTextColor),
            ),
          ),
          Container(
            width: ScreenAdaper.getScreenWidth()-120,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            decoration: BoxDecoration(
              color: XJColors.hexColor(0xececec),
              borderRadius: BorderRadius.circular(5)
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "请输入兑换码",
                hintStyle: TextStyle(
                  color: Colors.black26,
                  height: 0.7,
                  fontSize: ScreenAdaper.size(28)
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                suffixIcon: InkWell(
                  child: Icon(Icons.highlight_off,color: Colors.grey),
                ),
              ),
              style: TextStyle(
                color: TextColor.drDarkTextTwoColor,
                fontSize: ScreenAdaper.size(28),
              ),
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp("[a-zA-Z]|[0-9]")),
              ],
            ),
          ),
          Container(
            width: 60,
            height: double.infinity,
            child: InkWell(
              child: Center(
                child: Text("兑换",style: TextStyle(
                  color: TextColor.drBrightTextColor
                )),
              ),
            ),
          )
        ],
      ),
    );
  }

  ///切换按钮item
  Widget _sengButtonWidget(double width,String title,bool isSelected,Function cb){
    return InkWell(
      onTap: cb,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: isSelected?TextColor.drBrightTextColor:Colors.white,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Center(
          child: Text(title,style: TextStyle(
            fontSize: ScreenAdaper.size(30),
            color: isSelected?Colors.white:Colors.black
          )),
        ),
      ),
    );
  }

  ///切换按钮
  Widget _sengMentWidget(){
    double sengMentWidth = (ScreenAdaper.getScreenWidth()/2)-ScreenAdaper.width(112);
    return Container(
      height: 40,
      margin: EdgeInsets.fromLTRB(ScreenAdaper.width(110), 20, ScreenAdaper.width(110), 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: TextColor.drBrightTextColor
        ),
        borderRadius: BorderRadius.circular(30)
      ),
      child: Row(
        children: <Widget>[
          _sengButtonWidget(sengMentWidth, "未使用",_sengMentIndex==0?true:false,(){
            setState(() {
              this._sengMentIndex=0;
              this.pages = 0;
              this.useType = "0";
              this._dataArray.clear();
              _postCouponListRequest();
            });
          }),
          _sengButtonWidget(sengMentWidth, "已使用",_sengMentIndex==1?true:false,(){
            setState(() {
              this._sengMentIndex=1;
              this.pages = 0;
              this.useType = "1";
              this._dataArray.clear();
              _postCouponListRequest();
            });
          })
        ],
      ),
    );
  }

  Future <void> _onRefresh() async {
    this.pages = 0;
    return _postCouponListRequest();
  }

  Future <void> _onLoadingMore() async {
    this.pages += 1;
    return _postCouponListRequest();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
       appBar: AppBar(
         elevation: 1,
         title: Text("我的优惠券"),
       ),
       body: Column(
         children: <Widget>[
           _scanWidget(),
           _sengMentWidget(),
           Expanded(
            child: this._dataArray.length>0?EasyRefresh(
              child: ListView.builder(
                itemCount: this._dataArray.length,
                itemBuilder: (context,index){
                  return _sengMentIndex==0?CouponListNCell(model: this._dataArray[index]):CouponListYCell();
                },
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
           )
         ],
       ),
    );
  }
}