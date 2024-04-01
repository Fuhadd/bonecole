import 'package:bonecole/models/book_model.dart';
import 'package:bonecole/widgets/tous_container.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/course_model.dart';
import '../screens/book_details_screen.dart';
import '../screens/screens_view_model.dart';
import '../utils/custom_colors.dart';
import '../utils/random_image.dart';
import '../utils/spacers.dart';
import 'header_container.dart';

class BooksFutureBuilder extends StatefulWidget {
  const BooksFutureBuilder({
    super.key,
    // required this.ref,
    required this.fetchData,
    required this.category,
    // required this.mainColor,
  });

  // final WidgetRef ref;
  final String category;
  final Future<List<BookModel>> fetchData;
  // final Color mainColor;

  @override
  State<BooksFutureBuilder> createState() => _BooksFutureBuilderState();
}

class _BooksFutureBuilderState extends State<BooksFutureBuilder> {
  final Key _futureBuilderKey = UniqueKey();
  bool isLoading = false;
  bool isHeaderLoading = false;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      key: _futureBuilderKey,
      // initialData: discoveredCommunities,
      // future:
      //     CommunityViewModel.initWhoAmI().discoverNewCommunities(),
      // future: fetchData(),
      // future: CommunityViewModel.initWhoAmI().discoverNewCommunities(ref),
      future: widget.fetchData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/animations/loading_animation.json",
                  height: 150,
                  width: 150,
                  animate: true,
                  repeat: true,
                  reverse: false,
                  fit: BoxFit.contain,
                ),
                // verticalSpacer(20),
                // Text(
                //   "You have no  confessions available at the moment, share link below",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //       color: CustomColors.greyBgColor.withOpacity(0.7),
                //       fontSize: 15),
                // ),
              ],
            ),
          );
        }

        if (snapshot.hasData) {
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   ref.read(discoveredCommunitiesProvider.notifier).state =
          //       snapshot.data!;
          // });

          final books = snapshot.data;

          if (snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/animations/no-transaction-history.json",
                    height: 150,
                    width: 150,
                    animate: true,
                    repeat: true,
                    reverse: false,
                    fit: BoxFit.contain,
                  ),
                  verticalSpacer(20),
                  Text(
                    "You have no  books available at the moment, share link below",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: CustomColors.greyBgColor.withOpacity(0.7),
                        fontSize: 15),
                  ),
                ],
              ),
            );
          }
          return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: isLoading
                        ? null
                        : () async {
                            setState(() {
                              isHeaderLoading = true;
                            });
                            List<CurriculumResultModel> curriculums =
                                await ScreenViewModel()
                                    .getAllCurriculumsBySection(books![0].uid);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => BookDetailScreen(
                                      book: books[0],
                                      curriculums: curriculums,
                                    )));
                            setState(() {
                              isHeaderLoading = false;
                            });
                          },
                    child: HeaderContainer(
                      title: widget.category,
                      bookImageUrl: "assets/images/6eannee.png",
                      isLoading: isHeaderLoading,
                    ),
                  ),
                  // : const SizedBox.shrink(),
                  GridView.builder(
                    shrinkWrap: true,
                    // clipBehavior: ,// Set to true to enable scrolling in ListView
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable scrolling in ListView
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Set to 2 to display items in pairs
                      childAspectRatio:
                          0.50, // Set aspect ratio to 1 to maintain square shape
                      crossAxisSpacing: 10,
                      // Set spacing between columns
                      mainAxisSpacing: 20,
                    ),
                    itemCount: books!.length - 1,
                    itemBuilder: (context, index) {
                      String imageUrl = getImage();
                      return GestureDetector(
                        onTap: isLoading
                            ? null
                            : () async {
                                setState(() {
                                  isLoading = true;
                                  currentIndex = index + 1;
                                });
                                List<CurriculumResultModel> curriculums =
                                    await ScreenViewModel()
                                        .getAllCurriculumsBySection(
                                            books[index + 1].uid);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BookDetailScreen(
                                          book: books[index + 1],
                                          curriculums: curriculums,
                                        )));
                                setState(() {
                                  isLoading = false;
                                  currentIndex = index + 1;
                                });
                              },
                        child: TousContainer(
                          book: books[index + 1],
                          isLoading: isLoading,
                          index: index + 1,
                          currentIndex: currentIndex,
                        ),
                      );

                      return null;
                    },
                  ),
                ],
              ));
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/animations/loading_animation.json",
                height: 150,
                width: 150,
                animate: true,
                repeat: true,
                reverse: false,
                fit: BoxFit.contain,
              ),
            ],
          ),
        );
      },
    );
  }
}
