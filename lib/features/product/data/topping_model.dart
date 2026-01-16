class ToppingModel {
  int id;
  String name;
  String img;

  ToppingModel({required this.id, required this.name, required this.img});

  factory ToppingModel.fromjson(Map<String, dynamic> json) {
    return ToppingModel(id: json['id'], name: json['name'], img: json['image']);
  }
}