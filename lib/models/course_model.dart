import 'package:bonecole/models/chapters_model.dart';

class CourseModel {
  String category;
  String chapterId;
  String duration;
  String lessonNumber;
  String title;
  String uid;
  String body;
  String lessonUrl;

  String section;

  CourseModel({
    required this.category,
    required this.chapterId,
    required this.duration,
    required this.lessonNumber,
    required this.title,
    required this.uid,
    required this.body,
    required this.lessonUrl,
    required this.section,
  });

  factory CourseModel.fromJson(json) => CourseModel(
        category: json["category"] ?? "",
        chapterId: json["chapterId"] ?? "",
        duration: json["duration"] ?? "",
        lessonNumber: json["lessonNumber"] ?? "",
        title: json["title"] ?? "",
        uid: json["uid"] ?? "",
        body: json["body"] ?? "",
        lessonUrl: json["lessonUrl"] ?? "",
        section: json["section"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "chapterId": chapterId,
        "duration": duration,
        "lessonNumber": lessonNumber,
        "title": title,
        "uid": uid,
        "body": body,
        "lessonUrl": lessonUrl,
        "section": section,
      };
}

class CurriculumResultModel {
  ChaptersModel chapter;
  List<CourseModel> courses;

  CurriculumResultModel({
    required this.chapter,
    required this.courses,
  });

  factory CurriculumResultModel.fromJson(json) => CurriculumResultModel(
        chapter: json["chapter"] ?? "",
        courses: json["courses"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "chapter": chapter,
        "courses": courses,
      };
}
