import 'dart:io';

import 'package:bonecole/models/book_model.dart';
import 'package:bonecole/screens/pdf_viewer_page.dart';
import 'package:bonecole/screens/video_screen.dart';
import 'package:bonecole/utils/custom_colors.dart';
import 'package:bonecole/utils/pdf_api.dart';
import 'package:bonecole/utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'audio_player_screen.dart';

class BookDetailScreen extends StatelessWidget {
  final BookModel book;

  const BookDetailScreen({super.key, required this.book});
  static const routeName = '/bookdetails';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: CustomColors.mainColor),
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: CustomColors.mainColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
      //   child: EndDrawer(),
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              verticalSpacer(30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: CustomColors.blackColor,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(book.imageUrl),
                          fit: BoxFit.cover,
                          opacity: 0.3)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpacer(20),
                          Text(
                            book.name,
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: CustomColors.whiteColor),
                          ),
                          verticalSpacer(20),
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
                                      image: AssetImage(book.imageUrl),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              horizontalSpacer(15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book.author,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: CustomColors.whiteColor),
                                  ),
                                  verticalSpacer(5),
                                  const Text(
                                    "Terminales",
                                    style: TextStyle(
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
                              Text(
                                "${book.newPrice} GNF",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: CustomColors.mainColor),
                              ),
                              horizontalSpacer(10),
                              Text(
                                "${book.oldPrice} GNF",
                                style: const TextStyle(
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
                                color: CustomColors.mainColor.withOpacity(0.6)),
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
                            "Chapitre 1: Acide et base en solution aqueuse",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: CustomColors.mainColor),
                          ),
                          GestureDetector(
                              onTap: () async {
                                const url =
                                    "https://www.ariostea-high-tech.com/doc/cataloghi_catalogues/balance-665.pdf";
                                final file = await PDFApi.loadNetwork(url);
                                openPDF(context, file);
                              },
                              child: const Icon(FontAwesomeIcons.fileCode))
                        ],
                      ),
                      verticalSpacer(3),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 3,
                          width: double.infinity,
                          color: CustomColors.mainColor,
                        ),
                      ),
                      verticalSpacer(20),
                      const CurriculumList(
                        title: "1. Dissociation et produit ionique",
                        time: "08:00",
                      ),
                      const CurriculumListPDF(
                        title: "2. Dissociation et produit ionique (suite)",
                        time: "07:52",
                      ),
                      const CurriculumListAudio(
                        title: "3. Les acides forts et les bases fortes",
                        time: "08:22",
                      ),
                      const CurriculumList(
                        title: "4. Acide faible et base faible",
                        time: "09:22",
                      ),
                      const CurriculumList(
                        title: "5. Bases et classification",
                        time: "10:51",
                      ),
                      const CurriculumList(
                        title:
                            "6. Réaction entre un acide fort et une base forte",
                        time: "09:53",
                      ),
                      const CurriculumList(
                        title:
                            "7. Réaction entre un acide faible et une base forte",
                        time: "09:31",
                      ),
                      const CurriculumList(
                        title:
                            "8. Réaction entre un acide fort et une base faible",
                        time: "09:57",
                      ),
                      const CurriculumList(
                        title: "9. Dosage acido-basique",
                        time: "07:34",
                      ),
                      const CurriculumList(
                        title: "10. Solution tampon lère partie",
                        time: "07:50",
                      ),
                      const CurriculumList(
                        title: "11. Solution tampon 2ème partie",
                        time: "08:02",
                      ),
                      const CurriculumList(
                        title: "11. Solution tampon 2ème partie",
                        time: "",
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpacer(20),
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
                        children: const [
                          Text(
                            "Chapitre 2: Cinétique chimique",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: CustomColors.mainColor),
                          ),
                          Icon(FontAwesomeIcons.fileCode)
                        ],
                      ),
                      verticalSpacer(3),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 3,
                          width: double.infinity,
                          color: CustomColors.mainColor,
                        ),
                      ),
                      verticalSpacer(20),
                      const CurriculumList(
                        title: "1. Définition et évolution des systèmes",
                        time: "08:44",
                      ),
                      const CurriculumList(
                        title: "2. Vitesse des réactions",
                        time: "09:44",
                      ),
                      const CurriculumList(
                        title: "3. Les facteurs cinétiques",
                        time: "02:17",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
}

class CurriculumList extends StatelessWidget {
  const CurriculumList({
    super.key,
    required this.title,
    required this.time,
  });
  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
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
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => VideoScreen(
                      book: headerBook,
                      // startAt: snapshot.data!.docs[index].get("duration"),
                    )));
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: CustomColors.orange),
                      child: const Center(
                        child: Icon(
                          FontAwesomeIcons.play,
                          color: CustomColors.whiteColor,
                        ),
                      ),
                    ),
                    horizontalSpacer(10),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.mainColor),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  time,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: CustomColors.mainColor),
                ),
              ),
            ],
          ),
          verticalSpacer(4),
          const Divider(
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          verticalSpacer(10),
        ],
      ),
    );
  }
}

class CurriculumListPDF extends StatefulWidget {
  const CurriculumListPDF({
    super.key,
    required this.title,
    required this.time,
  });
  final String title;
  final String time;

  @override
  State<CurriculumListPDF> createState() => _CurriculumListPDFState();
}

class _CurriculumListPDFState extends State<CurriculumListPDF> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
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
    return GestureDetector(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        const url =
            "https://www.ariostea-high-tech.com/doc/cataloghi_catalogues/balance-665.pdf";
        final file = await PDFApi.loadNetwork(url);
        openPDF(context, file);
        setState(() {
          isLoading = false;
        });
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: CustomColors.orange),
                      child: Center(
                        child: isLoading
                            ? const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: CircularProgressIndicator(
                                  color: CustomColors.whiteColor,
                                ),
                              )
                            : const Icon(
                                FontAwesomeIcons.filePdf,
                                color: CustomColors.whiteColor,
                              ),
                      ),
                    ),
                    horizontalSpacer(10),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.mainColor),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.time,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: CustomColors.mainColor),
                ),
              ),
            ],
          ),
          verticalSpacer(4),
          const Divider(
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          verticalSpacer(10),
        ],
      ),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
}

class CurriculumListAudio extends StatelessWidget {
  const CurriculumListAudio({
    super.key,
    required this.title,
    required this.time,
  });
  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AudioPlayerScreen(
                    // book: headerBook,
                    // startAt: snapshot.data!.docs[index].get("duration"),
                    )));
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: CustomColors.orange),
                      child: const Center(
                        child: Icon(
                          FontAwesomeIcons.music,
                          color: CustomColors.whiteColor,
                        ),
                      ),
                    ),
                    horizontalSpacer(10),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.mainColor),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  time,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: CustomColors.mainColor),
                ),
              ),
            ],
          ),
          verticalSpacer(4),
          const Divider(
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          verticalSpacer(10),
        ],
      ),
    );
  }
}
