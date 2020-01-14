import 'package:dayrepair/network/Network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../network/AAHttpManager.dart';
import '../../services/XJLoadingEmpty.dart';
import '../../model/RepairListModel.dart';

import 'RepairListCell.dart';
class RepairListPage extends StatefulWidget {
  RepairListPage({Key key}) : super(key: key);

  _RepairListPageState createState() => _RepairListPageState();
}

class _RepairListPageState extends State<RepairListPage> {

  ///数据源数组
  List<RepairListItemModel> _dataArray = [];
  ///刷新
  EasyRefreshController _controller;
  int _dataCount = -1;
  ///分页
  int pages = 0;

  @override
  void initState() { 
    super.initState();
     _controller = EasyRefreshController();
    _postSuppliersListRequest();
  }
  ///维修网点(网络请求)
  _postSuppliersListRequest(){
    AAHttpManager.postHttpRequest(
      params: {
        "latitude":"0",
        "longitude":"0",
        "server_type":"",
        "address_id":"",
        "pages":this.pages.toString(),
        "limit":"10"
      },
      url: Network.drSuppliersListUrl,
      context: context
    ).then((resultJson){
      //  print("===========分割线============${resultJson}");
       if(resultJson!=null){
         var model = RepairListModel.fromJson(resultJson);
          setState(() {
            if(this.pages==0){
              this._dataArray = model.data;
            }else{
              this._dataArray.addAll(model.data);
            }
            this._dataCount = this._dataArray.length;
            _controller.resetLoadState();
            _controller.finishRefresh();
          });
       }
    });
  }

  Future <void> _onRefresh() async {
    this.pages = 0;
    return _postSuppliersListRequest();
  }

  Future <void> _onLoadingMore() async {
    this.pages += 1;
    return _postSuppliersListRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         elevation: 1,
         title: Text("维修网点")
      ),
      body: this._dataArray.length>0?EasyRefresh(
        child: ListView.builder(
          itemCount: this._dataArray.length,
          itemBuilder: (context,index){
            return RepairListCell(model: this._dataArray[index]);
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
    );
  }
}