part of 'order_bloc.dart';

class OrderStates extends Equatable {
  final List<OrderModel> orders;
  final OrderModel orderModel;
  final FormStatus status;

  const OrderStates({
    required this.orders,
    required this.orderModel,
    required this.status,
  });

  @override
  List<Object?> get props => [
    orderModel,
    status,
    orders
  ];

  OrderStates copyWith({
    OrderModel? orderModel,
    FormStatus? status,
    List<OrderModel>? orders,
  }) {
    return OrderStates(
      orderModel: orderModel ?? this.orderModel,
      status: status ?? this.status,
      orders: orders ?? this.orders,
    );
  }
}