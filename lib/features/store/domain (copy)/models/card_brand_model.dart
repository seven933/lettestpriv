class CardBrandModel {

  String code;
  String name;
  String image;

  CardBrandModel(this.code, this.name, this.image);

  CardBrandModel.fromJson(Map<String, dynamic> json) :
    code = json['code'].toString(),
    name = json['name'].toString(),
    image = json['image'].toString();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
