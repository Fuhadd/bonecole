class ChaptersModel {
  String category;
  String chapterNumber;
  String sectionId;
  String subject;
  String title;
  String uid;
  String body;

  ChaptersModel({
    required this.category,
    required this.chapterNumber,
    required this.sectionId,
    required this.subject,
    required this.title,
    required this.uid,
    required this.body,
  });

  factory ChaptersModel.fromJson(json) => ChaptersModel(
        category: json["category"] ?? "",
        chapterNumber: json["chapterNumber"] ?? "",
        sectionId: json["sectionId"] ?? "",
        subject: json["subject"] ?? "",
        title: json["title"] ?? "",
        uid: json["uid"] ?? "",
        body: json["body"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "chapterNumber": chapterNumber,
        "sectionId": sectionId,
        "subject": subject,
        "title": title,
        "uid": uid,
        "body": body,
      };
}
