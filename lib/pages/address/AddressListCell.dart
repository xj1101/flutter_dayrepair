import 'package:flutter/material.dart';

import '../../services/XJExtension.dart';
import '../../services/ScreenAdaper.dart';
import '../../model/AddressListModel.dart';
import '../../services/XJAlertView.dart';
import '../../network/AAHttpManager.dart';
import '../../network/Network.dart';
import '../../services/EventBus.dart';
import '../../services/IsLoginSerVices.dart';

class AddressListCellPage extends StatelessWidget {

  final AddressItemModel model;

  const AddressListCellPage(this.model,{Key key}) : super(key: key);

  ///删除服务地址(网络请求)
  _postDelAddressRequest(BuildContext context,String addressid){
    var loginToken =  IsLoginSerVices.getLoginToken();
    loginToken.then((var token) async{
        AAHttpManager.postHttpHeaderRequest(
        params: {
          "address_id":addressid,
        },
        context: context,
        url: Network.drDelAddressUrl,
        token: token.toString()
      ).then((resultJson){
        if(resultJson!=null){
          eventBus.fire(SubmitAddressEvent("删除成功"));
        }
      });
    });
  }

  ///自定义按钮
  Widget _inkWellButonWidget(String title,IconData icons,cb){
    return InkWell(
      onTap: cb,
      child: Row(
        children: <Widget>[
          Icon(icons,color: TextColor.drDarkTextColor),
          Text(title,style: TextStyle(
            fontSize: ScreenAdaper.size(26),
            color: TextColor.drDarkTextTwoColor
          ))
        ],
      ),
    );
  }
  ///默认地址按钮
  Widget _defaultButtonWidget(cb){
    return InkWell(
      onTap: cb,
      child: Row(
        children: <Widget>[
          Icon(Icons.radio_button_checked,color: TextColor.drBrightTextColor),
          SizedBox(width: 5),
          Text("默认当前地址",style: TextStyle(
            fontSize: ScreenAdaper.size(26),
            color: TextColor.drBrightTextColor
          ))
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    var address = this.model.provinceName+this.model.cityName+this.model.areaName+this.model.addressDetail;
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: XJColors.hexColor(0x1F000000,alpha: 0.10),
          width: 1
        ),
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Text("${this.model.consignee}",style: TextStyle(
                    fontSize: ScreenAdaper.size(26),
                    color: TextColor.drDarkTextTwoColor
                  )),
                  SizedBox(width: 50),
                  Text("${this.model.mobile}",style: TextStyle(
                    fontSize: ScreenAdaper.size(26),
                    color: TextColor.drDarkTextTwoColor
                  ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(address,style: TextStyle(
                fontSize: ScreenAdaper.size(26),
                color: TextColor.drDarkTextTwoColor
              )),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  this.model.isDefault=="1"?_defaultButtonWidget((){

                  }):Text(""),
                  Container(
                    child: Row(
                      children: <Widget>[
                        _inkWellButonWidget("修改", Icons.mode_edit, (){
                          Navigator.pushNamed(context, "/newlyAddress",arguments: {
                            "model":this.model
                          });
                        }),
                        SizedBox(width: 10),
                        _inkWellButonWidget("删除", Icons.delete, (){
                          XJalertView.showAlertDialog(context,"提示警告","是否删除此地址!",(){
                            print("dasdasdasdasdsd");
                            _postDelAddressRequest(context, this.model.addressId);
                          });
                        })
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
