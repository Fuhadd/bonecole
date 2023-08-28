import 'dart:io';

import 'package:bonecole/models/book_model.dart';
import 'package:bonecole/screens/pdf_viewer_page.dart';
import 'package:bonecole/screens/video_screen.dart';
import 'package:bonecole/utils/custom_colors.dart';
import 'package:bonecole/utils/pdf_api.dart';
import 'package:bonecole/utils/spacers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as Path;

import '../models/course_model.dart';
import '../utils/directory_path.dart';
import '../utils/random_image.dart';
import 'audio_player_screen.dart';

class BookDetailBackupScreen extends StatefulWidget {
  final BookModel book;
  final List<CurriculumResultModel> curriculums;

  const BookDetailBackupScreen({
    super.key,
    required this.book,
    required this.curriculums,
  });
  static const routeName = '/bookdetails';

  @override
  State<BookDetailBackupScreen> createState() => _BookDetailBackupScreenState();
}

class _BookDetailBackupScreenState extends State<BookDetailBackupScreen> {
  bool isPdfLoading = false;
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
                          image: AssetImage(getImage()),
                          fit: BoxFit.cover,
                          opacity: 0.3)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpacer(20),
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
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: curriculumList.length,
              //     itemBuilder: (context, index) {
              //       final curriculum = curriculumList[index];
              //       final title = curriculum.title;
              //       final time = curriculum.time;
              //       final fileUrl = curriculum.fileUrl;

              //       if (curriculum.type == CurriculumType.audio) {
              //         return CurriculumListAudio(
              //           title: title,
              //           time: time,
              //           fileUrl: fileUrl,
              //         );
              //       } else {
              //         return CurriculumList(
              //           title: title,
              //           time: time,
              //           fileUrl: fileUrl,
              //         );
              //       }
              //     },
              //   ),
              // )
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
                                setState(() {
                                  isPdfLoading = true;
                                });
                                const url =
                                    "https://www.ariostea-high-tech.com/doc/cataloghi_catalogues/balance-665.pdf";
                                final file = await PDFApi.loadNetwork(url);
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
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 3,
                          width: double.infinity,
                          color: CustomColors.mainColor,
                        ),
                      ),
                      verticalSpacer(20),
                      // Expanded(
                      //   child: ListView.builder(
                      //     itemCount: curriculumList.length,
                      //     itemBuilder: (context, index) {
                      //       final curriculum = curriculumList[index];
                      //       final title = curriculum.title;
                      //       final time = curriculum.time;
                      //       final fileUrl = curriculum.fileUrl;

                      //       if (curriculum.type == CurriculumType.audio) {
                      //         return CurriculumListAudio(
                      //           title: title,
                      //           time: time,
                      //           fileUrl: fileUrl,
                      //         );
                      //       } else {
                      //         return CurriculumList(
                      //           title: title,
                      //           time: time,
                      //           fileUrl: fileUrl,
                      //         );
                      //       }
                      //     },
                      //   ),
                      // )

                      const CurriculumList(
                          title: "1. Dissociation et produit ionique",
                          time: "08:00",
                          fileUrl:
                              "https://download.samplelib.com/mp4/sample-30s.mp4"),
                      const CurriculumList(
                          title: "4. Acide faible et base faible",
                          time: "09:22",
                          fileUrl:
                              "https://download.samplelib.com/mp4/sample-20s.mp4"),

                      const CurriculumListAudio(
                        title: "3. Les acides forts et les bases fortes",
                        time: "08:22",
                        fileUrl:
                            "https://firebasestorage.googleapis.com/v0/b/bonecole-2f0f4.appspot.com/o/4-things-i-wish-i-knew-in-my-20s-128-ytshorts.savetube.me.mp3?alt=media&token=a592f319-9ae1-441b-9979-a6bad33812ff",
                      ),

                      const CurriculumList(
                          title: "5. Bases et classification",
                          time: "10:51",
                          fileUrl:
                              "https://download.samplelib.com/mp4/sample-15s.mp4"),
                      const CurriculumList(
                          title:
                              "6. Réaction entre un acide fort et une base forte",
                          time: "09:53",
                          fileUrl:
                              "https://download.samplelib.com/mp4/sample-10s.mp4"),
                      const CurriculumListAudio(
                        title: "3. Les acides forts et les bases fortes",
                        time: "08:22",
                        fileUrl:
                            "https://samplelib.com/lib/preview/mp3/sample-9s.mp3",
                      ),
                      const CurriculumList(
                          title:
                              "7. Réaction entre un acide faible et une base forte",
                          time: "09:31",
                          fileUrl:
                              "https://download.samplelib.com/mp4/sample-30s.mp4"),
                      const CurriculumList(
                          title:
                              "8. Réaction entre un acide fort et une base faible",
                          time: "09:57",
                          fileUrl:
                              "https://download.samplelib.com/mp4/sample-30s.mp4"),

                      const CurriculumList(
                          title: "10. Solution tampon lère partie",
                          time: "07:50",
                          fileUrl:
                              "https://download.samplelib.com/mp4/sample-30s.mp4"),
                      const CurriculumList(
                          title: "11. Solution tampon 2ème partie",
                          time: "08:02",
                          fileUrl:
                              "https://samplelib.com/lib/preview/mp4/sample-5s.mp4"),
                      const CurriculumListAudio(
                        title: "3. Les acides forts et les bases fortes",
                        time: "08:22",
                        fileUrl:
                            "https://samplelib.com/lib/preview/mp3/sample-3s.mp3",
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
                        children: [
                          const Text(
                            "Chapitre 2: Cinétique chimique",
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
                                    "https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf";
                                final file = await PDFApi.loadNetwork(url);
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
                          fileUrl:
                              "https://download.samplelib.com/mp4/sample-30s.mp4"),
                      const CurriculumList(
                          title: "4. Acide faible et base faible",
                          time: "09:22",
                          fileUrl:
                              "https://download.samplelib.com/mp4/sample-20s.mp4"),
                      const CurriculumListAudio(
                        title: "3. Les acides forts et les bases fortes",
                        time: "08:22",
                        fileUrl:
                            "https://firebasestorage.googleapis.com/v0/b/bonecole-2f0f4.appspot.com/o/4-things-i-wish-i-knew-in-my-20s-128-ytshorts.savetube.me.mp3?alt=media&token=a592f319-9ae1-441b-9979-a6bad33812ff",
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

class CurriculumList extends StatefulWidget {
  const CurriculumList(
      {super.key,
      required this.title,
      required this.time,
      required this.fileUrl});
  final String title;
  final String time;
  final String fileUrl;

  @override
  State<CurriculumList> createState() => _CurriculumListState();
}

class _CurriculumListState extends State<CurriculumList> {
  bool dowloading = false;
  bool fileExists = false;
  double progress = 0;
  String fileName = "";
  late String filePath;
  late CancelToken cancelToken;
  var getPathFile = DirectoryPath();

  startDownload() async {
    cancelToken = CancelToken();
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    setState(() {
      dowloading = true;
      progress = 0;
    });

    try {
      await Dio().download(widget.fileUrl, filePath,
          onReceiveProgress: (count, total) {
        setState(() {
          progress = (count / total);
        });
      }, cancelToken: cancelToken);
      setState(() {
        dowloading = false;
        fileExists = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        dowloading = false;
      });
    }
  }

  cancelDownload() {
    cancelToken.cancel();
    setState(() {
      dowloading = false;
    });
  }

  checkFileExit() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    setState(() {
      fileExists = fileExistCheck;
    });
  }

  openfile() {
    OpenFile.open(filePath);
    print("fff $filePath");
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fileName = Path.basename(widget.fileUrl);
    });
    checkFileExit();
  }

  @override
  Widget build(BuildContext context) {
    BookModel headerBook = BookModel(
        category: "category",
        categoryId: "categoryId",
        instructor: "instructor",
        subLevel: "subLevel",
        title: "headline6",
        uid: "uid",
        body: "body");
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoScreen(
                      isDownloaded: fileExists,
                      book: headerBook,
                      videoUrl: fileExists ? filePath : widget.fileUrl,
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
                  child: IconButton(
                      onPressed: () {
                        fileExists && dowloading == false
                            // ? openfile()
                            ? null
                            : startDownload();
                      },
                      icon: fileExists
                          ? const Icon(
                              Icons.save,
                              color: Colors.green,
                            )
                          : dowloading
                              ? Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      value: progress,
                                      strokeWidth: 3,
                                      backgroundColor: Colors.grey,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Colors.blue),
                                    ),
                                    Text(
                                      "${(progress * 100).toInt()} %",
                                      style: const TextStyle(fontSize: 12),
                                    )
                                  ],
                                )
                              : const Icon(Icons.download))
                  //  Text(
                  //   widget.time,
                  //   style: const TextStyle(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w500,
                  //       color: CustomColors.mainColor),
                  // ),
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
    // BookModel headerBook = BookModel(
    //   name: "Pack 6eme Annee",
    //   author: "Kabinet Keita",
    //   newPrice: "30,000",
    //   oldPrice: "50,000",
    //   pages: 29,
    //   timeInHours: 2,
    //   timeInMinutes: 21,
    //   imageUrl: 'assets/images/6eannee.png',
    // );
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

class CurriculumListAudio extends StatefulWidget {
  const CurriculumListAudio({
    super.key,
    required this.title,
    required this.time,
    required this.fileUrl,
  });
  final String title;
  final String time;
  final String fileUrl;

  @override
  State<CurriculumListAudio> createState() => _CurriculumListAudioState();
}

class _CurriculumListAudioState extends State<CurriculumListAudio> {
  bool dowloading = false;
  bool fileExists = false;
  double progress = 0;
  String fileName = "";
  late String filePath;
  late CancelToken cancelToken;
  var getPathFile = DirectoryPath();

  startDownload() async {
    cancelToken = CancelToken();
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    setState(() {
      dowloading = true;
      progress = 0;
    });

    try {
      await Dio().download(widget.fileUrl, filePath,
          onReceiveProgress: (count, total) {
        setState(() {
          progress = (count / total);
        });
      }, cancelToken: cancelToken);
      setState(() {
        dowloading = false;
        fileExists = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        dowloading = false;
      });
    }
  }

  cancelDownload() {
    cancelToken.cancel();
    setState(() {
      dowloading = false;
    });
  }

  checkFileExit() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    setState(() {
      fileExists = fileExistCheck;
    });
  }

  openfile() {
    OpenFile.open(filePath);
    print("fff $filePath");
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fileName = Path.basename(widget.fileUrl);
    });
    checkFileExit();
  }

  @override
  Widget build(BuildContext context) {
    // BookModel headerBook = BookModel(
    //   name: "Pack 6eme Annee",
    //   author: "Kabinet Keita",
    //   newPrice: "30,000",
    //   oldPrice: "50,000",
    //   pages: 29,
    //   timeInHours: 2,
    //   timeInMinutes: 21,
    //   imageUrl: 'assets/images/6eannee.png',
    // );
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AudioPlayerScreen(
                      isDownloaded: fileExists,
                      // book: headerBook,
                      audioUrl: fileExists ? filePath : widget.fileUrl,
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
                  child: IconButton(
                      onPressed: () {
                        fileExists && dowloading == false
                            // ? openfile()
                            ? null
                            : startDownload();
                      },
                      icon: fileExists
                          ? const Icon(
                              Icons.save,
                              color: Colors.green,
                            )
                          : dowloading
                              ? Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      value: progress,
                                      strokeWidth: 3,
                                      backgroundColor: Colors.grey,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Colors.blue),
                                    ),
                                    Text(
                                      "${(progress * 100).toInt()} %",
                                      style: const TextStyle(fontSize: 12),
                                    )
                                  ],
                                )
                              : const Icon(Icons.download))

                  //  Text(
                  //   widget.time,
                  //   style: const TextStyle(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w500,
                  //       color: CustomColors.mainColor),
                  // ),
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
