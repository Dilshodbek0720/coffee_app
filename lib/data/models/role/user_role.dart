class UserRole {
  final String admin;
  final String client;

  UserRole({
    required this.admin,
    required this.client,
  });

  UserRole copyWith({
    String? admin,
    String? client,
  }) =>
      UserRole(
        admin: admin ?? this.admin,
        client: client ?? this.client,
      );

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
    admin: json['admin'] as String? ?? '',
    client: json['client'] as String? ?? '',
  );

  @override
  String toString() => '''
    admin: $admin,
    client: $client,

  ''';

  Map<String, dynamic> toJson() => {
    'admin': admin,
    'client': client,
  };
}