import 'package:bonecole/models/teachers_model.dart';
import 'package:bonecole/widgets/tous_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/book_model.dart';
import '../models/course_model.dart';
import '../screens/book_details_screen.dart';
import '../screens/screens_view_model.dart';
import '../utils/custom_colors.dart';
import '../utils/random_image.dart';
import '../utils/spacers.dart';

class CoursePackScreen extends StatefulWidget {
  const CoursePackScreen({
    super.key,
    // required this.ref,
    // required this.category,
    required this.courses,
    // required this.mainColor,
  });
  // final String category;
  final List<BookModel> courses;

  @override
  State<CoursePackScreen> createState() => _CoursePackScreenState();
}

class _CoursePackScreenState extends State<CoursePackScreen> {
  final Key _futureBuilderKey = UniqueKey();
  bool isLoading = false;
  bool isHeaderLoading = false;
  int currentIndex = 0;
  TeacherModel? teacher;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: CustomColors.mainColor),
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: CustomColors.mainColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : const SizedBox.shrink(),
        title: SvgPicture.asset(
          "assets/icons/bonecole_icon.svg",
          height: 50,
        ),
        // actions: [
        //   Builder(builder: (context) {
        //     return GestureDetector(
        //       onTap: () {
        //         Scaffold.of(context).openEndDrawer();
        //       },
        //       child: Padding(
        //         padding: const EdgeInsets.only(right: 20.0),
        //         child: SvgPicture.asset(
        //           "assets/icons/menu_icon.svg",
        //           height: 14,
        //         ),
        //       ),
        //     );
        //   })
        // ],
      ),
      // endDrawer: const Drawer(
      //   backgroundColor: Colors.black,
      //   child: EndDrawer(),
      // ),
      // endDrawer: const Drawer(
      //   child: EndDrawer(),
      // ),
      body: SingleChildScrollView(
        child: SizedBox(
          // height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 2,
                    color: CustomColors.blackColor.withOpacity(0.3),
                  ),
                ),
                verticalSpacer(20),
                GridView.builder(
                  shrinkWrap: true,
                  // clipBehavior: ,// Set to true to enable scrolling in ListView
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable scrolling in ListView
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Set to 2 to display items in pairs
                    childAspectRatio:
                        0.50, // Set aspect ratio to 1 to maintain square shape
                    crossAxisSpacing: 10,
                    // Set spacing between columns
                    mainAxisSpacing: 20,
                  ),
                  itemCount: widget.courses.length,
                  itemBuilder: (context, index) {
                    String imageUrl = getImage();
                    return GestureDetector(
                      onTap: isLoading
                          ? null
                          : () async {
                              widget.courses[index];
                              print(widget.courses[index]);
                              setState(() {
                                isLoading = true;
                                currentIndex = index + 1;
                              });
                              List<CurriculumResultModel> curriculums =
                                  await ScreenViewModel()
                                      .getAllCurriculumsBySection(
                                          widget.courses[index].uid);
                              String fullName =
                                  widget.courses[index].instructor;
                              List<String> nameParts = fullName
                                  .split(' '); // Split the string at spaces

                              String firstName = nameParts.isNotEmpty
                                  ? nameParts[0]
                                  : ""; // First word as firstName
                              String lastName = nameParts.length > 1
                                  ? nameParts.sublist(1).join(' ').trim()
                                  : ""; // Remaining words as lastName

                              teacher = await ScreenViewModel()
                                  .getAllTeachersFromName(firstName, lastName);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BookDetailScreen(
                                        book: widget.courses[index],
                                        curriculums: curriculums,
                                        teacher: teacher,
                                      )));

                              setState(() {
                                isLoading = false;
                                currentIndex = index + 1;
                              });
                            },
                      child: TousContainer(
                        book: widget.courses[index],
                        isLoading: isLoading,
                        index: index + 1,
                        currentIndex: currentIndex,
                      ),
                    );

                    return null;
                  },
                ),
                verticalSpacer(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
