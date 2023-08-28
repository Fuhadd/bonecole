import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bonecole/utils/custom_colors.dart';
import 'package:bonecole/utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/course_model.dart';
import '../utils/directory_path.dart';
import '../widgets/end_drawer.dart';
import 'audio_player_screen.dart';
import 'auth/auth_view_model.dart';
import 'book_details_screen.dart';
// import 'book_details_backup.dart';

class MyCoursesScreen extends StatefulHookConsumerWidget {
  final List<DownloadedCourseModel> curriculums;
  const MyCoursesScreen({
    super.key,
    required this.curriculums,
  });
  static const routeName = '/homepage';

  @override
  ConsumerState<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends ConsumerState<MyCoursesScreen> {
  bool _isDrawerOpen = false;
  bool fileExists = false;
  var getPathFile = DirectoryPath();
  String fileName = "";
  late String filePath;

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
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

  checkFileExit2() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    return fileExistCheck;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // setState(() {
    //   fileName = Path.basename(widget.fileUrl);
    // });
    // checkFileExit();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: CustomColors.mainColor),
              centerTitle: false,
              title: SvgPicture.asset(
                "assets/icons/bonecole_icon.svg",
                height: 50,
              ),
              actions: [
                Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: SvgPicture.asset(
                        "assets/icons/menu_icon.svg",
                        height: 14,
                      ),
                    ),
                  );
                })
              ],
            ),
            endDrawer: const Drawer(
              backgroundColor: Colors.black,
              child: EndDrawer(),
            ),
            body: Stack(
              alignment: Alignment.center,
              children: [
                SingleChildScrollView(
                  child: Center(
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
                        Column(
                          children: [
                            const Text(
                              "Cours Enregistrès",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColors.mainColor),
                            ),
                            verticalSpacer(3),
                            Container(
                              height: 3,
                              width: 120,
                              color: CustomColors.orange,
                            )
                          ],
                        ),
                        verticalSpacer(40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      "Downloads",
                                      // "Chapitre 1: Acide et base en solution aqueuse",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: CustomColors.mainColor),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    )
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
                                widget.curriculums.isNotEmpty
                                    ? Column(
                                        children:
                                            widget.curriculums.map((data) {
                                          if (data.course.lessonUrl
                                              .endsWith(".mp3")) {
                                            return CurriculumListAudio(
                                              title: data.course.title,
                                              time: data.course.duration,
                                              fileUrl: data.downloadedPath,
                                              // duration: duration,
                                              isLoading: false,
                                              uid: data.course.uid,
                                              // isPlaying: isPlaying,
                                              // position: position,
                                              // audioPlayer: audioPlayer,
                                            );
                                          } else {
                                            return CurriculumList(
                                              title: data.course.title,
                                              time: data.course.duration,
                                              fileUrl: data.downloadedPath,
                                              uid: data.course.uid,
                                            );
                                          }
                                        }).toList(),
                                      )
                                    : Column(
                                        children: [
                                          verticalSpacer(10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              horizontalSpacer(30),
                                              const Text(
                                                "No download for now",
                                                // "Chapitre 1: Acide et base en solution aqueuse",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        CustomColors.mainColor),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                verticalSpacer(15),
                              ],
                            ),
                          ),
                        )
                      ],
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
                              icon: Icon(
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
                                      .watch(durationProvider)
                                      .inSeconds
                                      .toDouble(),
                                  value: ref
                                      .watch(positionProvider)
                                      .inSeconds
                                      .toDouble(),
                                  onChanged: (value) async {}),
                            ),

                            Text(
                              formatTime(ref.watch(durationProvider) -
                                  ref.watch(positionProvider)),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
                        icon: Icon(
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
}
