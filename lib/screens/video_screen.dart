import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

import '../models/book_model.dart';
import '../utils/custom_colors.dart';
import '../utils/spacers.dart';

enum MovieName {
  bridgerton,
  brotherhood,
  johnwick,
  nf,
  nowyouseeme,
  rick,
  wednessday,
}

String getMovieName(MovieName type) {
  switch (type) {
    case MovieName.bridgerton:
      return "https://drive.google.com/u/0/uc?id=1QD61BKjQ71VIq0ei4eHwwXpZ2R8DcU4G&export=download#.mp4";
    case MovieName.brotherhood:
      return "https://drive.google.com/u/0/uc?id=1rC5e-NpT7Eh2rTg5cQnfu395P9DjBiNK&export=download#.mp4";
    case MovieName.johnwick:
      return "https://drive.google.com/u/0/uc?id=1_VBD9jLqnjdvQtn_HogbPmCe79EIVNWS&export=download#.mp4";
    case MovieName.nf:
      return "https://drive.google.com/u/0/uc?id=1ixESVrWfVPCMgip2c7CfenFlU1j4cPIe&export=download#.mp4";
    case MovieName.nowyouseeme:
      return "https://drive.google.com/u/0/uc?id=1s7JSovZu5xDSqCc0Hv4B35MscuSnAcaI&export=download#.mp4";
    case MovieName.rick:
      return "https://drive.google.com/u/0/uc?id=1TcSd0AN62rDC-dsSlpmS0aeqbPZGapBE&export=download#.mp4";
    case MovieName.wednessday:
      return "https://drive.google.com/u/0/uc?id=1dNUyxOtRBFYFQpjucSXdC7b-V0ei8CPY&export=download#.mp4";
    default:
      return "assets/icons/icon_dialog.svg";
  }
}

class VideoScreen extends StatefulWidget {
  final BookModel book;
  final String videoUrl;
  final int startAt;
  final bool isDownloaded;
  static const routeName = '/entry_screen';
  const VideoScreen(
      {super.key,
      required this.videoUrl,
      required this.book,
      required this.isDownloaded,
      this.startAt = 0});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController? _controller;
  // AppVideoPlayer appVideoPlayer = AppVideoPlayer();

  @override
  void initState() {
    super.initState();
    duration = widget.startAt;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    // _controller = VideoPlayerController.network(widget.movieUrl)
    //   ..initialize().then((_) {
    //     setState(() {
    //       _controller!.play();
    //     });
    //   });
    // appVideoPlayer.init();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
    //appVideoPlayer.removeController(appVideoPlayer.index);
  }

  void updateCurrentDuration(Duration currentDuration) {
    // Do something with the currentDuration value in the parent widget
    duration = currentDuration.inMilliseconds;
    print(currentDuration);
  }

  late int duration;

  @override
  Widget build(BuildContext context) {
    var width = (MediaQuery.of(context).size.width - 50);
    var heigth = (MediaQuery.of(context).size.height - 50);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Stack(
              children: [
                VideoPlayerWidget(
                  videpPath: widget.videoUrl,
                  // "https://neallusmawubucket001.s3.us-east-2.amazonaws.com/Mawu+Files/Videos/Shadow.mp4",
                  onUpdateDuration: updateCurrentDuration,
                  startAt: Duration(milliseconds: duration),
                  book: widget.book,
                  duration: duration,
                  isDownloaded: widget.isDownloaded,
                ),
                // Row(
                //   children: [
                //     IconButton(
                //       onPressed: () {
                //         Navigator.pushReplacement(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => const PlayScreen(),
                //           ),
                //         );
                //       },
                //       icon: Icon(
                //         Icons.arrow_back,
                //         color: CustomColors.orange,
                //       ),
                //     ),
                //     horizontalSpacer(10),
                //     Text(
                //       "CC",
                //       textAlign: TextAlign.left,
                //       style: TextStyle(
                //         color: CustomColors.orange,
                //         fontSize: 20,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    required this.videpPath,
    required this.onUpdateDuration,
    required this.startAt,
    required this.book,
    required this.duration,
    required this.isDownloaded,
  });
  final String videpPath;
  final Function(Duration) onUpdateDuration;
  final Duration startAt;
  final BookModel book;
  final int duration;
  final bool isDownloaded;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  Future<void>? _initializeVideoPlayerFuture;
  Duration _currentDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // _videoPlayerController = VideoPlayerController.network(widget.videpPath);
    // _videoPlayerController = VideoPlayerController.network(widget.videpPath);
    if (widget.isDownloaded) {
      final videoFile = File(widget.videpPath);
      // if (Platform.isIOS) {
      //   var file = File(widget.videpPath);

      //   Uint8List bytes = file.readAsBytesSync();

      //   var buffer = bytes.buffer;

      //   var unit8 = buffer.asUint8List(32, bytes.lengthInBytes - 32);
      //   getApplicationDocumentsDirectory().then((value) {
      //     var tmpFile = "$value/tmp.mp4";
      //     //  audioPlayer.play(urlSource);

      //     _videoPlayerController = VideoPlayerController.file(File(tmpFile));
      //   });

      //   // var tmpFile = "${dir.path}/tmp.mp4";
      //   //  audioPlayer.play(urlSource);

      //   // _videoPlayerController = VideoPlayerController.file(File(tmpFile));
      // } else {
      //   _videoPlayerController = VideoPlayerController.file(videoFile);
      // }
      _videoPlayerController = VideoPlayerController.file(videoFile);
    } else {
      _videoPlayerController = VideoPlayerController.network(widget.videpPath);
    }

    // _chewieController = ChewieController(
    //   videoPlayerController: _videoPlayerController,
    //   aspectRatio: 16 / 9,
    // );

    _videoPlayerController
        .initialize()
        .then((_) => setState(() => _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController,
              autoPlay: true,
              // fullScreenByDefault: true,
              startAt: widget.startAt,
              customControls: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      // await FirestoreRepository().saveContinueWatching(
                      //     widget.movie.id!, widget.duration);
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => BookDetailScreen(
                      //       book: widget.book,
                      //     ),
                      //   ),
                      // );
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: CustomColors.orange,
                    ),
                  ),
                  horizontalSpacer(10),
                  const Text(
                    "CC",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: CustomColors.orange,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              //aspectRatio: _videoPlayerController.value.aspectRatio,
            )));
    _videoPlayerController.addListener(() {
      setState(() {
        _currentDuration = _videoPlayerController.value.position;
        widget.onUpdateDuration(_currentDuration);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _videoPlayerController.value.isInitialized
        ? Center(
            child: Chewie(
              controller: _chewieController,
              // ChewieController(
              //   videoPlayerController: _videoPlayerController,
              //   aspectRatio: 16 / 9,
              //   looping: false,
              //   autoInitialize: true,
              //   errorBuilder: (context, errorMessage) {
              //     return Center(
              //       child: Text(
              //         errorMessage,
              //         style: const TextStyle(
              //           color: Colors.white,
              //         ),
              //       ),
              //     );
              //   },
              // ),
            ),
          )
        : const SpinKitCircle(
            color: Colors.white,
            size: 50.0,
          );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
