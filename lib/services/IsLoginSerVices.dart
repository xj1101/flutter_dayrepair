import 'dart:convert';
import 'Storage.dart';

class IsLoginSerVices{

  static getUserInfo() async{
    List userinfo; 
    try{
      userinfo= json.decode(await Storage.getString("isLogin"));
    } catch(e){
      userinfo = [];
    }
    return userinfo;    
  }

   //获取登录状态
  static getIsLoginState() async{
    var userinfo =await IsLoginSerVices.getUserInfo();
    if(userinfo.length>0){
      return true;  
    }
    return false;    
  }

  //设置登录状态
  static setIsLoginState(value) async{    
      await Storage.setString("isLogin", json.encode(value));
  }

  //设置登录后的Token
  static setLoginToken(value) async{    
     await Storage.setString("token", json.encode(value));
  }

  //获取登录后的Token
  static getLoginToken() async{
    var token; 
    try{
      token= json.decode(await Storage.getString("token"));
    } catch(e){
      token = "";
    }
    return token;    
  }
}