import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/book_model.dart';
import '../utils/custom_colors.dart';
import '../utils/spacers.dart';

class TousContainer extends StatelessWidget {
  const TousContainer({
    super.key,
    required this.book,
  });
  final BookModel book;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Color of the shadow
            spreadRadius: 2, // Spread radius of the shadow
            blurRadius: 5, // Blur radius of the shadow
            offset: const Offset(0, 3), // Offset of the shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpacer(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(book.imageUrl), fit: BoxFit.cover)),
            ),
          ),
          verticalSpacer(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.name,
                  style: const TextStyle(
                      fontSize: 14.6,
                      fontWeight: FontWeight.w700,
                      color: CustomColors.mainColor),
                ),
                verticalSpacer(8),
                Text(
                  book.author,
                  style: const TextStyle(
                      fontSize: 13.6,
                      fontWeight: FontWeight.w500,
                      color: CustomColors.mainColor),
                ),
                verticalSpacer(20),
                Row(
                  children: [
                    Text(
                      book.newPrice,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: CustomColors.mainColor),
                    ),
                    horizontalSpacer(5),
                    Text(
                      book.oldPrice,
                      style: const TextStyle(
                          fontSize: 13,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.mainColor),
                    ),
                  ],
                ),
                verticalSpacer(20),
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.bookOpen,
                      size: 20,
                    ),
                    horizontalSpacer(10),
                    Text(
                      "${book.pages} lecons",
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: CustomColors.mainColor),
                    ),
                  ],
                ),
                verticalSpacer(7),
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.clock,
                      size: 20,
                    ),
                    horizontalSpacer(10),
                    Text(
                      "${book.timeInHours}H ${book.timeInMinutes} mins",
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: CustomColors.mainColor),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
