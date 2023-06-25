
class UserDataModel {
  UserDataModel({
    this.id = "",
    this.companyId = "",
    this.email = "",
    this.firstName = "",
    this.lastName = "",
    this.password = "",
    this.timeLog = const [],

    // this.userImages = const [],
  });

  String id;
  String companyId;
  String email;
  String firstName;
  String lastName;
  String password;
  List<String> timeLog;
  // List<TimeLog> timeLog;

  // List<UserImageResponseModel> userImages;

  factory UserDataModel.fromJson(json) => UserDataModel(
        id: json["id"] ?? "",
        companyId: json["companyId"] ?? "",
        email: json["email"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        // timeLog: (json["timeLog"] as List<String>?) ?? [],
        // timeLog: (json["timeLog"] as List<dynamic>?)
        //         ?.map((e) => TimeLog.fromJson(e))
        //         .toList() ??
        //     [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "companyId": companyId,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "timeLog": timeLog,
      };
}
