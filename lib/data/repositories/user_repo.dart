import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utils/constants/constants.dart';
import '../../utils/constants/storage_keys.dart';
import '../local/storage_repository.dart';
import '../models/universal_data.dart';
import '../models/user/user_model.dart';

class UserRepo {
  Future<UniversalData> addUser({required UserModel userModel}) async {
    print("Kirdi");
    try {
      print("Success");
      await FirebaseFirestore.instance
          .collection(FirebaseCollections.users)
          .doc(userModel.userId)
          .set(userModel.toJson());

      return UniversalData(data: 'User Added!');
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> updateUser({required UserModel userModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollections.users)
          .doc(userModel.userId)
          .update(userModel.toJson());

      return UniversalData(data: "User updated!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> deleteUser({required String userId}) async {
    try {
      await FirebaseFirestore.instance.collection(FirebaseCollections.users).doc(userId).delete();

      return UniversalData(data: "User deleted!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Stream<UserModel?> getUserById() {
    return FirebaseFirestore.instance
        .collection(FirebaseCollections.users)
        .doc(
        StorageRepository.getString(StorageKeys.userId)) // Assuming driverId is the document ID
        .snapshots()
        .map((documentSnapshot) {
      if (documentSnapshot.exists) {
        return UserModel.fromJson(documentSnapshot.data() ?? {});
      } else {
        return null; // Return null if the document doesn't exist
      }
    });
  }
}