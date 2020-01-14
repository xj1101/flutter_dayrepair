class WxOrderListModel {
  List<WxOrderListItemModel> list;

  WxOrderListModel({this.list});

  WxOrderListModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<WxOrderListItemModel>();
      json['list'].forEach((v) {
        list.add(new WxOrderListItemModel.fromJson(v));
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

class WxOrderListItemModel {
  String addTime;
  String orderId;
  String userName;
  String mobile;
  String suppliersId;
  String engineerId;
  String suppliersName;
  String userAddress;
  String orderSn;
  String phoneCat;
  String phoneName;
  String colorName;
  String serverType;
  String statusName;
  String status;
  String payStatus;
  List<FaultModel> fault;
  String isExamine;
  String route;
  String distance;
  String isQuick;
  String totalPrice;
  String serverTime;
  String evaluate;
  String couponNum;
  EngineerInfoModel engineerInfo;
  String isAfterSale;
  String isCommitAfterSale;
  String isUploadVideo;
  String addTimeAfterSales;
  String finalStatus;
  Null finalStatusName;
  String goDoor;
  String bindCode;
  String commissionMoney;
  String cancelOrderTime;
  String orderNote;
  String suppliersAddressDetail;
  String suppliersPhone;
  String userAddressDetail;

  WxOrderListItemModel(
      {this.addTime,
      this.orderId,
      this.userName,
      this.mobile,
      this.suppliersId,
      this.engineerId,
      this.suppliersName,
      this.userAddress,
      this.orderSn,
      this.phoneCat,
      this.phoneName,
      this.colorName,
      this.serverType,
      this.statusName,
      this.status,
      this.payStatus,
      this.fault,
      this.isExamine,
      this.route,
      this.distance,
      this.isQuick,
      this.totalPrice,
      this.serverTime,
      this.evaluate,
      this.couponNum,
      this.engineerInfo,
      this.isAfterSale,
      this.isCommitAfterSale,
      this.isUploadVideo,
      this.addTimeAfterSales,
      this.finalStatus,
      this.finalStatusName,
      this.goDoor,
      this.bindCode,
      this.commissionMoney,
      this.cancelOrderTime,
      this.orderNote,
      this.suppliersAddressDetail,
      this.suppliersPhone,
      this.userAddressDetail});

  WxOrderListItemModel.fromJson(Map<String, dynamic> json) {
    addTime = json['add_time'];
    orderId = json['order_id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    suppliersId = json['suppliers_id'];
    engineerId = json['engineer_id'];
    suppliersName = json['suppliers_name'];
    userAddress = json['user_address'];
    orderSn = json['order_sn'];
    phoneCat = json['phone_cat'];
    phoneName = json['phone_name'];
    colorName = json['color_name'];
    serverType = json['server_type'];
    statusName = json['status_name'];
    status = json['status'];
    payStatus = json['pay_status'];
    if (json['fault'] != null) {
      fault = new List<FaultModel>();
      json['fault'].forEach((v) {
        fault.add(new FaultModel.fromJson(v));
      });
    }
    isExamine = json['is_examine'];
    route = json['route'];
    distance = json['distance'];
    isQuick = json['is_quick'];
    totalPrice = json['total_price'];
    serverTime = json['server_time'];
    evaluate = json['evaluate'];
    couponNum = json['coupon_num'];
    if (json['engineer_info'] != null) {
      if(json['engineer_info'] is List){

      }else{
        engineerInfo = EngineerInfoModel.fromJson(json['engineer_info']);
      }
    }
    isAfterSale = json['is_after_sale'];
    isCommitAfterSale = json['is_commit_after_sale'];
    isUploadVideo = json['is_upload_video'];
    addTimeAfterSales = json['add_time_after_sales'];
    finalStatus = json['final_status'];
    finalStatusName = json['final_status_name'];
    goDoor = json['go_door'];
    bindCode = json['bind_code'];
    commissionMoney = json['commission_money'];
    cancelOrderTime = json['cancel_order_time'];
    orderNote = json['order_note'];
    suppliersAddressDetail = json['suppliersAddressDetail'];
    suppliersPhone = json['suppliersPhone'];
    userAddressDetail = json['user_address_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['add_time'] = this.addTime;
    data['order_id'] = this.orderId;
    data['user_name'] = this.userName;
    data['mobile'] = this.mobile;
    data['suppliers_id'] = this.suppliersId;
    data['engineer_id'] = this.engineerId;
    data['suppliers_name'] = this.suppliersName;
    data['user_address'] = this.userAddress;
    data['order_sn'] = this.orderSn;
    data['phone_cat'] = this.phoneCat;
    data['phone_name'] = this.phoneName;
    data['color_name'] = this.colorName;
    data['server_type'] = this.serverType;
    data['status_name'] = this.statusName;
    data['status'] = this.status;
    data['pay_status'] = this.payStatus;
    if (this.fault != null) {
      data['fault'] = this.fault.map((v) => v.toJson()).toList();
    }
    data['is_examine'] = this.isExamine;
    data['route'] = this.route;
    data['distance'] = this.distance;
    data['is_quick'] = this.isQuick;
    data['total_price'] = this.totalPrice;
    data['server_time'] = this.serverTime;
    data['evaluate'] = this.evaluate;
    data['coupon_num'] = this.couponNum;
    if (this.engineerInfo != null) {
      if(data['engineer_info'] is List){

      }else{
        data['engineer_info'] = this.engineerInfo.toJson();
      }
    }
    data['is_after_sale'] = this.isAfterSale;
    data['is_commit_after_sale'] = this.isCommitAfterSale;
    data['is_upload_video'] = this.isUploadVideo;
    data['add_time_after_sales'] = this.addTimeAfterSales;
    data['final_status'] = this.finalStatus;
    data['final_status_name'] = this.finalStatusName;
    data['go_door'] = this.goDoor;
    data['bind_code'] = this.bindCode;
    data['commission_money'] = this.commissionMoney;
    data['cancel_order_time'] = this.cancelOrderTime;
    data['order_note'] = this.orderNote;
    data['suppliersAddressDetail'] = this.suppliersAddressDetail;
    data['suppliersPhone'] = this.suppliersPhone;
    data['user_address_detail'] = this.userAddressDetail;
    return data;
  }
}

class FaultModel {
  String planId;
  String price;
  String faultId;
  String faultName;
  String faultListId;

  FaultModel(
      {this.planId,
      this.price,
      this.faultId,
      this.faultName,
      this.faultListId});

  FaultModel.fromJson(Map<String, dynamic> json) {
    planId = json['plan_id'];
    price = json['price'];
    faultId = json['fault_id'];
    faultName = json['fault_name'];
    faultListId = json['fault_list_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan_id'] = this.planId;
    data['price'] = this.price;
    data['fault_id'] = this.faultId;
    data['fault_name'] = this.faultName;
    data['fault_list_id'] = this.faultListId;
    return data;
  }
}

class EngineerInfoModel {
  String username;
  String headPic;

  EngineerInfoModel({this.username, this.headPic});

  EngineerInfoModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    headPic = json['head_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['head_pic'] = this.headPic;
    return data;
  }
}

