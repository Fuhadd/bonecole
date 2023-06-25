class AppUser {
  final String? id;
  final String userName;
  final String email;

  AppUser({
    this.id,
    required this.userName,
    required this.email,
  });

  static AppUser fromJson(json) => AppUser(
        id: json['id'],
        email: json['email'],
        userName: json['userName'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "email": email,
      };
}
