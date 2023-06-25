import 'package:bonecole/widgets/tous_container.dart';
import 'package:flutter/material.dart';

import '../models/book_model.dart';
import '../screens/book_details_screen.dart';
import 'header_container.dart';

class Emee6Gridview extends StatelessWidget {
  const Emee6Gridview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<BookModel> booklist = bookList("6e Année");
    BookModel headerBook = BookModel(
      name: "Pack 6eme Annee",
      author: "Kabinet Keita",
      newPrice: "30,000",
      oldPrice: "50,000",
      pages: 29,
      timeInHours: 2,
      timeInMinutes: 21,
      imageUrl: 'assets/images/6eannee.png',
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BookDetailScreen(book: headerBook)));
            },
            child: const HeaderContainer(
              title: "Pack 6eme Annee",
              bookImageUrl: "assets/images/6eannee.png",
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            // clipBehavior: ,// Set to true to enable scrolling in ListView
            physics:
                const NeverScrollableScrollPhysics(), // Disable scrolling in ListView
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Set to 2 to display items in pairs
              childAspectRatio:
                  0.54, // Set aspect ratio to 1 to maintain square shape
              crossAxisSpacing: 10,
              // Set spacing between columns
              mainAxisSpacing: 20,
            ),
            itemCount: booklist.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          BookDetailScreen(book: booklist[index])));
                },
                child: TousContainer(
                  book: booklist[index],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}