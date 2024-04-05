class FertilizerModel {
  String? id;
  String? name;
  String? image;
  String? price;
  String? type;
  String? description;

  FertilizerModel({this.id, this.name, this.image, this.type,this.price,this.description});

  FertilizerModel.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    type = json['type'];
    description = json['description'];
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'image': image,
    'price': price,
    'type': type,
    'description': description,
  };
}