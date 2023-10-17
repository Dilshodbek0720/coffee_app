import 'package:coffee_app/data/models/order/order_model.dart';

double choicePrice(int index){
  return index == 0 ? 1 : index == 1 ? index*(2.5) : index*5;
}

double totalPrice(List<OrderModel> orders){
  double sum = 0;
  for (OrderModel order in orders) {
    sum += (order.price*order.count*choicePrice(order.size));
  }
  return sum;
}