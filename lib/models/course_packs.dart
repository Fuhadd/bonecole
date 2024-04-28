class CoursePackModel {
  String category;
  String categoryId;
  String body;
  String instructor;
  String price;
  String subLevel;
  List<String> subjectsInPack;
  String title;
  String uid;

  CoursePackModel({
    required this.category,
    required this.categoryId,
    required this.body,
    required this.instructor,
    required this.price,
    required this.subLevel,
    required this.subjectsInPack,
    required this.title,
    required this.uid,
  });
  factory CoursePackModel.fromJson(json) => CoursePackModel(
        category: json["category"] ?? "",
        categoryId: json["categoryId"] ?? "",
        instructor: json["instructor"] ?? "",
        price: json["price"] ?? "",
        body: json["body"] ?? "",
        subLevel: json["subLevel"] ?? "",
        uid: json["uid"] ?? "",
        title: json["title"] ?? "",
        // subjectsInPack: json["subjectsInPack"] ?? [],

        subjectsInPack: (json["subjectsInPack"] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "categoryId": categoryId,
        "instructor": instructor,
        "price": price,
        "body": body,
        "subLevel": subLevel,
        "uid": uid,
        "title": title,
        "subjectsInPack": subjectsInPack,
      };
}
