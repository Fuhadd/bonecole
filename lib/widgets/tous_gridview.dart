import 'package:bonecole/screens/book_details_screen.dart';
import 'package:bonecole/widgets/tous_container.dart';
import 'package:flutter/material.dart';

import '../models/book_model.dart';

class TousGridview extends StatelessWidget {
  const TousGridview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      // clipBehavior: ,// Set to true to enable scrolling in ListView
      // physics:
      //     const NeverScrollableScrollPhysics(), // Disable scrolling in ListView
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Set to 2 to display items in pairs
        childAspectRatio:
            0.54, // Set aspect ratio to 1 to maintain square shape
        crossAxisSpacing: 10,
        // Set spacing between columns
        mainAxisSpacing: 20,
      ),
      itemCount: bookList1.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    BookDetailScreen(book: bookList1[index])));
          },
          child: TousContainer(
            book: bookList1[index],
          ),
        );
      },
    );
  }
}
