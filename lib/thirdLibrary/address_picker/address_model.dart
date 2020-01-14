class AddressProvince {
  String provinceid;
  String province;
  List<AddressCity> cities;

  AddressProvince(
      {this.provinceid,
      this.province,
      this.cities});

  AddressProvince.fromJson(Map<String, dynamic> json, {Map<String, AddressCity> cityMap, Map<String, AddressDistrict> districtMap}) {
    provinceid = json['id'];
    province = json['name'];
    if (json['city'] != null) {
      cities = new List<AddressCity>();
      json['city'].forEach((v) {
        var city = AddressCity.fromJson(v, districtMap: districtMap);
        cityMap[city.cityid] = city;
        cities.add(city);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.provinceid;
    data['name'] = this.province;
    if (this.cities != null) {
      data['city'] = this.cities.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressCity {
  String city;
  String cityid;
  List<AddressDistrict> district;

  AddressCity(
      {this.city,
      this.cityid,
      this.district});

  AddressCity.fromJson(Map<String, dynamic> json, {Map<String, AddressDistrict> districtMap}) {
    city = json['name'];
    cityid = json['id'];
    if (json['area'] != null) {
      district = new List<AddressDistrict>();
      json['area'].forEach((v) {
        var dis = AddressDistrict.fromJson(v);
        districtMap[dis.areaid] = dis;
        district.add(dis);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.city;
    data['id'] = this.cityid;
    if (this.district != null) {
      data['area'] = this.district.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressDistrict {
  String area;
  String areaid;

  AddressDistrict({this.area, this.areaid});

  AddressDistrict.fromJson(Map<String, dynamic> json) {
    area = json['name'];
    areaid = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.area;
    data['id'] = this.areaid;
    return data;
  }
}