class TeacherModel {
  String? body;
  String firstName;
  String imageUrl;
  String lastName;
  String level;
  // String registeredOn;
  String subject;
  String uid;
  String? bio;

  TeacherModel({
    this.body,
    this.bio,
    required this.firstName,
    required this.imageUrl,
    required this.lastName,
    required this.level,
    // required this.registeredOn,
    required this.subject,
    required this.uid,
  });

  factory TeacherModel.fromJson(json) => TeacherModel(
        body: json["body"] ?? "",
        bio: json["bio"] ?? "",
        firstName: json["firstName"] ?? "",
        imageUrl: json["imageUrl"] ?? "",
        lastName: json["lastName"] ?? "",
        level: json["level"] ?? "",
        // registeredOn: json["registeredOn"] ?? "",
        subject: json["subject"] ?? "",
        uid: json["uid"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "bio": bio,

        "firstName": firstName,
        "imageUrl": imageUrl,
        "lastName": lastName,
        "level": level,
        // "registeredOn": registeredOn,
        "subject": subject,
        "uid": uid,
      };
}
