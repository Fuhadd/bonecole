import 'package:flutter/material.dart';

import '../models/book_model.dart';
import '../screens/screens_view_model.dart';
import 'books_future_builder.dart';

class TousGridview extends StatelessWidget {
  const TousGridview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // List<BookModel> booklist1 = bookList("Terminales");
    // List<BookModel> booklist2 = bookList("10e Année");
    // List<BookModel> booklist3 = bookList("6e Année");
    List<BookModel> booklist = [];

    // booklist.addAll(booklist1);
    // booklist.addAll(booklist2);
    // booklist.addAll(booklist3);
    return SingleChildScrollView(
      child: Column(
        children: [
          BooksFutureBuilder(
            fetchData:
                ScreenViewModel().getBooksByCourse("CNP8soSP1m7lIcjgul2n"),
            category: "Pack Terminales",
          ),
          // GridView.builder(
          //   shrinkWrap: true,
          //   // clipBehavior: ,// Set to true to enable scrolling in ListView
          //   // physics:
          //   //     const NeverScrollableScrollPhysics(), // Disable scrolling in ListView
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2, // Set to 2 to display items in pairs
          //     childAspectRatio:
          //         0.54, // Set aspect ratio to 1 to maintain square shape
          //     crossAxisSpacing: 10,
          //     // Set spacing between columns
          //     mainAxisSpacing: 20,
          //   ),
          //   itemCount: booklist.length,
          //   itemBuilder: (context, index) {
          //     return GestureDetector(
          //       onTap: () {
          //         Navigator.of(context).push(MaterialPageRoute(
          //             builder: (context) =>
          //                 BookDetailScreen(book: booklist[index])));
          //       },
          //       child: TousContainer(
          //         book: booklist[index],
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
