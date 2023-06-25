import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/custom_colors.dart';
import '../utils/spacers.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    super.key,
    required this.title,
    required this.bookImageUrl,
  });
  final String title;
  final String bookImageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Container(
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
          children: [
            verticalSpacer(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(bookImageUrl), fit: BoxFit.cover)),
              ),
            ),
            verticalSpacer(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: CustomColors.mainColor),
                  ),
                  const Text(
                    "Toutes les matieres",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: CustomColors.mainColor),
                  ),
                  const Divider(
                    thickness: 2,
                    indent: 40,
                    endIndent: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "30,000 GNF",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: CustomColors.mainColor),
                      ),
                      horizontalSpacer(5),
                      const Text(
                        "50,000 GNF",
                        style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.mainColor),
                      ),
                    ],
                  ),
                  verticalSpacer(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/book_open.svg",
                        height: 20,
                      ),
                      horizontalSpacer(10),
                      const Text(
                        "6 matieres",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: CustomColors.mainColor),
                      ),
                    ],
                  ),
                  verticalSpacer(20)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
