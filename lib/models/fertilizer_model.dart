import 'package:cloud_firestore/cloud_firestore.dart';

class FertilizerModel {
  String? id;
  String? name;
  String? image;
  num? price;
  String? type;
  String? description;
  bool isFavorated = false;
  bool isCart = false ;
  DocumentReference<Map<String,dynamic>>? ref;

  FertilizerModel({this.id, this.name, this.image, this.type,this.price,this.description,this.ref});

  FertilizerModel.fromJson(Map<String, dynamic>? json ,{this.isFavorated = false, this.isCart = false}) {
    id = json!['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    type = json['type'];
    description = json['description'];
    ref = json['ref'];
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'image': image,
    'price': price,
    'type': type,
    'description': description,
    'ref': ref,
  };
}