import 'package:cloud_firestore/cloud_firestore.dart';

class PlantModel {
  String? plantId;
  num? price;
  String? size;
  double? rating;
  String? humidity;
  String? temperature;
  String? category;
  String? name;
  String? image;
  bool isFavorated = false;
  String? decription;
  bool isCart = false ;
  DocumentReference<Map<String,dynamic>>? ref;



  PlantModel.fromJson(Map<String, dynamic>? json,
      {this.isFavorated = false, this.isCart = false}) {
    plantId = json!['plantId'];
    price = json['price'];
    category = json['category'];
    name = json['plantName'];
    size = json['size'];
    decription = json['decription'];
    humidity = json['humidity'];
    temperature = json['temperature'];
    image = json['imageURL'];
    ref = json['ref'];
  }

  Map<String, dynamic> toMap() => {
        'plantId': plantId,
        'plantName': name,
        'category': category,
        'price': price,
        'size': size,
        'decription': decription,
        'humidity': humidity,
        'temperature': temperature,
        'imageURL': image,
        'ref': ref,
      };
}
