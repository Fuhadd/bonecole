import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/book_model.dart';
import '../utils/custom_colors.dart';
import '../utils/random_image.dart';
import '../utils/spacers.dart';

class TousContainer extends StatelessWidget {
  const TousContainer({
    super.key,
    required this.book,
    required this.isLoading,
    required this.currentIndex,
    required this.index,
  });
  final BookModel book;
  final bool isLoading;
  final int currentIndex;
  final int index;
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
                      image: AssetImage(getImage()), fit: BoxFit.cover)),
            ),
          ),
          verticalSpacer(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: const TextStyle(
                      fontSize: 14.6,
                      fontWeight: FontWeight.w700,
                      color: CustomColors.mainColor),
                ),
                verticalSpacer(8),
                isLoading && (index == currentIndex)
                    ? const SizedBox(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(
                          color: CustomColors.blackColor,
                        ),
                      )
                    : Text(
                        book.instructor,
                        style: const TextStyle(
                            fontSize: 13.6,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.mainColor),
                      ),
                verticalSpacer(20),
                Row(
                  children: [
                    const Text(
                      "30,000",
                      // book.newPrice,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: CustomColors.mainColor),
                    ),
                    horizontalSpacer(5),
                    const Text(
                      "50,000",
                      // book.oldPrice,
                      style: TextStyle(
                          fontSize: 13,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.mainColor),
                    ),
                  ],
                ),
                verticalSpacer(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.bookOpen,
                          size: 20,
                        ),
                        horizontalSpacer(10),
                        const Text(
                          "29 lecons",
                          // "${book.pages} lecons",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: CustomColors.mainColor),
                        ),
                      ],
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
                    const Text(
                      "2H 21 mins",
                      // "${book.timeInHours}H ${book.timeInMinutes} mins",
                      style: TextStyle(
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
