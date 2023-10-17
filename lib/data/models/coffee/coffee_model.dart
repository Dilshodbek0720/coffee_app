import 'package:equatable/equatable.dart';

class CoffeeModel extends Equatable {
  final String coffeeId;
  final String name;
  final String type;
  final String description;
  final int price;
  final String image;

  const CoffeeModel({
    required this.coffeeId,
    required this.name,
    required this.type,
    required this.description,
    required this.price,
    required this.image,
  });

  const CoffeeModel.initial()
      : this(
          coffeeId: '',
          name: '',
          type: '',
          description: '',
          price: 0,
          image: '',
        );

  CoffeeModel copyWith({
    String? coffeeId,
    String? name,
    String? type,
    String? description,
    int? price,
    String? image,
  }) =>
      CoffeeModel(
        coffeeId: coffeeId ?? this.coffeeId,
        name: name ?? this.name,
        type: type ?? this.type,
        description: description ?? this.description,
        price: price ?? this.price,
        image: image ?? this.image,
      );

  factory CoffeeModel.fromJson(Map<String, dynamic> json) => CoffeeModel(
        coffeeId: json['coffeeId'] as String? ?? '',
        name: json['name'] as String? ?? '',
        type: json['type'] as String? ?? '',
        description: json['description'] as String? ?? '',
        price: json['price'] as int? ?? 0,
        image: json['image'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'coffeeId': coffeeId,
        'name': name,
        'type': type,
        'description': description,
        'price': price,
        'image': image
      };

  @override
  String toString() {
    return '''
    coffeeId: $coffeeId,
 name: $name
 type: $type
 description: $description
 price: $price
 image: $image
    ''';
  }

  @override
  List<Object?> get props => [
        coffeeId,
        name,
        type,
        description,
        price,
        image,
      ];
}
