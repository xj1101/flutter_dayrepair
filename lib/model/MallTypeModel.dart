class MallTypeModel {
  int status;
  String msg;
  List<MallTypeItemModel> data;

  MallTypeModel({this.status, this.msg, this.data});

  MallTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<MallTypeItemModel>();
      json['data'].forEach((v) {
        data.add(new MallTypeItemModel.fromJson(v));
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

class MallTypeItemModel {
  String goodsId;
  String originalImg;
  String goodsName;
  Object shopPrice;
  String parentIdPath;
  String salesSum;
  String url;
  String urlType;
  String urlName;

  MallTypeItemModel(
      {this.goodsId,
      this.originalImg,
      this.goodsName,
      this.shopPrice,
      this.parentIdPath,
      this.salesSum,
      this.url,
      this.urlType,
      this.urlName});

  MallTypeItemModel.fromJson(Map<String, dynamic> json) {
    goodsId = json['goods_id'];
    originalImg = json['original_img'];
    goodsName = json['goods_name'];
    shopPrice = json['shop_price'];
    parentIdPath = json['parent_id_path'];
    salesSum = json['sales_sum'];
    url = json['url'];
    urlType = json['url_type'];
    urlName = json['url_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goods_id'] = this.goodsId;
    data['original_img'] = this.originalImg;
    data['goods_name'] = this.goodsName;
    data['shop_price'] = this.shopPrice;
    data['parent_id_path'] = this.parentIdPath;
    data['sales_sum'] = this.salesSum;
    data['url'] = this.url;
    data['url_type'] = this.urlType;
    data['url_name'] = this.urlName;
    return data;
  }
}

