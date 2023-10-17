import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/data/models/order/order_model.dart';
import 'package:coffee_app/data/models/universal_data.dart';
import 'package:coffee_app/utils/constants/constants.dart';

import '../../utils/constants/storage_keys.dart';
import '../local/storage_repository.dart';

class OrderRepo {
  final FirebaseFirestore base = FirebaseFirestore.instance;

  Future<UniversalData> addOrder({required OrderModel orderModel}) async {
    try {
      DocumentReference newOrder = await base
          .collection(FirebaseCollections.orders)
          .add(orderModel.toJson());
      await base
          .collection(FirebaseCollections.orders)
          .doc(newOrder.id)
          .update({
        "orderId": newOrder.id,
      });
      return UniversalData(data: "Order added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> updateOrder(
      {required OrderModel orderModel}) async {
    try {
      await base
          .collection(FirebaseCollections.orders)
          .doc(orderModel.orderId)
          .update(orderModel.toJson());

      return UniversalData(data: "Order updated!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> deleteOrder({required String orderId}) async {
    try {
      await base
          .collection(FirebaseCollections.orders)
          .doc(orderId)
          .delete();

      return UniversalData(data: "Order deleted!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Stream<List<OrderModel>> getOrders() => FirebaseFirestore.instance
      .collection(FirebaseCollections.orders)
      .snapshots()
      .map(
        (event1) => event1.docs
        .map((doc) => OrderModel.fromJson(doc.data()))
        .toList(),
  );

  Stream<List<OrderModel>> getUserOrders() => FirebaseFirestore.instance
      .collection(FirebaseCollections.orders)
  .where("userId",
  isEqualTo: StorageRepository.getString(StorageKeys.userId))
      .snapshots()
      .map(
        (event1) => event1.docs
        .map((doc) => OrderModel.fromJson(doc.data()))
        .toList(),
  );
}