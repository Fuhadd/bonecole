import 'package:flutter/material.dart';

import '../screens/screens_view_model.dart';
import 'books_future_builder.dart';

class Emee6Gridview extends StatelessWidget {
  const Emee6Gridview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // List<BookModel> booklist = bookList("6e Année");
    // BookModel headerBook = BookModel(
    //   name: "Pack 6eme Annee",
    //   author: "Kabinet Keita",
    //   newPrice: "30,000",
    //   oldPrice: "50,000",
    //   pages: 29,
    //   timeInHours: 2,
    //   timeInMinutes: 21,
    //   imageUrl: 'assets/images/6eannee.png',
    // );
    return SingleChildScrollView(
      child: Column(
        children: [
          BooksFutureBuilder(
            fetchData:
                ScreenViewModel().getBooksByCourse("S8Lg6v6XLeWICFURIl29"),
            category: "Pack 6eme Annee",
          ),
          // Builder(
          //   builder: (context) {
          //     return GridView.builder(
          //       shrinkWrap: true,
          //       // clipBehavior: ,// Set to true to enable scrolling in ListView
          //       physics:
          //           const NeverScrollableScrollPhysics(), // Disable scrolling in ListView
          //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 2, // Set to 2 to display items in pairs
          //         childAspectRatio:
          //             0.54, // Set aspect ratio to 1 to maintain square shape
          //         crossAxisSpacing: 10,
          //         // Set spacing between columns
          //         mainAxisSpacing: 20,
          //       ),
          //       itemCount: booklist.length,
          //       itemBuilder: (context, index) {
          //         return GestureDetector(
          //           onTap: () {
          //             Navigator.of(context).push(MaterialPageRoute(
          //                 builder: (context) =>
          //                     BookDetailScreen(book: booklist[index])));
          //           },
          //           child: TousContainer(
          //             book: booklist[index],
          //           ),
          //         );
          //       },
          //     );
          //   }
          // ),
        ],
      ),
    );
  }
}
