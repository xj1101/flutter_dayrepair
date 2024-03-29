///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class GoodsCategory {
/*
{
  "id": "850",
  "name": "苹果",
  "img": "/public/upload/category/2018/07-05/6af01d69f3a57466ae20e6b3bd1bdbcb.png"
} 
*/

  String id;
  String name;
  String img;

  GoodsCategory({
    this.id,
    this.name,
    this.img,
  });
  GoodsCategory.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toString();
    name = json["name"]?.toString();
    img = json["img"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["img"] = img;
    return data;
  }
}

class Thems {
/*
{
  "url": "",
  "logo": "/public/upload/brand/2016/04-01/9515283.jpg",
  "id": "9",
  "name": "苹果/Apple"
} 
*/

  String url;
  String logo;
  String id;
  String name;

  Thems({
    this.url,
    this.logo,
    this.id,
    this.name,
  });
  Thems.fromJson(Map<String, dynamic> json) {
    url = json["url"]?.toString();
    logo = json["logo"]?.toString();
    id = json["id"]?.toString();
    name = json["name"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["url"] = url;
    data["logo"] = logo;
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class Banner {
/*
{
  "ad_code": "http://img.dangrixiu.cn/df8b293be004bcc24fed132a20a7196420190215101222.png",
  "ad_link": "#",
  "media_type": "0"
} 
*/

  String adCode;
  String adLink;
  String mediaType;

  Banner({
    this.adCode,
    this.adLink,
    this.mediaType,
  });
  Banner.fromJson(Map<String, dynamic> json) {
    adCode = json["ad_code"]?.toString();
    adLink = json["ad_link"]?.toString();
    mediaType = json["media_type"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["ad_code"] = adCode;
    data["ad_link"] = adLink;
    data["media_type"] = mediaType;
    return data;
  }
}

class HotGoods {
/*
{
  "goods_id": "672",
  "original_img": "http://img.dangrixiu.cn/92edd024b5522d9770fd7a60d9eaa94820190412170040.png",
  "goods_name": "测试测",
  "shop_price": "66.00",
  "parent_id_path": "0_3",
  "sales_sum": "0",
  "url": "",
  "url_type": "4",
  "url_name": "自营"
} 
*/

  String goodsId;
  String originalImg;
  String goodsName;
  String shopPrice;
  String parentIdPath;
  String salesSum;
  String url;
  String urlType;
  String urlName;

  HotGoods({
    this.goodsId,
    this.originalImg,
    this.goodsName,
    this.shopPrice,
    this.parentIdPath,
    this.salesSum,
    this.url,
    this.urlType,
    this.urlName,
  });
  HotGoods.fromJson(Map<String, dynamic> json) {
    goodsId = json["goods_id"]?.toString();
    originalImg = json["original_img"]?.toString();
    goodsName = json["goods_name"]?.toString();
    shopPrice = json["shop_price"]?.toString();
    parentIdPath = json["parent_id_path"]?.toString();
    salesSum = json["sales_sum"]?.toString();
    url = json["url"]?.toString();
    urlType = json["url_type"]?.toString();
    urlName = json["url_name"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["goods_id"] = goodsId;
    data["original_img"] = originalImg;
    data["goods_name"] = goodsName;
    data["shop_price"] = shopPrice;
    data["parent_id_path"] = parentIdPath;
    data["sales_sum"] = salesSum;
    data["url"] = url;
    data["url_type"] = urlType;
    data["url_name"] = urlName;
    return data;
  }
}

class TimeLimitGoods {
/*
{
  "goods_id": "672",
  "original_img": "http://img.dangrixiu.cn/92edd024b5522d9770fd7a60d9eaa94820190412170040.png",
  "goods_name": "测试测",
  "shop_price": "66.00",
  "parent_id_path": "0_3",
  "sales_sum": "0",
  "url": "",
  "url_type": "4",
  "url_name": "自营"
} 
*/

  String goodsId;
  String originalImg;
  String goodsName;
  String shopPrice;
  String parentIdPath;
  String salesSum;
  String url;
  String urlType;
  String urlName;

  TimeLimitGoods({
    this.goodsId,
    this.originalImg,
    this.goodsName,
    this.shopPrice,
    this.parentIdPath,
    this.salesSum,
    this.url,
    this.urlType,
    this.urlName,
  });
  TimeLimitGoods.fromJson(Map<String, dynamic> json) {
    goodsId = json["goods_id"]?.toString();
    originalImg = json["original_img"]?.toString();
    goodsName = json["goods_name"]?.toString();
    shopPrice = json["shop_price"]?.toString();
    parentIdPath = json["parent_id_path"]?.toString();
    salesSum = json["sales_sum"]?.toString();
    url = json["url"]?.toString();
    urlType = json["url_type"]?.toString();
    urlName = json["url_name"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["goods_id"] = goodsId;
    data["original_img"] = originalImg;
    data["goods_name"] = goodsName;
    data["shop_price"] = shopPrice;
    data["parent_id_path"] = parentIdPath;
    data["sales_sum"] = salesSum;
    data["url"] = url;
    data["url_type"] = urlType;
    data["url_name"] = urlName;
    return data;
  }
}

class FavouriteGoods {
/*
{
  "goods_id": "672",
  "original_img": "http://img.dangrixiu.cn/92edd024b5522d9770fd7a60d9eaa94820190412170040.png",
  "goods_name": "测试测",
  "shop_price": "66.00",
  "parent_id_path": "0_3",
  "sales_sum": "0",
  "url": "",
  "url_type": "4",
  "url_name": "自营"
} 
*/

  String goodsId;
  String originalImg;
  String goodsName;
  String shopPrice;
  String parentIdPath;
  String salesSum;
  String url;
  String urlType;
  String urlName;

  FavouriteGoods({
    this.goodsId,
    this.originalImg,
    this.goodsName,
    this.shopPrice,
    this.parentIdPath,
    this.salesSum,
    this.url,
    this.urlType,
    this.urlName,
  });
  FavouriteGoods.fromJson(Map<String, dynamic> json) {
    goodsId = json["goods_id"]?.toString();
    originalImg = json["original_img"]?.toString();
    goodsName = json["goods_name"]?.toString();
    shopPrice = json["shop_price"]?.toString();
    parentIdPath = json["parent_id_path"]?.toString();
    salesSum = json["sales_sum"]?.toString();
    url = json["url"]?.toString();
    urlType = json["url_type"]?.toString();
    urlName = json["url_name"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["goods_id"] = goodsId;
    data["original_img"] = originalImg;
    data["goods_name"] = goodsName;
    data["shop_price"] = shopPrice;
    data["parent_id_path"] = parentIdPath;
    data["sales_sum"] = salesSum;
    data["url"] = url;
    data["url_type"] = urlType;
    data["url_name"] = urlName;
    return data;
  }
}

class MallDataModel {
/*
{
  "favourite_goods": [
    {
      "goods_id": "672",
      "original_img": "http://img.dangrixiu.cn/92edd024b5522d9770fd7a60d9eaa94820190412170040.png",
      "goods_name": "测试测",
      "shop_price": "66.00",
      "parent_id_path": "0_3",
      "sales_sum": "0",
      "url": "",
      "url_type": "4",
      "url_name": "自营"
    }
  ],
  "time_limit_goods": [
    {
      "goods_id": "672",
      "original_img": "http://img.dangrixiu.cn/92edd024b5522d9770fd7a60d9eaa94820190412170040.png",
      "goods_name": "测试测",
      "shop_price": "66.00",
      "parent_id_path": "0_3",
      "sales_sum": "0",
      "url": "",
      "url_type": "4",
      "url_name": "自营"
    }
  ],
  "hot_goods": [
    {
      "goods_id": "672",
      "original_img": "http://img.dangrixiu.cn/92edd024b5522d9770fd7a60d9eaa94820190412170040.png",
      "goods_name": "测试测",
      "shop_price": "66.00",
      "parent_id_path": "0_3",
      "sales_sum": "0",
      "url": "",
      "url_type": "4",
      "url_name": "自营"
    }
  ],
  "cart_number": "2",
  "banner": [
    {
      "ad_code": "http://img.dangrixiu.cn/df8b293be004bcc24fed132a20a7196420190215101222.png",
      "ad_link": "#",
      "media_type": "0"
    }
  ],
  "thems": [
    {
      "url": "",
      "logo": "/public/upload/brand/2016/04-01/9515283.jpg",
      "id": "9",
      "name": "苹果/Apple"
    }
  ],
  "goods_category": [
    {
      "id": "850",
      "name": "苹果",
      "img": "/public/upload/category/2018/07-05/6af01d69f3a57466ae20e6b3bd1bdbcb.png"
    }
  ]
} 
*/
  //
  List<FavouriteGoods> favouriteGoods;
  //限时推荐模型数组
  List<TimeLimitGoods> timeLimitGoods;
  //热卖推荐模型数组
  List<HotGoods> hotGoods;
  String cartNumber;
  //广告模型数组
  List<Banner> banner;
  //sengMent标题模型数组
  List<Thems> thems;
  //商品分类类别模型数组
  List<GoodsCategory> goodsCategory;

  MallDataModel({
    this.favouriteGoods,
    this.timeLimitGoods,
    this.hotGoods,
    this.cartNumber,
    this.banner,
    this.thems,
    this.goodsCategory,
  });
  MallDataModel.fromJson(Map<String, dynamic> json) {
  if (json["favourite_goods"] != null) {
  var v = json["favourite_goods"];
  var arr0 = List<FavouriteGoods>();
  v.forEach((v) {
  arr0.add(FavouriteGoods.fromJson(v));
  });
    favouriteGoods = arr0;
    }
  if (json["time_limit_goods"] != null) {
  var v = json["time_limit_goods"];
  var arr0 = List<TimeLimitGoods>();
  v.forEach((v) {
  arr0.add(TimeLimitGoods.fromJson(v));
  });
    timeLimitGoods = arr0;
    }
  if (json["hot_goods"] != null) {
  var v = json["hot_goods"];
  var arr0 = List<HotGoods>();
  v.forEach((v) {
  arr0.add(HotGoods.fromJson(v));
  });
    hotGoods = arr0;
    }
    cartNumber = json["cart_number"]?.toString();
  if (json["banner"] != null) {
  var v = json["banner"];
  var arr0 = List<Banner>();
  v.forEach((v) {
  arr0.add(Banner.fromJson(v));
  });
    banner = arr0;
    }
  if (json["thems"] != null) {
  var v = json["thems"];
  var arr0 = List<Thems>();
  v.forEach((v) {
  arr0.add(Thems.fromJson(v));
  });
    thems = arr0;
    }
  if (json["goods_category"] != null) {
  var v = json["goods_category"];
  var arr0 = List<GoodsCategory>();
  v.forEach((v) {
  arr0.add(GoodsCategory.fromJson(v));
  });
    goodsCategory = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (favouriteGoods != null) {
      var v = favouriteGoods;
      var arr0 = List();
  v.forEach((v) {
  arr0.add(v.toJson());
  });
      data["favourite_goods"] = arr0;
    }
    if (timeLimitGoods != null) {
      var v = timeLimitGoods;
      var arr0 = List();
  v.forEach((v) {
  arr0.add(v.toJson());
  });
      data["time_limit_goods"] = arr0;
    }
    if (hotGoods != null) {
      var v = hotGoods;
      var arr0 = List();
  v.forEach((v) {
  arr0.add(v.toJson());
  });
      data["hot_goods"] = arr0;
    }
    data["cart_number"] = cartNumber;
    if (banner != null) {
      var v = banner;
      var arr0 = List();
  v.forEach((v) {
  arr0.add(v.toJson());
  });
      data["banner"] = arr0;
    }
    if (thems != null) {
      var v = thems;
      var arr0 = List();
  v.forEach((v) {
  arr0.add(v.toJson());
  });
      data["thems"] = arr0;
    }
    if (goodsCategory != null) {
      var v = goodsCategory;
      var arr0 = List();
  v.forEach((v) {
  arr0.add(v.toJson());
  });
      data["goods_category"] = arr0;
    }
    return data;
  }
}

class MallModel {
/*
{
  "status": 1,
  "msg": "成功",
  "data": {
    "favourite_goods": [
      {
        "goods_id": "672",
        "original_img": "http://img.dangrixiu.cn/92edd024b5522d9770fd7a60d9eaa94820190412170040.png",
        "goods_name": "测试测",
        "shop_price": "66.00",
        "parent_id_path": "0_3",
        "sales_sum": "0",
        "url": "",
        "url_type": "4",
        "url_name": "自营"
      }
    ],
    "time_limit_goods": [
      {
        "goods_id": "672",
        "original_img": "http://img.dangrixiu.cn/92edd024b5522d9770fd7a60d9eaa94820190412170040.png",
        "goods_name": "测试测",
        "shop_price": "66.00",
        "parent_id_path": "0_3",
        "sales_sum": "0",
        "url": "",
        "url_type": "4",
        "url_name": "自营"
      }
    ],
    "hot_goods": [
      {
        "goods_id": "672",
        "original_img": "http://img.dangrixiu.cn/92edd024b5522d9770fd7a60d9eaa94820190412170040.png",
        "goods_name": "测试测",
        "shop_price": "66.00",
        "parent_id_path": "0_3",
        "sales_sum": "0",
        "url": "",
        "url_type": "4",
        "url_name": "自营"
      }
    ],
    "cart_number": "2",
    "banner": [
      {
        "ad_code": "http://img.dangrixiu.cn/df8b293be004bcc24fed132a20a7196420190215101222.png",
        "ad_link": "#",
        "media_type": "0"
      }
    ],
    "thems": [
      {
        "url": "",
        "logo": "/public/upload/brand/2016/04-01/9515283.jpg",
        "id": "9",
        "name": "苹果/Apple"
      }
    ],
    "goods_category": [
      {
        "id": "850",
        "name": "苹果",
        "img": "/public/upload/category/2018/07-05/6af01d69f3a57466ae20e6b3bd1bdbcb.png"
      }
    ]
  }
} 
*/

  int status;
  String msg;
  MallDataModel data;

  MallModel({
    this.status,
    this.msg,
    this.data,
  });
  MallModel.fromJson(Map<String, dynamic> json) {
    status = json["status"]?.toInt();
    msg = json["msg"]?.toString();
    data = json["data"] != null ? MallDataModel.fromJson(json["data"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = status;
    data["msg"] = msg;
    if (data != null) {
      data["data"] = this.data.toJson();
    }
    return data;
  }
}

