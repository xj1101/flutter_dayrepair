import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../services/ScreenAdaper.dart';
import '../../services/XJButton.dart';
import '../../services/XJExtension.dart';
import '../../services/EventBus.dart';
import '../../services/IsLoginSerVices.dart';
import '../../network/Network.dart';
import '../../network/AAHttpManager.dart';
import '../../services/XJLoadingEmpty.dart';
import '../../model/AddressListModel.dart';
import 'AddressListCell.dart';

class AddressListPage extends StatefulWidget {
  AddressListPage({Key key}) : super(key: key);

  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {

  ///页码,默认为 0
  int pages=0;
  ///取的个数,默认20个
  String limit='10';
  ///地址模型
  List<AddressItemModel> addressArray = [];
  ///记录事件监听事件，用于取消事件监听
  var _eventBusOn;
  ///刷新
  EasyRefreshController _controller;

  @override
  void dispose() {
    this._eventBusOn.cancel();//取消事件监听
    super.dispose();
  }

  @override
  void initState() { 
    super.initState();
     _controller = EasyRefreshController();
    _postAddressListRequest();

    //监听新增地址或者修改地址广播
    this._eventBusOn=eventBus.on<SubmitAddressEvent>().listen((event){
      this.pages = 0;
      _postAddressListRequest();
    });
  }
  
  ///获取服务地址列表数据
  _postAddressListRequest(){
    var loginToken =  IsLoginSerVices.getLoginToken();
    loginToken.then((var token) async{
        AAHttpManager.postHttpHeaderRequest(
        params: {
          "pages":this.pages.toString(),
          "limit":this.limit
        },
        context: context,
        url: Network.drAddressListUrl,
        token: token.toString()
      ).then((resultJson){
        if(resultJson!=null){
          var model = AddressListModel.fromJson(resultJson["data"]);
          setState(() {
            if(this.pages==0){
              this.addressArray = model.list;
            }else{
              this.addressArray.addAll(model.list);
            }
            _controller.resetLoadState();
            _controller.finishRefresh();
          });
        }
      });
    });
  }

  Future <void> _onRefresh() async {
    this.pages = 0;
    return _postAddressListRequest();
  }

  Future <void> _onLoadingMore() async {
    this.pages += 1;
    return _postAddressListRequest();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
       appBar: AppBar(
         elevation: 1,
         title: Text("服务地址"),
       ),
       body: Stack(
         children: <Widget>[
           this.addressArray.length>0?EasyRefresh(
             child: ListView.builder(
              itemCount: this.addressArray.length,
              itemBuilder: (context,index){
                return Column(
                  children: <Widget>[
                    AddressListCellPage(this.addressArray[index]),
                    SizedBox(height: 20)
                  ],
                );
              },
            ),
            footer: ClassicalFooter(
              enableInfiniteLoad: false
            ),
            controller: _controller,
            onRefresh: _onRefresh,
            onLoad: _onLoadingMore,
           ):XJLoadingEmpty(),
           Positioned(
             bottom: ScreenAdaper.getBottomBarHeight()+20,
             child: Container(
               width: ScreenAdaper.getScreenWidth(),
               child: XJButton(
                 text: "新增地址",
                 height: ScreenAdaper.height(90),
                 color: TextColor.drBrightTextColor,
                 margin: EdgeInsets.fromLTRB(45, 0, 45, 0),
                 fontSize: ScreenAdaper.size(32),
                 radius: 20,
                 cb: (){
                   Navigator.pushNamed(context, "/newlyAddress");
                 },
               ),
             ),
           )
         ],
       ),
    );
  }
}