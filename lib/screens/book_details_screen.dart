import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bonecole/models/book_model.dart';
import 'package:bonecole/screens/pdf_viewer_page.dart';
import 'package:bonecole/screens/video_screen.dart';
import 'package:bonecole/utils/custom_colors.dart';
import 'package:bonecole/utils/pdf_api.dart';
import 'package:bonecole/utils/spacers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/course_model.dart';
import '../utils/directory_path.dart';
import '../utils/random_image.dart';
import 'audio_player_screen.dart';
import 'auth/auth_view_model.dart';

class BookDetailScreen extends StatefulHookConsumerWidget {
  final BookModel book;
  final List<CurriculumResultModel> curriculums;

  const BookDetailScreen({
    super.key,
    required this.book,
    required this.curriculums,
  });
  static const routeName = '/bookdetails';

  @override
  ConsumerState<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends ConsumerState<BookDetailScreen> {
  bool isPdfLoading = false;
  // final audioPlayer = AudioPlayer();
  // bool isPlaying = false;
  bool isLoading = false;
  // Duration duration = Duration.zero;
  // Duration position = Duration.zero;
  String imageUrl = "";
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
    imageUrl = getImage();

    // if (!isPlaying) {
    //   setState(() {
    //     isLoading = true;
    //   });
    //   String url =
    //       "https://firebasestorage.googleapis.com/v0/b/bonecole-2f0f4.appspot.com/o/4-things-i-wish-i-knew-in-my-20s-128-ytshorts.savetube.me.mp3?alt=media&token=a592f319-9ae1-441b-9979-a6bad33812ff";

    //   //       if (widget.isDownloaded) {
    //   //   final videoFile = File(widget.videpPath);
    //   //   _videoPlayerController = VideoPlayerController.file(videoFile);
    //   // } else {
    //   //   _videoPlayerController = VideoPlayerController.network(widget.videpPath);
    //   // }
    //   if (widget.isDownloaded) {
    //     final videoFile = File(widget.audioUrl);
    //     audioPlayer.play(DeviceFileSource(widget.audioUrl)).then((value) {
    //       setState(() {
    //         isLoading = false;
    //       });
    //     });
    //   } else {
    //     audioPlayer.play(UrlSource(widget.audioUrl)).then((value) {
    //       setState(() {
    //         isLoading = false;
    //       });
    //     });
    //   }
    // }

    // Listen to states: playing, paused, stopped
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(playerProvider).onPlayerStateChanged.listen((state) {
        if (mounted) {
          // Check if the widget is still mounted

          ref.read(isPlayingProvider.notifier).state =
              state == PlayerState.playing;
        }
      });

      //Listen to audio duration
      ref.watch(playerProvider).onDurationChanged.listen((newDuration) {
        if (mounted) {
          // Check if the widget is still mounted

          ref.read(durationProvider.notifier).state = newDuration;
        }
      });

      //Listen to audio position
      ref.watch(playerProvider).onPositionChanged.listen((newPosition) {
        if (mounted) {
          // Check if the widget is still mounted
          setState(() {
            ref.read(positionProvider.notifier).state = newPosition;
          });
        }
      });
    });
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    await ref.watch(playerProvider).stop();
  }

  void playAudio(bool isDownloaded, String audioUrl) {
    if (true) {
      ref.watch(playerProvider).dispose();
      setState(() {
        isLoading = true;
      });
      //       if (widget.isDownloaded) {
      //   final videoFile = File(widget.videpPath);
      //   _videoPlayerController = VideoPlayerController.file(videoFile);
      // } else {
      //   _videoPlayerController = VideoPlayerController.network(widget.videpPath);
      // }
      if (isDownloaded) {
        final videoFile = File(audioUrl);
        ref
            .watch(playerProvider)
            .play(DeviceFileSource(audioUrl))
            .then((value) {
          setState(() {
            isLoading = false;
          });
        });
      } else {
        ref.watch(playerProvider).play(UrlSource(audioUrl)).then((value) {
          setState(() {
            isLoading = false;
          });
        });
      }
    }
  }

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
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 5,
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
                                image: AssetImage(imageUrl),
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
                                            image: AssetImage(imageUrl),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    horizontalSpacer(15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          decoration:
                                              TextDecoration.lineThrough,
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
                                      color: CustomColors.mainColor
                                          .withOpacity(0.6)),
                                ),
                                verticalSpacer(40),
                                GestureDetector(
                                  onTap: () {
                                    print(ref.watch(isPlayingProvider));
                                  },
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: CustomColors.orange,
                                        border: Border.all(
                                            color: CustomColors.mainColor),
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.curriculums.length,
                        itemBuilder: (context, index) {
                          final curriculum = widget.curriculums[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        curriculum.chapter.title,
                                        // "Chapitre 1: Acide et base en solution aqueuse",
                                        style: const TextStyle(
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
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: CustomColors
                                                          .blackColor,
                                                    ),
                                                  ),
                                                )
                                              : const Icon(
                                                  FontAwesomeIcons.fileCode))
                                    ],
                                  ),
                                  verticalSpacer(3),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Container(
                                      height: 3,
                                      width: double.infinity,
                                      color: CustomColors.mainColor,
                                    ),
                                  ),
                                  verticalSpacer(20),

                                  curriculum.courses.isEmpty
                                      ? Column(
                                          children: [
                                            // verticalSpacer(10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                horizontalSpacer(30),
                                                const Expanded(
                                                  child: Text(
                                                    "No Courses Available for now, try again soon",
                                                    // "Chapitre 1: Acide et base en solution aqueuse",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: CustomColors
                                                            .mainColor),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                )
                                              ],
                                            ),
                                            verticalSpacer(10),
                                          ],
                                        )
                                      : Column(
                                          children:
                                              curriculum.courses.map((course) {
                                            if (course.lessonUrl
                                                .endsWith(".mp3")) {
                                              return CurriculumListAudio(
                                                title: course.title,
                                                time: course.duration,
                                                fileUrl: course.lessonUrl,
                                                // duration: duration,
                                                isLoading: isLoading,
                                                uid: course.uid,
                                                // isPlaying: isPlaying,
                                                // position: position,
                                                // audioPlayer: audioPlayer,
                                              );
                                            } else {
                                              return CurriculumList(
                                                title: course.title,
                                                time: course.duration,
                                                fileUrl: course.lessonUrl,
                                                uid: course.uid,
                                              );
                                            }
                                          }).toList(),
                                        ),

                                  const CurriculumQuiz(
                                    title: "QCM sample1",
                                  ),
                                  verticalSpacer(15),
                                  //   SizedBox(
                                  //     height: 400,
                                  //     child: ListView.builder(
                                  //       shrinkWrap: true,
                                  //       itemCount: curriculum.courses.length,
                                  //       itemBuilder: (context, index) {
                                  //         final course = curriculum.courses[index];
                                  //         // final title = curriculum.title;
                                  //         // final time = curriculum.time;
                                  //         // final fileUrl = curriculum.fileUrl;
                                  //         return verticalSpacer(100);

                                  //         // if (course.lessonUrl.endsWith(".mp3")) {
                                  //         //   return CurriculumListAudio(
                                  //         //     title: course.title,
                                  //         //     time: course.duration,
                                  //         //     fileUrl: course.lessonUrl,
                                  //         //   );
                                  //         // } else {
                                  //         //   return CurriculumList(
                                  //         //     title: course.title,
                                  //         //     time: course.duration,
                                  //         //     fileUrl: course.lessonUrl,
                                  //         //   );
                                  //         // }
                                  //       },
                                  //     ),
                                  //   ),
                                  //  ///Herer
                                  ///

                                  // ListView.builder()
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // verticalSpacer(20),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    //   child: Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: Column(
                    //       // mainAxisAlignment: MainAxisAlignment.start,
                    //       // crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             const Text(
                    //               "Chapitre 2: Cinétique chimique",
                    //               style: TextStyle(
                    //                   fontSize: 12,
                    //                   fontWeight: FontWeight.w700,
                    //                   color: CustomColors.mainColor),
                    //             ),
                    //             GestureDetector(
                    //                 onTap: () async {
                    //                   setState(() {
                    //                     isPdfLoading = true;
                    //                   });
                    //                   const url =
                    //                       "https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf";
                    //                   final file = await PDFApi.loadNetwork(url);
                    //                   setState(() {
                    //                     isPdfLoading = false;
                    //                   });
                    //                   openPDF(context, file);
                    //                 },
                    //                 child: isPdfLoading
                    //                     ? const Padding(
                    //                         padding: EdgeInsets.all(10.0),
                    //                         child: SizedBox(
                    //                           height: 15,
                    //                           width: 15,
                    //                           child: CircularProgressIndicator(
                    //                             color: CustomColors.blackColor,
                    //                           ),
                    //                         ),
                    //                       )
                    //                     : const Icon(FontAwesomeIcons.fileCode))
                    //           ],
                    //         ),
                    //         verticalSpacer(3),
                    //         Padding(
                    //           padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    //           child: Container(
                    //             height: 3,
                    //             width: double.infinity,
                    //             color: CustomColors.mainColor,
                    //           ),
                    //         ),
                    //         verticalSpacer(20),
                    //         const CurriculumList(
                    //             title: "1. Dissociation et produit ionique",
                    //             time: "08:00",
                    //             fileUrl:
                    //                 "https://download.samplelib.com/mp4/sample-30s.mp4"),
                    //         const CurriculumList(
                    //             title: "4. Acide faible et base faible",
                    //             time: "09:22",
                    //             fileUrl:
                    //                 "https://download.samplelib.com/mp4/sample-20s.mp4"),
                    //         const CurriculumListAudio(
                    //           title: "3. Les acides forts et les bases fortes",
                    //           time: "08:22",
                    //           fileUrl:
                    //               "https://firebasestorage.googleapis.com/v0/b/bonecole-2f0f4.appspot.com/o/4-things-i-wish-i-knew-in-my-20s-128-ytshorts.savetube.me.mp3?alt=media&token=a592f319-9ae1-441b-9979-a6bad33812ff",
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: ref.watch(isPlayingProvider) ||
                ref.watch(playerProvider).state == PlayerState.paused,
            child: Positioned(
              bottom: 20,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: CustomColors.greyBgColor.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(10)),
                  height: 45,
                  width: MediaQuery.of(context).size.width - 50,
                  child: Row(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(formatTime(position)),
                      //       Text(formatTime(duration - position)),
                      //     ],
                      //   ),
                      // ),
                      IconButton(
                        icon: isLoading
                            ? const CircularProgressIndicator(
                                color: CustomColors.whiteColor,
                              )
                            : Icon(
                                ref.watch(isPlayingProvider)
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                                size: 26,
                              ),
                        // iconSize: 20,
                        onPressed: () async {
                          if (ref.watch(isPlayingProvider)) {
                            await ref.watch(playerProvider).pause();
                          } else {
                            await ref.watch(playerProvider).resume();
                            // setState(() {
                            //   isLoading = true;
                            // });
                            // String url =
                            //     "https://firebasestorage.googleapis.com/v0/b/bonecole-2f0f4.appspot.com/o/4-things-i-wish-i-knew-in-my-20s-128-ytshorts.savetube.me.mp3?alt=media&token=a592f319-9ae1-441b-9979-a6bad33812ff";
                            // await ref
                            //     .watch(playerProvider)
                            //     .play(UrlSource(url));
                            // setState(() {
                            //   isLoading = false;
                            // });
                          }
                        },
                      ),
                      Expanded(
                        child: Slider(
                            activeColor: CustomColors.whiteColor,
                            inactiveColor:
                                CustomColors.lightOrange.withOpacity(0.5),
                            min: 0,
                            max: ref
                                .read(durationProvider.notifier)
                                .state
                                .inSeconds
                                .toDouble(),
                            value: ref
                                .read(positionProvider.notifier)
                                .state
                                .inSeconds
                                .toDouble(),
                            onChanged: (value) async {}),
                      ),

                      Text(
                        formatTime(ref.read(durationProvider.notifier).state -
                            ref.read(positionProvider.notifier).state),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
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

class CurriculumList extends StatefulWidget {
  const CurriculumList(
      {super.key,
      required this.title,
      required this.time,
      required this.fileUrl,
      required this.uid});
  final String title;
  final String time;
  final String fileUrl;
  final String uid;

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

  startDownload(String courseId) async {
    cancelToken = CancelToken();
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$courseId.mp4';
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
    var getUidPathFile = DirectoryPath();
    var storePathUid = await getUidPathFile.getPath();
    String filePathUid = '$storePathUid/${widget.uid}.mp4';
    bool fileExistCheckUid = await File(filePathUid).exists();
    //
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName.mp4';

    bool fileExistCheck = await File(filePath).exists();
    setState(() {
      if (fileExistCheckUid == true) {
        fileExists = fileExistCheckUid;
        filePath = filePathUid;
      } else {
        fileExists = fileExistCheck;
      }
    });
    setState(() {});
    // var storePath = await getPathFile.getPath();
    // filePath = '$storePath/$fileName.mp4';
    // bool fileExistCheck = await File(filePath).exists();
    // setState(() {
    //   fileExists = fileExistCheck;
    // });
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
                            : startDownload(widget.uid);
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

class CurriculumListAudio extends StatefulHookConsumerWidget {
  CurriculumListAudio({
    super.key,
    required this.title,
    required this.time,
    required this.fileUrl,
    // required this.duration,
    required this.isLoading,
    required this.uid,
    // required this.isPlaying,
    // required this.position,
    // required this.audioPlayer,
  });
  final String title;
  final String time;
  final String fileUrl;
  final String uid;
  // final Duration duration;
  // final Duration position;
  // final bool isPlaying;
  bool isLoading;
  // final AudioPlayer audioPlayer;

  @override
  ConsumerState<CurriculumListAudio> createState() =>
      _CurriculumListAudioState();
}

class _CurriculumListAudioState extends ConsumerState<CurriculumListAudio> {
  bool dowloading = false;
  bool fileExists = false;
  double progress = 0;
  String fileName = "";
  late String filePath;
  late CancelToken cancelToken;
  var getPathFile = DirectoryPath();
  bool isPdfLoading = false;
  // final audioPlayer = AudioPlayer();
  // bool isPlaying = false;
  // bool isLoading = false;
  // Duration duration = Duration.zero;
  // Duration position = Duration.zero;

  void playAudio(bool isDownloaded, String audioUrl) async {
    if (ref.watch(isPlayingProvider)) {
      await ref.watch(playerProvider).stop();
    }
    // if (!widget.isPlaying) {
    setState(() {
      widget.isLoading = true;
    });
    //       if (widget.isDownloaded) {
    //   final videoFile = File(widget.videpPath);
    //   _videoPlayerController = VideoPlayerController.file(videoFile);
    // } else {
    //   _videoPlayerController = VideoPlayerController.network(widget.videpPath);
    // }
    if (isDownloaded) {
      print(audioUrl);
      final videoFile = File(audioUrl);
      print(videoFile);

      // ref
      //     .watch(playerProvider)
      //     .setSource(DeviceFileSource(audioUrl))
      //     .then((value) {
      //   setState(() {
      //     widget.isLoading = false;
      //   });
      // });

      // final videoFile = File(audioUrl);

      // Future<bool> saveVideo(String url, String fileName) async {
      //   Directory directory;
      //   try {
      //     if (Platform.isAndroid) {
      //       if (await _requestPermission(Permission.storage)) {
      //         directory = await getExternalStorageDirectory();
      //         String newPath = "";
      //         print(directory);
      //         List<String> paths = directory.path.split("/");
      //         for (int x = 1; x < paths.length; x++) {
      //           String folder = paths[x];
      //           if (folder != "Android") {
      //             newPath += "/$folder";
      //           } else {
      //             break;
      //           }
      //         }
      //         newPath = "$newPath/RPSApp";
      //         directory = Directory(newPath);
      //       } else {
      //         return false;
      //       }
      //     } else {
      //       if (await _requestPermission(Permission.photos)) {
      //         directory = await getTemporaryDirectory();
      //       } else {
      //         return false;
      //       }
      //     }
      //     File saveFile = File("${directory.path}/$fileName");
      //     if (!await directory.exists()) {
      //       await directory.create(recursive: true);
      //     }
      //     if (await directory.exists()) {
      //       await dio.download(url, saveFile.path,
      //           onReceiveProgress: (value1, value2) {
      //         setState(() {
      //           progress = value1 / value2;
      //         });
      //       });
      //       if (Platform.isIOS) {
      //         await ImageGallerySaver.saveFile(saveFile.path,
      //             isReturnPathOfIOS: true);
      //       }
      //       return true;
      //     }
      //     return false;
      //   } catch (e) {
      //     print(e);
      //     return false;
      //   }
      // }

      // OpenFile.open(widget.fileUrl);
      // if (Platform.isIOS) {
      //   var file = File(audioUrl);

      //   Uint8List bytes = file.readAsBytesSync();

      //   var buffer = bytes.buffer;

      //   var unit8 = buffer.asUint8List(32, bytes.lengthInBytes - 32);
      //   Directory dir = await getApplicationDocumentsDirectory();

      //   var tmpFile = "${dir.path}/tmp.mp3";
      //   var writeFile = File(tmpFile).writeAsBytesSync(unit8);
      //   var urlSource = DeviceFileSource(tmpFile);
      //   //  audioPlayer.play(urlSource);

      //   ref
      //       .watch(playerProvider)
      //       .play(DeviceFileSource(urlSource.path))
      //       .then((value) {
      //     setState(() {
      //       widget.isLoading = false;
      //     });
      //   });
      // } else {
      //   ref
      //       .watch(playerProvider)
      //       .play(DeviceFileSource(audioUrl))
      //       .then((value) {
      //     setState(() {
      //       widget.isLoading = false;
      //     });
      //   });
      // }

      ref.watch(playerProvider).play(DeviceFileSource(audioUrl)).then((value) {
        setState(() {
          widget.isLoading = false;
        });
      });
    } else {
      print(audioUrl);
      ref.watch(playerProvider).play(UrlSource(audioUrl)).then((value) {
        setState(() {
          widget.isLoading = false;
        });
      });
    }
    // }
  }

  startDownload(String courseId) async {
    cancelToken = CancelToken();
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$courseId.mp3';
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

  // startDownload(String courseId) async {
  //   cancelToken = CancelToken();
  //   var storePath = await getPathFile.getPath();
  //   filePath = '$storePath/$courseId';
  //   setState(() {
  //     dowloading = true;
  //     progress = 0;
  //   });

  //   try {
  //     await Dio().download(widget.fileUrl, filePath,
  //         onReceiveProgress: (count, total) {
  //       setState(() {
  //         progress = (count / total);
  //       });
  //     }, cancelToken: cancelToken);
  //     setState(() {
  //       dowloading = false;
  //       fileExists = true;
  //     });
  //   } catch (e) {
  //     print(e);
  //     setState(() {
  //       dowloading = false;
  //     });
  //   }
  // }

  cancelDownload() {
    cancelToken.cancel();
    setState(() {
      dowloading = false;
    });
  }

  checkFileExit() async {
    var getUidPathFile = DirectoryPath();
    var storePathUid = await getUidPathFile.getPath();
    String filePathUid = '$storePathUid/${widget.uid}.mp3';
    bool fileExistCheckUid = await File(filePathUid).exists();
    //
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName.mp3';

    bool fileExistCheck = await File(filePath).exists();
    setState(() {
      if (fileExistCheckUid == true) {
        fileExists = fileExistCheckUid;
        filePath = filePathUid;
      } else {
        fileExists = fileExistCheck;
      }
    });
    setState(() {});
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
      onTap: () => playAudio(
        fileExists,
        fileExists ? filePath : widget.fileUrl,
      ),

      // () {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => AudioPlayerScreen(
      //                 isDownloaded: fileExists,
      //                 // book: headerBook,
      //                 audioUrl: fileExists ? filePath : widget.fileUrl,
      //                 // book: headerBook,
      //                 // startAt: snapshot.data!.docs[index].get("duration"),
      //               )));
      // },
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
                        child: widget.isLoading
                            ? const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: CircularProgressIndicator(
                                  color: CustomColors.whiteColor,
                                ),
                              )
                            : const Icon(
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
                            : startDownload(widget.uid);
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

class CurriculumQuiz extends StatefulHookConsumerWidget {
  const CurriculumQuiz({
    super.key,
    required this.title,
  });
  final String title;

  @override
  ConsumerState<CurriculumQuiz> createState() => _CurriculumQuizState();
}

class _CurriculumQuizState extends ConsumerState<CurriculumQuiz> {
  bool dowloading = false;
  bool fileExists = false;
  double progress = 0;
  String fileName = "";
  late String filePath;
  late CancelToken cancelToken;
  var getPathFile = DirectoryPath();
  bool isPdfLoading = false;
  // final audioPlayer = AudioPlayer();
  // bool isPlaying = false;
  // bool isLoading = false;
  // Duration duration = Duration.zero;
  // Duration position = Duration.zero;

  // void playAudio(bool isDownloaded, String audioUrl) async {
  //   if (ref.watch(isPlayingProvider)) {
  //     await ref.watch(playerProvider).stop();
  //   }
  //   // if (!widget.isPlaying) {
  //   setState(() {
  //     widget.isLoading = true;
  //   });
  //   //       if (widget.isDownloaded) {
  //   //   final videoFile = File(widget.videpPath);
  //   //   _videoPlayerController = VideoPlayerController.file(videoFile);
  //   // } else {
  //   //   _videoPlayerController = VideoPlayerController.network(widget.videpPath);
  //   // }
  //   if (isDownloaded) {
  //     print(audioUrl);
  //     final videoFile = File(audioUrl);
  //     print(videoFile);

  //     ref
  //         .watch(playerProvider)
  //         .setSource(DeviceFileSource(audioUrl))
  //         .then((value) {
  //       setState(() {
  //         widget.isLoading = false;
  //       });
  //     });

  //     // final videoFile = File(audioUrl);
  //     // ref.watch(playerProvider).play(DeviceFileSource(audioUrl)).then((value) {
  //     //   setState(() {
  //     //     widget.isLoading = false;
  //     //   });
  //     // });
  //   } else {
  //     print(audioUrl);
  //     ref.watch(playerProvider).play(UrlSource(audioUrl)).then((value) {
  //       setState(() {
  //         widget.isLoading = false;
  //       });
  //     });
  //   }
  //   // }
  // }

  // startDownload(String courseId) async {
  //   cancelToken = CancelToken();
  //   var storePath = await getPathFile.getPath();
  //   filePath = '$storePath/$courseId';
  //   setState(() {
  //     dowloading = true;
  //     progress = 0;
  //   });

  //   try {
  //     await Dio().download(widget.fileUrl, filePath,
  //         onReceiveProgress: (count, total) {
  //       setState(() {
  //         progress = (count / total);
  //       });
  //     }, cancelToken: cancelToken);
  //     setState(() {
  //       dowloading = false;
  //       fileExists = true;
  //     });
  //   } catch (e) {
  //     print(e);
  //     setState(() {
  //       dowloading = false;
  //     });
  //   }
  // }

  // cancelDownload() {
  //   cancelToken.cancel();
  //   setState(() {
  //     dowloading = false;
  //   });
  // }

  // checkFileExit() async {
  //   var getUidPathFile = DirectoryPath();
  //   var storePathUid = await getUidPathFile.getPath();
  //   String filePathUid = '$storePathUid/${widget.uid}';
  //   bool fileExistCheckUid = await File(filePathUid).exists();
  //   //
  //   var storePath = await getPathFile.getPath();
  //   filePath = '$storePath/$fileName';

  //   bool fileExistCheck = await File(filePath).exists();
  //   setState(() {
  //     if (fileExistCheckUid == true) {
  //       fileExists = fileExistCheckUid;
  //       filePath = filePathUid;
  //     } else {
  //       fileExists = fileExistCheck;
  //     }
  //   });
  //   setState(() {});
  // }

  // openfile() {
  //   OpenFile.open(filePath);
  //   print("fff $filePath");
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     fileName = Path.basename(widget.fileUrl);
  //   });
  //   checkFileExit();
  // }

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
      // onTap: () => playAudio(
      //   fileExists,
      //   fileExists ? filePath : widget.fileUrl,
      // ),

      // () {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => AudioPlayerScreen(
      //                 isDownloaded: fileExists,
      //                 // book: headerBook,
      //                 audioUrl: fileExists ? filePath : widget.fileUrl,
      //                 // book: headerBook,
      //                 // startAt: snapshot.data!.docs[index].get("duration"),
      //               )));
      // },
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
                          child:
                              // widget.isLoading
                              //     ? const Padding(
                              //         padding: EdgeInsets.all(10.0),
                              //         child: CircularProgressIndicator(
                              //           color: CustomColors.whiteColor,
                              //         ),
                              //       )
                              //     :
                              Text(
                        "Q",
                        style: TextStyle(
                            color: CustomColors.whiteColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 22),
                      )),
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
              // Padding(
              //     padding: const EdgeInsets.only(left: 8.0),
              //     child: IconButton(
              //         onPressed: () {
              //           fileExists && dowloading == false
              //               // ? openfile()
              //               ? null
              //               : startDownload(widget.uid);
              //         },
              //         icon: fileExists
              //             ? const Icon(
              //                 Icons.save,
              //                 color: Colors.green,
              //               )
              //             : dowloading
              //                 ? Stack(
              //                     alignment: Alignment.center,
              //                     children: [
              //                       CircularProgressIndicator(
              //                         value: progress,
              //                         strokeWidth: 3,
              //                         backgroundColor: Colors.grey,
              //                         valueColor:
              //                             const AlwaysStoppedAnimation<Color>(
              //                                 Colors.blue),
              //                       ),
              //                       Text(
              //                         "${(progress * 100).toInt()} %",
              //                         style: const TextStyle(fontSize: 12),
              //                       )
              //                     ],
              //                   )
              //                 : const Icon(Icons.download))

              //     //  Text(
              //     //   widget.time,
              //     //   style: const TextStyle(
              //     //       fontSize: 14,
              //     //       fontWeight: FontWeight.w500,
              //     //       color: CustomColors.mainColor),
              //     // ),
              //     ),
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
