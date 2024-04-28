import 'package:bonecole/models/course_packs.dart';

import 'book_model.dart';

class CoursePackResultModel {
  List<BookModel> courses;
  List<CoursePackModel> coursePacks;

  CoursePackResultModel({
    required this.courses,
    required this.coursePacks,
  });

  factory CoursePackResultModel.fromJson(json) => CoursePackResultModel(
        courses: json["courses"] ?? "",
        coursePacks: json["coursePacks"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "courses": courses,
        "coursePacks": coursePacks,
      };
}
