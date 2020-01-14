import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/ScreenAdaper.dart';
import '../../services/XJTextField.dart';
import '../../services/XJButton.dart';
import '../../services/EventBus.dart';
import '../../network/Network.dart';
import '../../services/IsLoginSerVices.dart';
import '../../services/XJExtension.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //记录用户名
  String username='';
  //记录验证码
  String verificationCode='';

  TextEditingController uEditingController = TextEditingController();
  TextEditingController vEditingController = TextEditingController();

  //监听登录页面销毁的事件
  dispose(){
    super.dispose();
    eventBus.fire(UserEvent("登录成功"));
  }

  //登录(网络请求)
  loginRequest() async{
    RegExp reg = new RegExp(r"^1\d{10}$");
    if(this.username.length==0){
      Fluttertoast.showToast(
        msg: '请输入手机号',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return;
    }else{
      if (!reg.hasMatch(this.username)) {
        Fluttertoast.showToast(
          msg: '手机号格式不对',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        return;
      }
    }
    if(this.verificationCode.length==0){
      Fluttertoast.showToast(
        msg: '请输入验证码',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return;
    }
      // Map dic = {
      //   "mobile": "18779286550", 
      //   "nickname": "青峰", 
      //   "user_id": "11366", 
      //   "head_pic": "http://img.dangrixiu.cn/Ftpc2zdBIDfEU15_rLGfWQJ0qmyB", 
      //   "device_tokens": "0d9d30d4170fc304676a306b87ba0b2e697d6fbeff811da7f35b4dcc8ac2b743", 
      //   "service_line": "400-107-8168", 
      //   "slogan": "匠心品质-专业质保", 
      //   "token": "11366|53ce2c5ad15b93df8f39886cc6", 
      //   "join_status": "1", 
      //   "view_num": "0", 
      //   "is_directly": "0", 
      //   "province": "28240", 
      //   "province_name": "广东省", 
      //   "city": "28558", 
      //   "city_name": "深圳市", 
      //   "district": "28590", 
      //   "district_name": "宝安区", 
      //   "sex": "1", 
      //   "wechat": "1", 
      //   "orders_num": "0", 
      //   "deal_with_num": 0, 
      //   "completed_num": 0, 
      //   "after_sales_num": 0, 
      //   "count_waitpay": 1, 
      //   "count_waitsend": 0, 
      //   "count_waitreceive": 0, 
      //   "count_waitccomment": 0, 
      //   "level": "初级工程师"
      // };
      // IsLoginSerVices.setIsLoginState([dic]);
      // Navigator.pop(context);
    Map parameters = {
      "phone":this.username,
      "code":this.verificationCode,
      "unique_id":"",
      "device_tokens":"0d9d30d4170fc304676a306b87ba0b2e697d6fbeff811da7f35b4dcc8ac2b743"
    };

    var api = Network.domain + Network.drloginUrl;
    var result = await Dio().post(api,data: parameters);
    Map<String, dynamic> resultJson = json.decode(result.data);
    // print("=======分割线============${resultJson}");
    if(resultJson["status"]==1){
      IsLoginSerVices.setLoginToken(resultJson["data"]["token"]);
      IsLoginSerVices.setIsLoginState([resultJson["data"]["user_info"]]);
      Navigator.pop(context);
    }else{
      Fluttertoast.showToast(
        msg: resultJson["msg"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    
  }
  
  //手机号码
  Widget _phoneTextFieldWidget(){
    return Container(
      margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
      height: ScreenAdaper.height(90),
      child: Row(
        children: <Widget>[
          Text("手机号",style: TextStyle(
            fontSize: ScreenAdaper.size(30),
            color: TextColor.drDarkTextTwoColor
          )),
          Container(
            margin: EdgeInsets.fromLTRB(5, 12, 0, 12),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  width: 1,
                  color: XJColors.hexColor(0xe1e1e1)
                )
              )
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: XJTextField(
                text: "请输入手机号",
                controller: uEditingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(11)
                ],
                onChanged: (text){
                  setState(() {
                    this.username = text;
                  });
                },
              ),
            ),
          ),
          this.username.length>0?IconButton(
            icon: Icon(Icons.highlight_off,color: Colors.grey,),
            onPressed: (){
              setState(() {
                this.username = "";
                uEditingController.text = "";
              });
            },
          ):Text("")
        ],
      ),
    );
  }

  //验证码
  Widget _yzmTextFieldWidget(){
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      height: ScreenAdaper.height(90),
      child: Row(
        children: <Widget>[
          Text("验证码",style: TextStyle(
            fontSize: ScreenAdaper.size(30),
            color: TextColor.drDarkTextTwoColor
          )),
          Container(
            margin: EdgeInsets.fromLTRB(5, 12, 0, 12),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  width: 1,
                  color: XJColors.hexColor(0xe1e1e1)
                )
              )
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: XJTextField(
                text: "请输入验证码",
                controller: vEditingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4)
                ],
                onChanged: (text){
                  setState(() {
                    this.verificationCode = text;
                  });
                },
              ),
            ),
          ),
          this.verificationCode.length>0?IconButton(
            icon: Icon(Icons.highlight_off,color: Colors.grey,),
            onPressed: (){
              setState(() {
                this.verificationCode = "";
                vEditingController.text = "";
              });
            },
          ):Text("")
        ],
      ),
    );
  }

  //登录按钮
  Widget _loginButtonWidget(){
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: XJButton(
            color: TextColor.drBrightTextColor,
            height: ScreenAdaper.height(90),
            text: "登录",
            fontSize: ScreenAdaper.size(30),
            // cb: (){
            //   Storage.setString("isLogin", json.encode([1]));
            //   Navigator.pop(context);
            // },
            cb: loginRequest,
          ),
        ),
        Container(
          child: Text("首次登录将自动创建新账号",style: TextStyle(
            color: XJColors.hexColor(0xa1a1a1),
            fontSize: ScreenAdaper.size(24)
          )),
        )
      ],
    );
  }

  //其它方式登录
  Widget _ortherLoginWidget(){
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            children: <Widget>[
              Container(
                width: ScreenAdaper.width(220),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: TextColor.drDarkTextColor
                    )
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text("其它方式登录",style: TextStyle(
                  fontSize: ScreenAdaper.size(22),
                  color: TextColor.drDarkTextColor
                )),
              ),
              Container(
                width: ScreenAdaper.width(220),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: TextColor.drDarkTextColor
                    )
                  )
                ),
              ),
            ],
          ),
        ),
        InkWell(
          child: Container(
            margin: EdgeInsets.only(top: 15),
            child: Image.asset("images/WxLogin.png"),
          ),
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return GestureDetector(
       onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  width: ScreenAdaper.width(120),
                  height: ScreenAdaper.width(120),
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Image.asset("images/drx_logon.png",fit: BoxFit.cover),
                )
              ),
              Center(
                child: Text("手机验证登录",style: TextStyle(
                  color: TextColor.drBrightTextColor,
                  fontSize: ScreenAdaper.size(32)
                )),
              ),
              _phoneTextFieldWidget(),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Divider(height: 0),
              ),
              SizedBox(height: 10),
              _yzmTextFieldWidget(),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Divider(height: 0),
              ),
              _loginButtonWidget(),
              Container(
                height: ScreenAdaper.height(200),
                margin: EdgeInsets.only(top: ScreenAdaper.height(400)-ScreenAdaper.height(130)),
                // color: Colors.red,
                child: _ortherLoginWidget(),
              )
            ],
          ),
        ),
        )
      ),
    );
  }
}

