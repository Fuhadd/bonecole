import 'dart:io';

import 'package:bonecole/screens/pdf_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/book_model.dart';
import '../models/course_model.dart';
import '../utils/custom_colors.dart';
import '../utils/pdf_api.dart';
import '../utils/random_image.dart';
import '../utils/spacers.dart';

class TestScreen extends StatefulWidget {
  final BookModel book;
  final List<CurriculumResultModel> curriculums;
  const TestScreen({
    super.key,
    required this.book,
    required this.curriculums,
  });
  static const routeName = '/bookdetails1';

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool isPdfLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // titleSpacing: 700,
            // title: const Text('Nested ListViews Example'),
            expandedHeight: 700.0,
            flexibleSpace: Column(
              children: [
                // verticalSpacer(30),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: CustomColors.blackColor,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(getImage()),
                            fit: BoxFit.cover,
                            opacity: 0.3)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpacer(
                                MediaQuery.of(context).padding.top + 10),
                            Text(
                              widget.book.title,
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: CustomColors.whiteColor),
                            ),
                            verticalSpacer(20),
                            Text(
                              widget.curriculums.toString(),
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColors.whiteColor),
                            ),
                            const Text(
                              "Conçu par le MENA en collaboration avec l'INRAP, ce programme de Chimie Terminales est un programme harmonisé.",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColors.whiteColor),
                            ),
                            verticalSpacer(20),
                            const Text(
                              "Ce cours couvre ce qui suit: ",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColors.whiteColor),
                            ),
                            verticalSpacer(10),
                            const Text(
                              "1) La notion de pH de quantité de matière et concentration \n2) Un acide fort, une base forte, un acide faible et une base faible \n3) La constante d'acidité, \n4) L'évolution des systèmes, \n5) La stéréochimie",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: CustomColors.whiteColor),
                            ),
                            verticalSpacer(30),
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(getImage()),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                horizontalSpacer(15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.book.instructor,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: CustomColors.whiteColor),
                                    ),
                                    verticalSpacer(5),
                                    Text(
                                      widget.book.category,
                                      // "Terminales",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: CustomColors.whiteColor),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            verticalSpacer(30),
                          ]),
                    ),
                  ),
                ),
                verticalSpacer(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpacer(20),
                            Row(
                              children: [
                                const Text(
                                  "30,000 GNF",
                                  // "${widget.book.newPrice} GNF",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: CustomColors.mainColor),
                                ),
                                horizontalSpacer(10),
                                const Text(
                                  "50,000 GNF",
                                  // "${widget.book.oldPrice} GNF",
                                  style: TextStyle(
                                      fontSize: 18,
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.w500,
                                      color: CustomColors.mainColor),
                                ),
                              ],
                            ),
                            verticalSpacer(20),
                            Text(
                              "Achat unique, accès à toutes les leçons",
                              style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      CustomColors.mainColor.withOpacity(0.6)),
                            ),
                            verticalSpacer(40),
                            Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: CustomColors.orange,
                                  border:
                                      Border.all(color: CustomColors.mainColor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text(
                                  "Acheter maintenant",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: CustomColors.whiteColor),
                                ),
                              ),
                            ),
                            verticalSpacer(20),
                          ]),
                    ),
                  ),
                ),
                verticalSpacer(30),
                Column(
                  children: [
                    const Text(
                      "Curriculum",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.mainColor),
                    ),
                    verticalSpacer(3),
                    Container(
                      height: 3,
                      width: 80,
                      color: CustomColors.orange,
                    )
                  ],
                ),
                verticalSpacer(20),
              ],
            ), // You can replace this with your content
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // final curriculum = widget.curriculums[index];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  " curriculum.chapter.title",
                                  // "Chapitre 1: Acide et base en solution aqueuse",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: CustomColors.mainColor),
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        isPdfLoading = true;
                                      });
                                      const url =
                                          "https://www.ariostea-high-tech.com/doc/cataloghi_catalogues/balance-665.pdf";
                                      final file =
                                          await PDFApi.loadNetwork(url);
                                      setState(() {
                                        isPdfLoading = false;
                                      });
                                      openPDF(context, file);
                                    },
                                    child: isPdfLoading
                                        ? const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: SizedBox(
                                              height: 15,
                                              width: 15,
                                              child: CircularProgressIndicator(
                                                color: CustomColors.blackColor,
                                              ),
                                            ),
                                          )
                                        : const Icon(FontAwesomeIcons.fileCode))
                              ],
                            ),
                            verticalSpacer(3),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                height: 3,
                                width: double.infinity,
                                color: CustomColors.mainColor,
                              ),
                            ),
                            verticalSpacer(20),
                          ],
                        ),
                      ),
                    ),
                    verticalSpacer(20),
                    // ListView.builder(
                    //   itemCount: 10,
                    //   itemBuilder: (context, index) {
                    //     // final course = curriculum.courses[index];
                    //     // final title = curriculum.title;
                    //     // final time = curriculum.time;
                    //     // final fileUrl = curriculum.fileUrl;
                    //     if (widget.curriculums.isEmpty) {
                    //       return verticalSpacer(400);
                    //     }
                    //     return verticalSpacer(400);

                    //     // if (course.lessonUrl.endsWith(".mp3")) {
                    //     //   return CurriculumListAudio(
                    //     //     title: course.title,
                    //     //     time: course.duration,
                    //     //     fileUrl: course.lessonUrl,
                    //     //   );
                    //     // } else {
                    //     //   return CurriculumList(
                    //     //     title: course.title,
                    //     //     time: course.duration,
                    //     //     fileUrl: course.lessonUrl,
                    //     //   );
                    //     // }
                    //   },
                    // ),
                  ],
                );
              },
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
}
