class UserModel {
  String? id;
  String? name;
  String? image;
  String? email;

  UserModel({this.id, this.name, this.image, this.email});

  UserModel.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'image': image,
        'email': email,
      };
}
