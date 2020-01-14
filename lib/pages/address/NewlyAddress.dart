import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:amap_location/amap_location.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../thirdLibrary/address_picker/address_picker.dart';
import '../../thirdLibrary/address_picker/address_manager.dart';
import '../../thirdLibrary/address_picker/address_model.dart';
import '../../services/XJExtension.dart';
import '../../services/ScreenAdaper.dart';
import '../../services/XJButton.dart';
import '../../services/EventBus.dart';
import '../../services/IsLoginSerVices.dart';
import '../../network/Network.dart';
import '../../network/AAHttpManager.dart';

import 'NewlyTextView.dart';

class NewlyAddressPage extends StatefulWidget {
  final Map arguments;

  NewlyAddressPage({Key key,this.arguments}) : super(key: key);

  _NewlyAddressPageState createState() => _NewlyAddressPageState();
}

class _NewlyAddressPageState extends State<NewlyAddressPage> {

  ///定位获取详细地址
  String _formattedAddress; 

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressdetailController = TextEditingController();

  ///姓名(参数)
  String username = "";
  ///手机号(参数)
  String phone = ""; 
  ///验证码(参数)
  String code = "";
  ///省ID(参数)
  String provinceid = "";
  ///市ID(参数)
  String cityid = "";
  ///区(参数)
  String areaid = "";
  ///详细地址(参数)
  String addressdetail = "";
  ///短信验证码唯一标识ID(参数)
  String uniqueid = "";
  ///是否默认地址(参数->1=默认 0=不是默认)
  String isdefault = "0";
  ///地址ID(参数->有则修改，没有则新增)
  String addressid = "";

  ///是否选中默认地址按钮
  bool _isRadioSelected = false;
  ///省市区
  String _address = "";

  @override
  void initState() {
    super.initState();
    if(widget.arguments!=null){
      this.username = widget.arguments["model"].consignee;
      this.phone = widget.arguments["model"].mobile;
      this.provinceid = widget.arguments["model"].provinceId;
      this.cityid = widget.arguments["model"].cityId;
      this.areaid = widget.arguments["model"].areaId;
      this.addressdetail = widget.arguments["model"].addressDetail;
      this.addressid = widget.arguments["model"].addressId;
      this.isdefault = widget.arguments["model"].isDefault;
      this.isdefault=="1"?_isRadioSelected=true:_isRadioSelected=false;
      this._formattedAddress =  widget.arguments["model"].provinceName + widget.arguments["model"].cityName + widget.arguments["model"].areaName;
      print("=================${widget.arguments["model"].consignee}");

      usernameController.text = this.username;
      phoneController.text = this.phone;
      addressdetailController.text = this.addressdetail;
    }
    
  }

  //获取定位信息
  void _loaction() async {
    var location = AMapLocationClient.getLocation(true);
    location.then((AMapLocation location){
      setState(() {
        this._formattedAddress = location.formattedAddress;
      });
      var addressArray = AddressManager.loadAddressData(context);
      addressArray.then((List array){
        for(var i=0;i<array.length;i++){
          AddressProvince provinceModel = array[i];
          if(provinceModel.province==location.province){
            this.provinceid = provinceModel.provinceid;
          }
          for(var j=0;j<provinceModel.cities.length;j++){
            AddressCity cityModel = provinceModel.cities[j];
            if(cityModel.city==location.city){
              this.cityid = cityModel.cityid;
            }
            for(var n=0;n<cityModel.district.length;n++){
              AddressDistrict districtModel = cityModel.district[n];
              if(districtModel.area==location.district){
                this.areaid = districtModel.areaid;
              }
            }
          }
        }
        print("provinceid======${this.provinceid}");
        print("cityid======${this.cityid}");
        print("areaid======${this.areaid}");
      });
      print("latitude======${location.latitude}");
      print("longitude======${location.longitude}");
      print("formattedAddress======${location.formattedAddress}");
      print("province======${location.province}");
      print("city======${location.city}");
      print("district======${location.district}");
      print("street======${location.street}");
    });
  }

   //添加地址/修改地址(网络请求)
  submitAddressRequest(){
    if(this.username.length==0){
      Fluttertoast.showToast(
        msg: '请输入姓名',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    RegExp reg = new RegExp(r"^1\d{10}$");
    if(this.phone.length==0){
      Fluttertoast.showToast(
        msg: '请输入手机号',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return;
    }else{
      if (!reg.hasMatch(this.phone)) {
        Fluttertoast.showToast(
          msg: '手机号格式不对',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        return;
      }
    }
    if(this.code.length==0){
      Fluttertoast.showToast(
        msg: '请输入验证码',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    if(this.provinceid.length==0){
      Fluttertoast.showToast(
        msg: '请选择您的地区',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    if(this.addressdetail.length==0){
      Fluttertoast.showToast(
        msg: '请请输入详细地址',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    var loginToken =  IsLoginSerVices.getLoginToken();
    loginToken.then((var token)async{
      AAHttpManager.postHttpHeaderRequest(
        params: {
          "username":this.username,
          "phone":this.phone,
          "code":this.code,
          "province_id":this.provinceid,
          "city_id":this.cityid,
          "area_id":this.areaid,
          "address_detail":this.addressdetail,
          "address_id":this.addressid,
          "is_default":this.isdefault,
          "unique_id":this.uniqueid,
        },
        context: context,
        url: Network.drSubmitAddressUrl,
        token: token
      ).then((resultJson){
        eventBus.fire(SubmitAddressEvent("新增成功"));
        Fluttertoast.showToast(
          msg: widget.arguments==null?"新增成功":"修改成功",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        Future.delayed(Duration(seconds: 1),(){
          Navigator.pop(context);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         elevation: 1,
         title: Text("新增地址"),
       ),
       body: Column(
         children: <Widget>[
           Container(
             height: 45,
             color: XJColors.hexColor(0xececec),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Icon(Icons.error,color: TextColor.drBrightTextColor),
                 Text("请认真填写您的下单信息",style: TextStyle(
                   color: TextColor.drBrightTextColor
                 ))
               ],
             ),
           ),
           Expanded(
             child: ListView(
              children: <Widget>[
                NewlyTextView(
                  leftTitle: "姓   名",
                  hintText: "请输入姓名",
                  controller: usernameController,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]")),//只允许输入汉字
                  ],
                  onChanged: ((text){
                    this.username = text;
                  }),
                ),
                NewlyTextView(
                  leftTitle: "手机号",
                  hintText: "请输入手机号",
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11)
                  ],
                  onChanged: ((text){
                    this.phone = text;
                  }),
                ),
                NewlyTextView(
                  leftTitle: "验证码",
                  hintText: "请输入验证码",
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4)
                  ],
                  index: 1,
                  onChanged: ((text){
                    this.code = text;
                  }),
                ),
                NewlyTextView(
                  leftTitle: "地   区",
                  hintText: "选择您的地区",
                  index: 2,
                  enabled: false,
                  addContent: this._formattedAddress??"选择您的地区",
                  onTapCallback: ()async{
                    _loaction();
                  },
                  addContentTapCallback: (){
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => BottomSheet(
                        onClosing: () {},
                        builder: (context) => Container(
                          height: 250,
                          child: AddressPicker(
                            style: TextStyle(color: Colors.black, fontSize: 17),
                            mode: AddressPickerMode.provinceCityAndDistrict,
                            onSelectedAddressChanged: (address) {
                              print('${address.currentProvince.province}');
                              print('${address.currentCity.city}');
                              print('${address.currentDistrict.area}');
                            },
                            onDetermineAddressChanged: (address){
                              print('${address.currentProvince.province}');
                              var newlyAddress = address.currentProvince.province+address.currentCity.city+address.currentDistrict.area;
                              this.provinceid = address.currentProvince.provinceid;
                              this.cityid = address.currentCity.cityid;
                              this.areaid = address.currentDistrict.areaid;
                              if(address.currentProvince.province=="北京市" || 
                                  address.currentProvince.province=="天津市" || 
                                  address.currentProvince.province=="上海市" || 
                                  address.currentProvince.province=="重庆市"){
                                newlyAddress = address.currentProvince.province+address.currentDistrict.area;
                              }
                              setState(() {
                                this._formattedAddress = newlyAddress;
                              });
                            },
                          ),
                        ),
                      )
                    );
                  },
                ),
                NewlyTextView(
                  leftTitle: "地   址",
                  hintText: "请输入详细地址",
                  controller: addressdetailController,
                  onChanged: ((text){
                    this.addressdetail = text;
                  }),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(right: 15),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        this._isRadioSelected = !this._isRadioSelected;
                        this._isRadioSelected?this.isdefault="1":this.isdefault="0";
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(this._isRadioSelected?Icons.radio_button_checked:Icons.radio_button_unchecked,color: TextColor.drBrightTextColor),
                        SizedBox(width: 5),
                        Text("设为默认地址",style: TextStyle(
                          fontSize: ScreenAdaper.size(26),
                          color: TextColor.drBrightTextColor
                        ))
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: XJButton(
                    text: widget.arguments==null?"新增地址":"修改地址",
                    height: ScreenAdaper.height(90),
                    color: TextColor.drBrightTextColor,
                    margin: EdgeInsets.fromLTRB(45, 0, 45, 0),
                    fontSize: ScreenAdaper.size(32),
                    radius: 20,
                    cb: submitAddressRequest,
                  ),
                )
              ],
            ),
           )
         ],
       ),
    );
  }
}