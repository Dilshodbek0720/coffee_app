part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.phoneNumber = '',
    this.status = FormStatus.pure,
    this.statusMessage = "",
  });

  final String phoneNumber;
  final FormStatus status;
  final String statusMessage;

  AuthState copyWith({
    String? phoneNumber,
    String? statusMessage,
    FormStatus? status,
  }) =>
      AuthState(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        status: status ?? this.status,
        statusMessage: statusMessage ?? this.statusMessage,
      );

  @override
  String toString() {
    return '''
    UserAge:$phoneNumber
    Status:$status
    ''';
  }

  @override
  List<Object?> get props => [
    phoneNumber,
    status,
    statusMessage,
  ];
}