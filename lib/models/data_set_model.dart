import 'package:cloud_firestore/cloud_firestore.dart';

class DataSetModel {
  String? dataSetId;
  String? name;
  String? image;


  DocumentReference<Map<String, dynamic>>? ref;

  DataSetModel(
      {required this.dataSetId,
        required this.name,
        required this.image,

      });

  DataSetModel.fromJson(Map<String, dynamic>? json,) {
    dataSetId = json!['plantId'];
    name = json['name'];
    image = json['image'];

  }

  Map<String, dynamic> toMap() => {
    'dataSetId': dataSetId,
    'name': name,
    'image': image,

  };
}
