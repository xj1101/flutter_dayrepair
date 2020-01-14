import 'package:flutter/material.dart';

import '../pages/tabs/Tab.dart'; //底部根视图
import '../pages/repairDevice/RepairDevice.dart'; //维修设备
import '../pages/login/Login.dart'; //登录
import '../pages/wx_order/WxOrder.dart'; //维修订单
import '../pages/wx_order_detail/WxOrderDetail.dart'; //维修订单详情
import '../pages/address/AddressList.dart'; //服务地址
import '../pages/address/NewlyAddress.dart'; //新增地址
import '../pages/coupon/CouponList.dart'; //我的优惠券
import '../pages/repair/RepairList.dart'; //维修网点
import '../web/webView.dart'; //网页试图
import '../pages/helpcenter/HelpCenter.dart'; //帮助中心
import '../pages/commodityDetails/CommodityDetails.dart'; //商品详情

final routes = {
  '/':(context) => Tabs(),
  '/repairDevice': (context) => RepairDevice(),
  '/login': (context) => LoginPage(),
  '/wxOrder': (context) => WxOrderPage(),
  '/wxOrderDetail': (context,{arguments}) => WxOrderDetailPage(arguments: arguments),
  '/addressList': (context) => AddressListPage(),
  '/newlyAddress': (context,{arguments}) => NewlyAddressPage(arguments: arguments),
  '/couponList': (context) => CouponListPage(),
  '/repairList': (context) => RepairListPage(),
  '/webView': (context,{arguments}) => WebViewPage(arguments: arguments),
  '/helpCenter': (context) => HelpCenterPage(),
  '/commodityDetails': (context,{arguments}) => CommodityDetailsPage(arguments: arguments),
};

var onGenerateRoute = (RouteSettings settings){
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    }else{
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};