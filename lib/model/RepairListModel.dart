class RepairListModel {
  int status;
  String msg;
  List<RepairListItemModel> data;

  RepairListModel({this.status, this.msg, this.data});

  RepairListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<RepairListItemModel>();
      json['data'].forEach((v) {
        data.add(new RepairListItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RepairListItemModel {
  String suppliersId;
  String serverType;
  String lon;
  String lat;
  String suppliersName;
  String suppliersImg;
  String suppliersDesc;
  String suppliersContacts;
  String suppliersPhone;
  String provinceId;
  String cityId;
  String districtId;
  String address;
  int distance;
  String url;
  String suppliersPhoneName;

  RepairListItemModel(
      {this.suppliersId,
      this.serverType,
      this.lon,
      this.lat,
      this.suppliersName,
      this.suppliersImg,
      this.suppliersDesc,
      this.suppliersContacts,
      this.suppliersPhone,
      this.provinceId,
      this.cityId,
      this.districtId,
      this.address,
      this.distance,
      this.url,
      this.suppliersPhoneName});

  RepairListItemModel.fromJson(Map<String, dynamic> json) {
    suppliersId = json['suppliers_id'];
    serverType = json['server_type'];
    lon = json['lon'];
    lat = json['lat'];
    suppliersName = json['suppliers_name'];
    suppliersImg = json['suppliers_img'];
    suppliersDesc = json['suppliers_desc'];
    suppliersContacts = json['suppliers_contacts'];
    suppliersPhone = json['suppliers_phone'];
    provinceId = json['province_id'];
    cityId = json['city_id'];
    districtId = json['district_id'];
    address = json['address'];
    distance = json['distance'];
    url = json['url'];
    suppliersPhoneName = json['suppliers_phone_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['suppliers_id'] = this.suppliersId;
    data['server_type'] = this.serverType;
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    data['suppliers_name'] = this.suppliersName;
    data['suppliers_img'] = this.suppliersImg;
    data['suppliers_desc'] = this.suppliersDesc;
    data['suppliers_contacts'] = this.suppliersContacts;
    data['suppliers_phone'] = this.suppliersPhone;
    data['province_id'] = this.provinceId;
    data['city_id'] = this.cityId;
    data['district_id'] = this.districtId;
    data['address'] = this.address;
    data['distance'] = this.distance;
    data['url'] = this.url;
    data['suppliers_phone_name'] = this.suppliersPhoneName;
    return data;
  }
}

