import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bonecole/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen(
      {super.key, required this.audioUrl, required this.isDownloaded});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
  final String audioUrl;
  final bool isDownloaded;
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isLoading = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    if (!isPlaying) {
      setState(() {
        isLoading = true;
      });
      String url =
          "https://firebasestorage.googleapis.com/v0/b/bonecole-2f0f4.appspot.com/o/4-things-i-wish-i-knew-in-my-20s-128-ytshorts.savetube.me.mp3?alt=media&token=a592f319-9ae1-441b-9979-a6bad33812ff";

      //       if (widget.isDownloaded) {
      //   final videoFile = File(widget.videpPath);
      //   _videoPlayerController = VideoPlayerController.file(videoFile);
      // } else {
      //   _videoPlayerController = VideoPlayerController.network(widget.videpPath);
      // }
      if (widget.isDownloaded) {
        final videoFile = File(widget.audioUrl);
        audioPlayer.play(DeviceFileSource(widget.audioUrl)).then((value) {
          setState(() {
            isLoading = false;
          });
        });
      } else {
        audioPlayer.play(UrlSource(widget.audioUrl)).then((value) {
          setState(() {
            isLoading = false;
          });
        });
      }
    }

    // Listen to states: playing, paused, stopped
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        // Check if the widget is still mounted
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    });

    //Listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) {
        // Check if the widget is still mounted
        setState(() {
          duration = newDuration;
        });
      }
    });

    // Yesterday I didnt really do much, i just continued on my
    // self development on youtube. And I also went the the firebase
    //Messaging setup. I haven't really studied it.

    //Listen to audio position
    audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) {
        // Check if the widget is still mounted
        setState(() {
          position = newPosition;
        });
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
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
        // title: SvgPicture.asset(
        //   "assets/icons/bonecole_icon.svg",
        //   height: 50,
        // ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SvgPicture.asset(
                    "assets/icons/bonecole_icon.svg",
                    // height: 250,
                  ),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 32,
            // ),

            Column(
              children: [
                const Text(
                  '💙 First Audio Course',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Sarah Abs',
                  style: TextStyle(fontSize: 20),
                ),
                Slider(
                    activeColor: CustomColors.orange,
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) async {}),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatTime(position)),
                      Text(formatTime(duration - position)),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 35,
                  child: IconButton(
                    icon: isLoading
                        ? const CircularProgressIndicator(
                            color: CustomColors.whiteColor,
                          )
                        : Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    iconSize: 40,
                    onPressed: () async {
                      if (isPlaying) {
                        await audioPlayer.pause();
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        String url =
                            "https://firebasestorage.googleapis.com/v0/b/bonecole-2f0f4.appspot.com/o/4-things-i-wish-i-knew-in-my-20s-128-ytshorts.savetube.me.mp3?alt=media&token=a592f319-9ae1-441b-9979-a6bad33812ff";
                        await audioPlayer.play(UrlSource(url));
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String formatTime(Duration position) {
  // Extract the minutes and seconds from the Duration object
  int minutes = position.inMinutes;
  int seconds = (position.inSeconds % 60);

  // Create a formatted string with leading zeros
  String formattedMinutes = minutes.toString().padLeft(2, '0');
  String formattedSeconds = seconds.toString().padLeft(2, '0');

  return '$formattedMinutes:$formattedSeconds';
}
