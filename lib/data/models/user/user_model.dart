class UserModel {
  final String userId;
  final String role;

  UserModel({
    required this.userId,
    required this.role,
  });

  UserModel copyWith({
    String? userId,
    String? role,
  }) =>
      UserModel(
        userId: userId ?? this.userId,
        role: role ?? this.role,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json['user_id'] as String? ?? '',
    role: json['role'] as String? ?? '',
  );

  @override
  String toString() => '''
    userId: $userId,
    role: $role,
  ''';

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'role': role,
  };
}