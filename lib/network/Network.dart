import 'dart:io';
import 'package:dio/dio.dart';

class Network{
  //网络请求地址
  static String domain = "https://wx.dangrixiu.cn/";
  // static String domain = "https://cs.dangrixiu.cn/";

  //请求头
  static Options aaHeaders = Options(
    headers: {
      HttpHeaders.acceptHeader:"accept: application/json",
      "device":"2"
    }
  );

  static Options aaHeadersDevice(String token){
    return Options(
      headers: {
        HttpHeaders.acceptHeader:"accept: application/json",
        "device":"2",
        "token":token
      }
    );
  }

  ///维修首页
  static String drxserviceIndexUrl = "api/service/index";
  ///手机型号
  static String drxphoneTypeUrl = "api/service/get_phone_type";
  ///商城首页
  static String drmallIndexUrl = "api/Mall/index";
  ///商城首页品牌商品
  static String drgoodsCategoryListUrl = "api/Mall/goods_category_list";
  ///商城首页品牌商品
  static String drloginUrl = "api/user/login";
  ///维修订单列表
  static String drOrderListUrl = "api/order/order_list";
  ///维修订单详情
  static String drOrderDetailUrl = "api/order/order_detail";
  ///服务地址
  static String drAddressListUrl = "api/user/address_list";
  ///添加地址
  static String drSubmitAddressUrl = "api/user/submit_address";
  ///删除地址
  static String drDelAddressUrl = "api/user/del_address";
  ///优惠券列表
  static String drCouponListUrl = "api/coupon/coupon_list";
  ///维修网点
  static String drSuppliersListUrl = "api/address/get_suppliers_list";
  ///商品详情
  static String drGoodsDetailUrl = "api/Mall/goods_detail";
}