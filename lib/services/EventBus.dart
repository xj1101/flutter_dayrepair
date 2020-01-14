import 'package:event_bus/event_bus.dart';

//Bus 初始化 
EventBus eventBus = EventBus();

//用户中心广播
class UserEvent{
  String str;
  UserEvent(String str){
    this.str=str;
  }
}

//维修订单类型选择广播
class WxOrderEvent{
  int index;
  WxOrderEvent(int index){
    this.index=index;
  }
}

//新增地址或者修改地址广播
class SubmitAddressEvent{
  String str;
  SubmitAddressEvent(String str){
    this.str=str;
  }
}