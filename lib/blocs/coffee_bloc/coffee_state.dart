part of 'coffee_bloc.dart';

class CoffeeStates extends Equatable {
  final List<CoffeeModel> coffees;
  final CoffeeModel coffeeModel;
  final FormStatus status;

  const CoffeeStates({
    required this.coffees,
    required this.coffeeModel,
    required this.status,
  });

  @override
  List<Object?> get props => [
    coffeeModel,
    status,
    coffees
  ];

  CoffeeStates copyWith({
    CoffeeModel? coffeeModel,
    FormStatus? status,
    List<CoffeeModel>? coffees,
  }) {
    return CoffeeStates(
      coffeeModel: coffeeModel ?? this.coffeeModel,
      status: status ?? this.status,
      coffees: coffees ?? this.coffees,
    );
  }
}