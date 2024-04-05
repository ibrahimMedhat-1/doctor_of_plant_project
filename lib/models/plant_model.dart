class PlantModel {
   int? plantId;
   int? price;
   String? size;
   double? rating;
   int? humidity;
   String? temperature;
   String? category;
   String? plantName;
   String? imageURL;
  bool? isFavorated;
   String? decription;
  bool? isSelected;

  PlantModel({required this.plantId,
    required this.price,
     this.category,
    required this.plantName,
    required this.size,
    required this.rating,
    required this.humidity,
    required this.temperature,
    required this.imageURL,
    required this.isFavorated,
    required this.decription,
    required this.isSelected});

   PlantModel.fromJson(Map<String, dynamic>? json) {
    plantId = json!['plantId'];
    price = json['price'];
    category = json['category'];
    plantName = json['plantName'];
    size = json['size'];
    decription = json['decription'];
    humidity = json['humidity'];
    temperature = json['temperature'];
    imageURL = json['imageURL'];

  }

  Map<String, dynamic> toMap() => {
    'plantId': plantId,
    'plantName': plantName,
    'category': category,
    'price': price,
    'size': size,
    'decription': decription,
    'humidity': humidity,
    'temperature': temperature,
    'imageURL': imageURL,
  };


}