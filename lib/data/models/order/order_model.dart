import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final String userId;
  final String orderId;
  final String name;
  final String type;
  final String description;
  final int price;
  final String image;
  final int size;
  final int count;
  final String clientName;
  final String clientNumber;
  final String region;

  const OrderModel(
      {required this.orderId,
      required this.userId,
      required this.name,
      required this.type,
      required this.description,
      required this.price,
      required this.image,
      required this.size,
      required this.count,
      required this.clientName,
        required this.clientNumber,
        required this.region
      });

  const OrderModel.initial()
      : this(
          orderId: '',
          userId: '',
          name: '',
          type: '',
          description: '',
          price: 0,
          image: '',
          size: 0,
          count: 0,
          clientName: '',
          clientNumber: '',
          region: '',
        );

  OrderModel copyWith({
    String? orderId,
    String? userId,
    String? name,
    String? type,
    String? description,
    int? price,
    String? image,
    int? size,
    int? count,
    String? clientName,
    String? clientNumber,
    String? region,
  }) =>
      OrderModel(
        orderId: orderId ?? this.orderId,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        type: type ?? this.type,
        description: description ?? this.description,
        price: price ?? this.price,
        image: image ?? this.image,
        size: size ?? this.size,
        count: count ?? this.count,
        clientName: clientName ?? this.clientName,
        clientNumber: clientNumber ?? this.clientNumber,
        region: region ?? this.region,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderId: json['orderId'] as String? ?? '',
        userId: json['userId'] as String? ?? '',
        name: json['name'] as String? ?? '',
        type: json['type'] as String? ?? '',
        description: json['description'] as String? ?? '',
        price: json['price'] as int? ?? 0,
        image: json['image'] as String? ?? '',
        size: json['size'] as int? ?? 0,
        count: json['count'] as int? ?? 0,
    clientName: json['clientName'] as String? ?? '',
    clientNumber: json['clientNumber'] as String? ?? '',
    region: json['region'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'userId': userId,
        'name': name,
        'type': type,
        'description': description,
        'price': price,
        'image': image,
        'size': size,
        'count': count,
        'clientName': clientName,
        'clientNumber': clientNumber,
        'region': region
      };

  @override
  String toString() {
    return '''
    orderId: $orderId
    userId: $userId
    name: $name
    type: $type
    description: $description
    price: $price
    image: $image
    size: $size
    count: $count
    clientName: $clientName
    clientNumber: $clientNumber
    region: $region
        ''';
  }

  @override
  List<Object?> get props => [
        orderId,
        userId,
        name,
        type,
        description,
        price,
        image,
        size,
        count,
        clientName,
        clientNumber,
        region
      ];
}
