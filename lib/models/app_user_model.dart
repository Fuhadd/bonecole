class AppUser {
  final String? id;
  final String imageUrl;
  final String email;
  final String password;
  final String fullName;
  final String telephone;
  final String classOption;
  final String facebook;
  final String affiliate;
  final String schoolOrigin;
  final String pvExamen;

  AppUser({
    this.id,
    this.email = "",
    this.password = "",
    this.fullName = "",
    this.telephone = "",
    this.classOption = "",
    this.facebook = "",
    this.affiliate = "",
    this.schoolOrigin = "",
    this.pvExamen = "",
    this.imageUrl = "",
  });

  static AppUser fromJson(json) => AppUser(
        id: json['id'] ?? "",
        email: json['email'] ?? "",
        password: json['password'] ?? "",
        fullName: json['fullName'] ?? "",
        telephone: json['telephone'] ?? "",
        classOption: json['classOption'] ?? "",
        facebook: json['facebook'] ?? "",
        affiliate: json['affiliate'] ?? "",
        schoolOrigin: json['schoolOrigin'] ?? "",
        pvExamen: json['pvExamen'] ?? "",
        imageUrl: json['imageUrl'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "fullName": fullName,
        "telephone": telephone,
        "classOption": classOption,
        "facebook": facebook,
        "affiliate": affiliate,
        "schoolOrigin": schoolOrigin,
        "pvExamen": pvExamen,
        "imageUrl": imageUrl,
      };
}
