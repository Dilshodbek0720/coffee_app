import 'dart:async';
import 'package:coffee_app/data/models/universal_data.dart';
import 'package:coffee_app/data/repositories/coffee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../data/models/coffee/coffee_model.dart';
import '../../data/models/form/form_status.dart';
part 'coffee_event.dart';
part 'coffee_state.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeStates> {
  final CoffeeRepo coffeeRepo;

  CoffeeBloc({required this.coffeeRepo})
      : super(
    const CoffeeStates(
      coffees: [],
      coffeeModel: CoffeeModel(
        image: '',
        description: '',
        name: '',
        coffeeId: '',
        price: 0,
        type: ''
      ),
      status: FormStatus.pure,
    ),
  ) {
    on<AddCoffeeEvent>(addCoffee);
    on<UpdateCoffeeEvent>(updateCoffee);
    on<DeleteCoffeeEvent>(deleteCoffee);
  }

  Future<void> addCoffee(
      AddCoffeeEvent event, Emitter<CoffeeStates> emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    UniversalData data =
    await coffeeRepo.addCoffee(coffeeModel: event.coffeeModel);
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

  Future<void> updateCoffee(
      UpdateCoffeeEvent event, Emitter<CoffeeStates> emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    UniversalData data =
    await coffeeRepo.updateCoffee(coffeeModel: event.coffeeModel);
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

  Future<void> deleteCoffee(
      DeleteCoffeeEvent event, Emitter<CoffeeStates> emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    UniversalData data =
    await coffeeRepo.deleteCoffee(coffeeId: event.coffeeId);
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