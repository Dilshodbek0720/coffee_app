part of 'user_bloc.dart';

abstract class UserEvent {}

class GetUserEvent extends UserEvent {}

class AddUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {

}

class UpdateCurrentUserEvent extends UserEvent {
  final UserFieldKeys fieldKey;
  final dynamic value;
  UpdateCurrentUserEvent({required this.fieldKey, required this.value});
}

class DeleteUserEvent extends UserEvent {
  final String userId;
  DeleteUserEvent({required this.userId});
}