part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class GetOrderEvent extends OrderEvent {}

class AddOrderEvent extends OrderEvent {
  final OrderModel orderModel;

  AddOrderEvent({required this.orderModel});
}

class UpdateOrderEvent extends OrderEvent {
  final OrderModel orderModel;

  UpdateOrderEvent({required this.orderModel});
}

class DeleteOrderEvent extends OrderEvent {
  final String orderId;

  DeleteOrderEvent({required this.orderId});
}
class GetOrderByIdEvent extends OrderEvent {
  final String orderId;

  GetOrderByIdEvent({required this.orderId});
}