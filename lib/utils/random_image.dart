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
//       imageUrl:
//     ),
//     BookModel(
//       name: "Chimie $title",
//       author: "Abdoulaye Bangoura",
//       newPrice: "30,000",
//       oldPrice: "50,000",
//       pages: 10,
//       timeInHours: 1,
//       timeInMinutes: 09,
//       imageUrl:
//     ),
//     BookModel(
//       name: "Biologie $title",
//       author: "Elhadj Oumar Bah",
//       newPrice: "30,000",
//       oldPrice: "50,000",
//       pages: 27,
//       timeInHours: 5,
//       timeInMinutes: 50,
//       imageUrl:
//     ),
//     BookModel(
//       name: "Chimie $title",
//       author: "Bafodé Bangoura",
//       newPrice: "30,000",
//       oldPrice: "50,000",
//       pages: 28,
//       timeInHours: 4,
//       timeInMinutes: 08,
//       imageUrl:
//     ),
//     BookModel(
//       name: " Francais $title",
//       author: "Abdoulaye Bangoura",
//       newPrice: "30,000",
//       oldPrice: "50,000",
//       pages: 10,
//       timeInHours: 1,
//       timeInMinutes: 09,
//       imageUrl:
//     ),
//     BookModel(
//       name: "Histoire $title",
//       author: "Kabinet Keita",
//       newPrice: "30,000",
//       oldPrice: "50,000",
//       pages: 29,
//       timeInHours: 2,
//       timeInMinutes: 21,
//       imageUrl:
//     ),
//   ];
// }

import 'dart:math';

var imagesUrl = [
  'assets/images/history.png',
  'assets/images/francais.png',
  'assets/images/chimie.png',
  'assets/images/biologie.png',
  'assets/images/test_tubes.png',
  'assets/images/glasses.png',
];

String getImage() {
  Random random = Random();
  int randomNumber = random.nextInt(imagesUrl.length - 1);
  return imagesUrl[randomNumber];
}
