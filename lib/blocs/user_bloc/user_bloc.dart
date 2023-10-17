import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/local/storage_repository.dart';
import '../../data/models/form/form_status.dart';
import '../../data/models/user/user_fieldkey.dart';
import '../../data/models/user/user_model.dart';
import '../../data/repositories/user_repo.dart';
import '../../utils/constants/constants.dart';
import '../../utils/constants/storage_keys.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UsersState> {
  final UserRepo userRepo;

  UserBloc({required this.userRepo})
      : super(UsersState(
          statusText: '',
          userModel: UserModel(
            userId: '',
            role: '',
          ),
          status: FormStatus.pure,
        )) {
    on<UserEvent>((event, emit) {});
    on<AddUserEvent>(addUser);
  }

  Future<void> addUser(
      AddUserEvent addUserEvent, Emitter<UsersState> emit) async {
    emit(state.copyWith(statusText: "Loading", status: FormStatus.loading));
    await userRepo.addUser(userModel: state.userModel);
    debugPrint('added');
    emit(state.copyWith(
        status: FormStatus.success, statusText: "User added successful"));
  }

  Future<void> getUserByDocId() async {
    final userId = StorageRepository.getString(StorageKeys.userId);
    final docRef = FirebaseFirestore.instance
        .collection(FirebaseCollections
            .users) // Assuming the collection name is "users" for clients
        .doc(userId);

    final data = await docRef.get();

    if (data.exists) {
      final userModel = UserModel.fromJson(data.data() as Map<String, dynamic>);
      // ignore: invalid_use_of_visible_for_testing_member
      emit(state.copyWith(userModel: userModel));
      StorageRepository.putString(StorageKeys.userRole, AppConstants.client);
    } else {
      debugPrint(
          "Documnet does not exist ---------------------------------------------------------------------");
    }
  }

  clearUserModelState() {
    // ignore: invalid_use_of_visible_for_testing_member
    emit(state.copyWith(
      userModel: UserModel(userId: '', role: ''),
    ));
  }

  updateCurrentUserField(
      UpdateCurrentUserEvent updateCurrentUserEvent, Emitter<UsersState> emit) {
    UserModel currentUser = state.userModel;

    switch (updateCurrentUserEvent.fieldKey) {
      case UserFieldKeys.userId:
        {
          currentUser = currentUser.copyWith(
              userId: updateCurrentUserEvent.value as String);
          break;
        }
      case UserFieldKeys.role:
        {
          currentUser = currentUser.copyWith(
              role: updateCurrentUserEvent.value as String);
          break;
        }
    }
    print(currentUser.toString());
  }
}
