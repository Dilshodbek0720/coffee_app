import 'package:coffee_app/data/models/coffee/coffee_model.dart';

List<CoffeeModel> searchByName(List<CoffeeModel> models, String query) {
  List<CoffeeModel> results = [];

  for (CoffeeModel model in models) {
    if (model.name.toLowerCase().contains(query.toLowerCase())) {
      results.add(model);
    }
  }
  return results;
}