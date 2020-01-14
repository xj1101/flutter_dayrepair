class AddressListModel {
  List<AddressItemModel> list;

  AddressListModel({this.list});

  AddressListModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<AddressItemModel>();
      json['list'].forEach((v) {
        list.add(new AddressItemModel.fromJson(v));
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

class AddressItemModel {
  String mobile;
  String consignee;
  String isDefault;
  String provinceName;
  String provinceId;
  String cityName;
  String cityId;
  String areaName;
  String areaId;
  String addressId;
  String addressDetail;

  AddressItemModel(
      {this.mobile,
      this.consignee,
      this.isDefault,
      this.provinceName,
      this.provinceId,
      this.cityName,
      this.cityId,
      this.areaName,
      this.areaId,
      this.addressId,
      this.addressDetail});

  AddressItemModel.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    consignee = json['consignee'];
    isDefault = json['is_default'];
    provinceName = json['province_name']!=null?json['province_name']:"";
    provinceId = json['province_id'];
    cityName = json['city_name']!=null?json['city_name']:"";
    cityId = json['city_id'];
    areaName = json['area_name']!=null?json['area_name']:"";
    areaId = json['area_id'];
    addressId = json['address_id'];
    addressDetail = json['address_detail']!=null?json['address_detail']:"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['consignee'] = this.consignee;
    data['is_default'] = this.isDefault;
    data['province_name'] = this.provinceName;
    data['province_id'] = this.provinceId;
    data['city_name'] = this.cityName;
    data['city_id'] = this.cityId;
    data['area_name'] = this.areaName;
    data['area_id'] = this.areaId;
    data['address_id'] = this.addressId;
    data['address_detail'] = this.addressDetail;
    return data;
  }
}

