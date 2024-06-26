class BookModel {
  String category;
  String categoryId;
  String instructor;
  String subLevel;
  String title;
  String uid;
  String body;
  String price;
  String subjectImageUrl;

  BookModel({
    required this.category,
    required this.categoryId,
    required this.instructor,
    required this.subLevel,
    required this.title,
    required this.uid,
    required this.body,
    required this.price,
    required this.subjectImageUrl,
  });

  factory BookModel.fromJson(json) => BookModel(
        category: json["category"] ?? "",
        categoryId: json["categoryId"] ?? "",
        instructor: json["instructor"] ?? "",
        subLevel: json["subLevel"] ?? "",
        title: json["title"] ?? "",
        uid: json["uid"] ?? "",
        body: json["body"] ?? "",
        price: json["price"] ?? "",
        subjectImageUrl: json["subjectImageUrl"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "categoryId": categoryId,
        "instructor": instructor,
        "subLevel": subLevel,
        "title": title,
        "uid": uid,
        "body": body,
        "price": price,
        "subjectImageUrl": subjectImageUrl,
      };
}

// List<BookModel> bookList(String title) {
//   return [
//     BookModel(
//       name: "Angalais $title",
//       author: "Kabinet Keita",
//       newPrice: "30,000",
//       oldPrice: "50,000",
//       pages: 29,
//       timeInHours: 2,
//       timeInMinutes: 21,
//       imageUrl: 'assets/images/glasses.png',
//     ),
//     BookModel(
//       name: "Chimie $title",
//       author: "Abdoulaye Bangoura",
//       newPrice: "30,000",
//       oldPrice: "50,000",
//       pages: 10,
//       timeInHours: 1,
//       timeInMinutes: 09,
//       imageUrl: 'assets/images/test_tubes.png',
//     ),
//     BookModel(
//       name: "Biologie $title",
//       author: "Elhadj Oumar Bah",
//       newPrice: "30,000",
//       oldPrice: "50,000",
//       pages: 27,
//       timeInHours: 5,
//       timeInMinutes: 50,
//       imageUrl: 'assets/images/biologie.png',
//     ),
//     BookModel(
//       name: "Chimie $title",
//       author: "Bafodé Bangoura",
//       newPrice: "30,000",
//       oldPrice: "50,000",
//       pages: 28,
//       timeInHours: 4,
//       timeInMinutes: 08,
//       imageUrl: 'assets/images/chimie.png',
//     ),
//     BookModel(
//       name: " Francais $title",
//       author: "Abdoulaye Bangoura",
//       newPrice: "30,000",
//       oldPrice: "50,000",
//       pages: 10,
//       timeInHours: 1,
//       timeInMinutes: 09,
//       imageUrl: 'assets/images/francais.png',
//     ),
//     BookModel(
//       name: "Histoire $title",
//       author: "Kabinet Keita",
//       newPrice: "30,000",
//       oldPrice: "50,000",
//       pages: 29,
//       timeInHours: 2,
//       timeInMinutes: 21,
//       imageUrl: 'assets/images/history.png',
//     ),
//   ];
// }


// class BookModel {
//   String name;
//   String author;
//   String newPrice;
//   String oldPrice;
//   int pages;
//   int timeInHours;
//   int timeInMinutes;
//   String imageUrl;

//   BookModel({
//     required this.name,
//     required this.author,
//     required this.newPrice,
//     required this.oldPrice,
//     required this.pages,
//     required this.timeInHours,
//     required this.timeInMinutes,
//     required this.imageUrl,
//   });
// }

// List<BookModel> bookList(String title) {
//   return [
//     BookModel(
//       name: "Angalais $title",
//       author: "Kabinet Keita",
//       newPrice: "30,000",
//       oldPrice: "50,000",
//       pages: 29,
//       timeInHours: 2,
//       timeInMinutes: 21,
//       imageUrl: 'assets/images/glasses.png',
//     ),
//     BookModel(
//       name: "Chimie $title",
//       author: "Abdoulaye Bangoura",
//       newPrice: "30,000",
//       oldPrice: "50,000",
//       pages: 10,
//       timeInHours: 1,
//       timeInMinutes: 09,
//       imageUrl: 'assets/images/test_tubes.png',
//     ),
//     BookModel(
//       name: "Biologie $title",
//       author: "Elhadj Oumar Bah",
//       newPrice: "30,000",
//       oldPrice: "50,000",
//       pages: 27,
//       timeInHours: 5,
//       timeInMinutes: 50,
//       imageUrl: 'assets/images/biologie.png',
//     ),
//     BookModel(
//       name: "Chimie $title",
//       author: "Bafodé Bangoura",
//       newPrice: "30,000",
//       oldPrice: "50,000",
//       pages: 28,
//       timeInHours: 4,
//       timeInMinutes: 08,
//       imageUrl: 'assets/images/chimie.png',
//     ),
//     BookModel(
//       name: " Francais $title",
//       author: "Abdoulaye Bangoura",
//       newPrice: "30,000",
//       oldPrice: "50,000",
//       pages: 10,
//       timeInHours: 1,
//       timeInMinutes: 09,
//       imageUrl: 'assets/images/francais.png',
//     ),
//     BookModel(
//       name: "Histoire $title",
//       author: "Kabinet Keita",
//       newPrice: "30,000",
//       oldPrice: "50,000",
//       pages: 29,
//       timeInHours: 2,
//       timeInMinutes: 21,
//       imageUrl: 'assets/images/history.png',
//     ),
//   ];
// }
