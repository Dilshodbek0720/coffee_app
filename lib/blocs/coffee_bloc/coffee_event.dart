part of 'coffee_bloc.dart';

@immutable
abstract class CoffeeEvent {}

class GetCoffeeEvent extends CoffeeEvent {}

class AddCoffeeEvent extends CoffeeEvent {
  final CoffeeModel coffeeModel;

  AddCoffeeEvent({required this.coffeeModel});
}

class UpdateCoffeeEvent extends CoffeeEvent {
  final CoffeeModel coffeeModel;

  UpdateCoffeeEvent({required this.coffeeModel});
}

class DeleteCoffeeEvent extends CoffeeEvent {
  final String coffeeId;

  DeleteCoffeeEvent({required this.coffeeId});
}
class GetCoffeeByIdEvent extends CoffeeEvent {
  final String coffeeId;

  GetCoffeeByIdEvent({required this.coffeeId});
}