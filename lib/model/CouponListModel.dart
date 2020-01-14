class CouponListModel {
  List<CouponListItemModel> list;

  CouponListModel({this.list});

  CouponListModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<CouponListItemModel>();
      json['list'].forEach((v) {
        list.add(new CouponListItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CouponListItemModel {
  String id;
  String cid;
  String type;
  String uid;
  String orderId;
  String getOrderId;
  String useTime;
  String code;
  String sendTime;
  String status;
  String getTime;
  String couponPrice;
  Null agentId;
  String engineerId;
  String name;
  String useStartTime;
  String useEndTime;
  String condition;
  String money;
  String canUse;
  String couponType;
  String outTime;

  CouponListItemModel(
      {this.id,
      this.cid,
      this.type,
      this.uid,
      this.orderId,
      this.getOrderId,
      this.useTime,
      this.code,
      this.sendTime,
      this.status,
      this.getTime,
      this.couponPrice,
      this.engineerId,
      this.name,
      this.useStartTime,
      this.useEndTime,
      this.condition,
      this.money,
      this.canUse,
      this.couponType,
      this.outTime});

  CouponListItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id']!=null?json['id']:"";
    cid = json['cid']!=null?json['cid']:"";
    type = json['type']!=null?json['type']:"";
    uid = json['uid']!=null?json['uid']:"";
    orderId = json['order_id']!=null?json['order_id']:"";
    getOrderId = json['get_order_id']!=null?json['get_order_id']:"";
    useTime = json['use_time']!=null?json['use_time']:"";
    code = json['code']!=null?json['code']:"";
    sendTime = json['send_time']!=null?json['send_time']:"";
    status = json['status']!=null?json['status']:"";
    getTime = json['get_time']!=null?json['get_time']:"";
    couponPrice = json['coupon_price']!=null?json['coupon_price']:"";
    engineerId = json['engineer_id']!=null?json['engineer_id']:"";
    name = json['name']!=null?json['name']:"";
    useStartTime = json['use_start_time']!=null?json['use_start_time']:"";
    useEndTime = json['use_end_time']!=null?json['use_end_time']:"";
    condition = json['condition']!=null?json['condition']:"";
    money = json['money']!=null?json['money']:"";
    canUse = json['can_use']!=null?json['can_use']:"";
    couponType = json['coupon_type']!=null?json['coupon_type']:"";
    outTime = json['out_time']!=null?json['out_time']:"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cid'] = this.cid;
    data['type'] = this.type;
    data['uid'] = this.uid;
    data['order_id'] = this.orderId;
    data['get_order_id'] = this.getOrderId;
    data['use_time'] = this.useTime;
    data['code'] = this.code;
    data['send_time'] = this.sendTime;
    data['status'] = this.status;
    data['get_time'] = this.getTime;
    data['coupon_price'] = this.couponPrice;
    data['engineer_id'] = this.engineerId;
    data['name'] = this.name;
    data['use_start_time'] = this.useStartTime;
    data['use_end_time'] = this.useEndTime;
    data['condition'] = this.condition;
    data['money'] = this.money;
    data['can_use'] = this.canUse;
    data['coupon_type'] = this.couponType;
    data['out_time'] = this.outTime;
    return data;
  }
}

