class WxOrderTypeModel {
/*
{
  "type_name": 上门服务,
  "type_id": "1",
  "isSelected":false
} 
*/

  String typeName;
  String typeId;
  bool isSelected;

  WxOrderTypeModel({
    this.typeName,
    this.typeId,
    this.isSelected,
  });
  WxOrderTypeModel.fromJson(Map<String, dynamic> json) {
    typeName = json["type_name"]?.toString();
    typeId = json["type_id"]?.toString();
    isSelected = json["isSelected"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["type_name"] = typeName;
    data["type_id"] = typeId;
    data["isSelected"] = isSelected;
    return data;
  }
}