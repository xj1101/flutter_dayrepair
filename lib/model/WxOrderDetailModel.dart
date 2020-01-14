class WxOrderDetailModel {
  String orderId;
  String orderSn;
  String addTime;
  String statusName;
  String status;
  String payStatus;
  String serverType;
  UserAddress userAddress;
  String phoneCat;
  String phoneName;
  String colorName;
  List<Fault> fault;
  String mobile;
  String route;
  String predictPrice;
  StoreData storeData;
  String isExamine;
  String serverTime;
  String startServerTime;
  String endServerTime;
  String couponNum;
  String evaluate;
  EngineerInfo engineerInfo;
  String isWarranty;
  String isAfterSale;
  Null addTimeAfterSales;
  String preSalePhone;
  String customerServicePhone;
  String isCommitAfterSale;
  String afterOrderRemark;
  String orderNote;
  String engineerJudge;
  String afterSalesReason;
  String finalStatus;
  String finalStatusName;
  String goDoor;
  String afterSalesOrder;
  String bindCode;
  String startRepairTime;
  String confirmTime;
  String cancelOrderTime;
  String supOrderStatus;

  WxOrderDetailModel(
      {this.orderId,
      this.orderSn,
      this.addTime,
      this.statusName,
      this.status,
      this.payStatus,
      this.serverType,
      this.userAddress,
      this.phoneCat,
      this.phoneName,
      this.colorName,
      this.fault,
      this.mobile,
      this.route,
      this.predictPrice,
      this.storeData,
      this.isExamine,
      this.serverTime,
      this.startServerTime,
      this.endServerTime,
      this.couponNum,
      this.evaluate,
      this.engineerInfo,
      this.isWarranty,
      this.isAfterSale,
      this.addTimeAfterSales,
      this.preSalePhone,
      this.customerServicePhone,
      this.isCommitAfterSale,
      this.afterOrderRemark,
      this.orderNote,
      this.engineerJudge,
      this.afterSalesReason,
      this.finalStatus,
      this.finalStatusName,
      this.goDoor,
      this.afterSalesOrder,
      this.bindCode,
      this.startRepairTime,
      this.confirmTime,
      this.cancelOrderTime,
      this.supOrderStatus});

  WxOrderDetailModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderSn = json['order_sn'];
    addTime = json['add_time'];
    statusName = json['status_name'];
    status = json['status'];
    payStatus = json['pay_status'];
    serverType = json['server_type'];
    userAddress = json['user_address'] != null
        ? new UserAddress.fromJson(json['user_address'])
        : null;
    phoneCat = json['phone_cat'];
    phoneName = json['phone_name'];
    colorName = json['color_name'];
    if (json['fault'] != null) {
      fault = new List<Fault>();
      json['fault'].forEach((v) {
        fault.add(new Fault.fromJson(v));
      });
    }
    mobile = json['mobile'];
    route = json['route'];
    predictPrice = json['predict_price'];
    storeData = json['store_data'] != null
        ? new StoreData.fromJson(json['store_data'])
        : null;
    isExamine = json['is_examine'];
    serverTime = json['server_time'];
    startServerTime = json['start_server_time'];
    endServerTime = json['end_server_time'];
    couponNum = json['coupon_num'];
    evaluate = json['evaluate'];
    if (json['engineer_info'] != null) {
      if(json['engineer_info'] is List){

      }else{
        engineerInfo = EngineerInfo.fromJson(json['engineer_info']);
      }
    }
    isWarranty = json['is_warranty'];
    isAfterSale = json['is_after_sale'];
    addTimeAfterSales = json['add_time_after_sales'];
    preSalePhone = json['pre_sale_phone'];
    customerServicePhone = json['customer_service_phone'];
    isCommitAfterSale = json['is_commit_after_sale'];
    afterOrderRemark = json['after_order_remark'];
    orderNote = json['order_note'];
    engineerJudge = json['engineer_judge'];
    afterSalesReason = json['after_sales_reason'];
    finalStatus = json['final_status'];
    finalStatusName = json['final_status_name'];
    goDoor = json['go_door'];
    afterSalesOrder = json['after_sales_order'];
    bindCode = json['bind_code'];
    startRepairTime = json['start_repair_time'];
    confirmTime = json['confirm_time'];
    cancelOrderTime = json['cancel_order_time'];
    supOrderStatus = json['sup_order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_sn'] = this.orderSn;
    data['add_time'] = this.addTime;
    data['status_name'] = this.statusName;
    data['status'] = this.status;
    data['pay_status'] = this.payStatus;
    data['server_type'] = this.serverType;
    if (this.userAddress != null) {
      data['user_address'] = this.userAddress.toJson();
    }
    data['phone_cat'] = this.phoneCat;
    data['phone_name'] = this.phoneName;
    data['color_name'] = this.colorName;
    if (this.fault != null) {
      data['fault'] = this.fault.map((v) => v.toJson()).toList();
    }
    data['mobile'] = this.mobile;
    data['route'] = this.route;
    data['predict_price'] = this.predictPrice;
    if (this.storeData != null) {
      data['store_data'] = this.storeData.toJson();
    }
    data['is_examine'] = this.isExamine;
    data['server_time'] = this.serverTime;
    data['start_server_time'] = this.startServerTime;
    data['end_server_time'] = this.endServerTime;
    data['coupon_num'] = this.couponNum;
    data['evaluate'] = this.evaluate;
    if (this.engineerInfo != null) {
      if(data['engineer_info'] is List){

      }else{
        data['engineer_info'] = this.engineerInfo.toJson();
      }
    }
    data['is_warranty'] = this.isWarranty;
    data['is_after_sale'] = this.isAfterSale;
    data['add_time_after_sales'] = this.addTimeAfterSales;
    data['pre_sale_phone'] = this.preSalePhone;
    data['customer_service_phone'] = this.customerServicePhone;
    data['is_commit_after_sale'] = this.isCommitAfterSale;
    data['after_order_remark'] = this.afterOrderRemark;
    data['order_note'] = this.orderNote;
    data['engineer_judge'] = this.engineerJudge;
    data['after_sales_reason'] = this.afterSalesReason;
    data['final_status'] = this.finalStatus;
    data['final_status_name'] = this.finalStatusName;
    data['go_door'] = this.goDoor;
    data['after_sales_order'] = this.afterSalesOrder;
    data['bind_code'] = this.bindCode;
    data['start_repair_time'] = this.startRepairTime;
    data['confirm_time'] = this.confirmTime;
    data['cancel_order_time'] = this.cancelOrderTime;
    data['sup_order_status'] = this.supOrderStatus;
    return data;
  }
}

class UserAddress {
  String mobile;
  String consignee;
  String provinceName;
  String cityName;
  String areaName;
  String addressDetail;

  UserAddress(
      {this.mobile,
      this.consignee,
      this.provinceName,
      this.cityName,
      this.areaName,
      this.addressDetail});

  UserAddress.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    consignee = json['consignee'];
    provinceName = json['province_name']!= null?json['province_name']:"";
    cityName = json['city_name']!= null?json['city_name']:"";
    areaName = json['area_name']!= null?json['area_name']:"";
    addressDetail = json['address_detail']!= null?json['address_detail']:"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['consignee'] = this.consignee;
    data['province_name'] = this.provinceName;
    data['city_name'] = this.cityName;
    data['area_name'] = this.areaName;
    data['address_detail'] = this.addressDetail;
    return data;
  }
}

class Fault {
  String planId;
  String price;
  String faultId;
  String faultName;
  String faultListId;
  List<FaultData> faultData;

  Fault(
      {this.planId,
      this.price,
      this.faultId,
      this.faultName,
      this.faultListId,
      this.faultData});

  Fault.fromJson(Map<String, dynamic> json) {
    planId = json['plan_id'];
    price = json['price'];
    faultId = json['fault_id'];
    faultName = json['fault_name'];
    faultListId = json['fault_list_id'];
    if (json['fault_data'] != null) {
      faultData = new List<FaultData>();
      json['fault_data'].forEach((v) {
        faultData.add(new FaultData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan_id'] = this.planId;
    data['price'] = this.price;
    data['fault_id'] = this.faultId;
    data['fault_name'] = this.faultName;
    data['fault_list_id'] = this.faultListId;
    if (this.faultData != null) {
      data['fault_data'] = this.faultData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FaultData {
  String price;
  String id;
  String solutionName;
  String warranty;
  String commission;
  String remainingTime;

  FaultData(
      {this.price,
      this.id,
      this.solutionName,
      this.warranty,
      this.commission,
      this.remainingTime});

  FaultData.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    id = json['id'];
    solutionName = json['solution_name'];
    warranty = json['warranty'];
    commission = json['commission'];
    remainingTime = json['remaining_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['id'] = this.id;
    data['solution_name'] = this.solutionName;
    data['warranty'] = this.warranty;
    data['commission'] = this.commission;
    data['remaining_time'] = this.remainingTime;
    return data;
  }
}

class StoreData {
  String storeName;
  String mobile;
  String address;
  String suppliersId;
  String url;

  StoreData(
      {this.storeName, this.mobile, this.address, this.suppliersId, this.url});

  StoreData.fromJson(Map<String, dynamic> json) {
    storeName = json['store_name'];
    mobile = json['mobile'];
    address = json['address'];
    suppliersId = json['suppliers_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_name'] = this.storeName;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['suppliers_id'] = this.suppliersId;
    data['url'] = this.url;
    return data;
  }
}

class EngineerInfo {
  String username;
  String headPic;

  EngineerInfo({this.username, this.headPic});

  EngineerInfo.fromJson(Map<String, dynamic> json) {
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

