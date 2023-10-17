import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/data/models/coffee/coffee_model.dart';
import 'package:coffee_app/data/models/universal_data.dart';
import 'package:coffee_app/utils/constants/constants.dart';

class CoffeeRepo {
  final FirebaseFirestore base = FirebaseFirestore.instance;

  Future<UniversalData> addCoffee({required CoffeeModel coffeeModel}) async {
    try {
      DocumentReference newCoffee = await base
          .collection(FirebaseCollections.coffees)
          .add(coffeeModel.toJson());
      await base
          .collection(FirebaseCollections.coffees)
          .doc(newCoffee.id)
          .update({
        "coffeeId": newCoffee.id,
      });
      return UniversalData(data: "Coffee added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> updateCoffee(
      {required CoffeeModel coffeeModel}) async {
    try {
      await base
          .collection(FirebaseCollections.coffees)
          .doc(coffeeModel.coffeeId)
          .update(coffeeModel.toJson());

      return UniversalData(data: "Coffee updated!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> deleteCoffee({required String coffeeId}) async {
    try {
      await base
          .collection(FirebaseCollections.coffees)
          .doc(coffeeId)
          .delete();

      return UniversalData(data: "Coffee deleted!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Stream<List<CoffeeModel>> getCoffees() => FirebaseFirestore.instance
      .collection(FirebaseCollections.coffees)
      // .where("user_id",
      // isEqualTo: StorageRepository.getString(StorageKeys.userId))
      .snapshots()
      .map(
        (event1) => event1.docs
        .map((doc) => CoffeeModel.fromJson(doc.data()))
        .toList(),
  );

  Stream<List<CoffeeModel>> getQueryCoffees() => FirebaseFirestore.instance
      .collection(FirebaseCollections.coffees)
  // .where("user_id",
  // isEqualTo: StorageRepository.getString(StorageKeys.userId))
      .snapshots()
      .map(
        (event1) => event1.docs
        .map((doc) => CoffeeModel.fromJson(doc.data()))
        .toList(),
  );
}