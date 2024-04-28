import 'package:bonecole/screens/course_packs_scrren.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/book_model.dart';
import '../models/course_packs.dart';
import '../screens/screens_view_model.dart';
import '../utils/custom_colors.dart';
import '../utils/spacers.dart';

class HeaderContainer extends StatefulWidget {
  const HeaderContainer({
    super.key,
    required this.title,
    required this.bookImageUrl,
    // required this.isLoading,
    required this.coursePack,
    required this.books,
  });
  final String title;
  final String bookImageUrl;
  // final bool isLoading;
  final List<BookModel> books;
  final CoursePackModel coursePack;

  @override
  State<HeaderContainer> createState() => _HeaderContainerState();
}

class _HeaderContainerState extends State<HeaderContainer> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading
          ? null
          : () async {
              setState(() {
                isLoading = true;
              });
              // getBooksFromList
              List<BookModel> courses = await ScreenViewModel()
                  .getBooksFromList(widget.coursePack.subjectsInPack);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CoursePackScreen(courses: courses)

                  // BookDetailScreen(
                  //       book: widget.books[0],
                  //       curriculums: curriculums,
                  //     )

                  ));
              setState(() {
                isLoading = false;
              });
            },
      child: Padding(
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
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(widget.bookImageUrl),
                          fit: BoxFit.cover)),
                ),
              ),
              verticalSpacer(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: CustomColors.mainColor),
                    ),
                    isLoading
                        ? const SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              color: CustomColors.blackColor,
                            ),
                          )
                        : Text(
                            widget.coursePack.body.isEmpty
                                ? "Toutes les matieres"
                                : widget.coursePack.body,
                            style: const TextStyle(
                                fontSize: 18,
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
                        Text(
                          "${widget.coursePack.price} GNF",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: CustomColors.mainColor),
                        ),
                        horizontalSpacer(5),
                        const Text(
                          "130,000 GNF",
                          style: TextStyle(
                              fontSize: 16,
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
                        Text(
                          "${widget.coursePack.subjectsInPack.length} matieres",
                          style: const TextStyle(
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
      ),
    );
  }
}
