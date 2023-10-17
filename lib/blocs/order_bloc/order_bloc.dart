import 'dart:async';
import 'package:coffee_app/data/models/universal_data.dart';
import 'package:coffee_app/data/repositories/order_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/form/form_status.dart';
import '../../data/models/order/order_model.dart';
part 'order_state.dart';
part 'order_event.dart';

class OrderBloc extends Bloc<OrderEvent, OrderStates> {
  final OrderRepo orderRepo;

  OrderBloc({required this.orderRepo})
      : super(
          const OrderStates(
            orders: [],
            orderModel: OrderModel(
              image: '',
              description: '',
              name: '',
              orderId: '',
              price: 0,
              type: '',
              count: 0,
              size: 0,
              userId: '',
              clientName: '',
              clientNumber: '',
              region: '',
            ),
            status: FormStatus.pure,
          ),
        ) {
    on<AddOrderEvent>(addOrder);
    on<UpdateOrderEvent>(updateOrder);
    on<DeleteOrderEvent>(deleteOrder);
  }

  Future<void> addOrder(AddOrderEvent event, Emitter<OrderStates> emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    UniversalData data = await orderRepo.addOrder(orderModel: event.orderModel);
    if (data.error.isEmpty) {
      emit(state.copyWith(
        status: FormStatus.success,
      ));
    } else {
      emit(state.copyWith(
        status: FormStatus.failure,
      ));
    }
  }

  Future<void> updateOrder(
      UpdateOrderEvent event, Emitter<OrderStates> emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    UniversalData data =
        await orderRepo.updateOrder(orderModel: event.orderModel);
    if (data.error.isEmpty) {
      emit(state.copyWith(
        status: FormStatus.success,
      ));
    } else {
      emit(state.copyWith(
        status: FormStatus.failure,
      ));
    }
  }

  Future<void> deleteOrder(
      DeleteOrderEvent event, Emitter<OrderStates> emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    UniversalData data = await orderRepo.deleteOrder(orderId: event.orderId);
    if (data.error.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.success,
        ),
      );
    } else {
      emit(state.copyWith(
        status: FormStatus.failure,
      ));
    }
  }
}
