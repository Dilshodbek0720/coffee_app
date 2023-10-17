part of 'user_bloc.dart';

class UsersState extends Equatable {
  final String statusText;
  final UserModel userModel;
  final FormStatus status;

  const UsersState({
    required this.statusText,
    required this.userModel,
    required this.status,
  });

  UsersState copyWith({
    String? statusText,
    UserModel? userModel,
    FormStatus? status,
  }) {
    return UsersState(
        statusText: statusText ?? this.statusText,
        userModel: userModel ?? this.userModel,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [statusText, status, userModel];
}