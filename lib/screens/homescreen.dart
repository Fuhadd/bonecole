import 'package:bonecole/repositories/user_repo.dart';
import 'package:bonecole/screens/tous_page.dart';
import 'package:bonecole/utils/custom_colors.dart';
import 'package:bonecole/utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../locator.dart';
import '../models/teachers_model.dart';
import '../widgets/end_drawer.dart';
import 'audio_player_screen.dart';
import 'auth/auth_view_model.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});
  static const routeName = '/homepage';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final videoUrl = "https://www.youtube.com/watch?v=wdNzKvLUO-E&t=24s";
  bool _isDrawerOpen = false;
  late YoutubePlayerController _controller;

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );

    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: const ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
          bottomActions: [
            CurrentPosition(),
            ProgressBar(
              isExpanded: true,
              colors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
            ),
            FullScreenButton(),
          ],
        ),
        builder: (context, player) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                height: 2,
                                color: CustomColors.blackColor.withOpacity(0.3),
                              ),
                            ),

                            verticalSpacer(40),
                            const Text(
                              "Préparez le BAC, \nBREVET et CEE",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: CustomColors.mainColor),
                            ),
                            verticalSpacer(20),
                            GestureDetector(
                              onTap: () async {
                                await ref.watch(playerProvider).stop();
                              },
                              child: const Text(
                                "Convenablement avec les \nmeilleurs enseignants",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    color: CustomColors.mainColor),
                              ),
                            ),
                            verticalSpacer(30),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(TousScreen.routeName);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: CustomColors.mainColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 16),
                                  child: Text(
                                    "S'inscrire maintenant",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: CustomColors.whiteColor),
                                  ),
                                ),
                              ),
                            ),
                            verticalSpacer(40),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 260,
                                    width:
                                        ((MediaQuery.of(context).size.width) -
                                                50) /
                                            2,
                                    decoration: const BoxDecoration(
                                      color: CustomColors.mainColor,
                                      image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/boy_yellow_bg.png',
                                          ),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        topRight: Radius.circular(100),
                                        bottomLeft: Radius.circular(100),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: ((MediaQuery.of(context)
                                                    .size
                                                    .width) -
                                                50) /
                                            2,
                                        decoration: const BoxDecoration(
                                          color: CustomColors.mainColor,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/girl_red_bg.png',
                                              ),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(100),
                                            topRight: Radius.circular(100),
                                            bottomRight: Radius.circular(100),
                                          ),
                                        ),
                                      ),
                                      verticalSpacer(10),
                                      Container(
                                        height: 120,
                                        width: ((MediaQuery.of(context)
                                                    .size
                                                    .width) -
                                                50) /
                                            2,
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/boy_blue_bg.png',
                                              ),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(100),
                                            bottomRight: Radius.circular(100),
                                            bottomLeft: Radius.circular(100),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            verticalSpacer(40),
                            Container(
                              // height: 40,
                              color: CustomColors.lightMainColor,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.quoteLeft,
                                          color: CustomColors.lightOrange,
                                        ),
                                        Expanded(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: const [
                                              Expanded(
                                                child: Text(
                                                  "Le monde dans lequel vinrent les fulures gentsations en différent de celui auquel nous sanimes habituer. Al est princialial que mercis prépazions nos enfants ainsi que nosis-mêmeo peurs ce monde.",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: CustomColors
                                                          .whiteColor),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8.0),
                                                child: Icon(
                                                  FontAwesomeIcons.quoteRight,
                                                  color:
                                                      CustomColors.lightOrange,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      // mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "~ ",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      CustomColors.whiteColor),
                                            ),
                                            Text(
                                              "Fedenaze Steven",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      CustomColors.whiteColor),
                                            ),
                                          ],
                                        ),
                                        verticalSpacer(25),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/facebook_icon.svg",
                                              height: 30,
                                            ),
                                            horizontalSpacer(10),
                                            SvgPicture.asset(
                                              "assets/icons/instagram_icon.svg",
                                              height: 30,
                                            ),
                                            horizontalSpacer(10),
                                            const Text(
                                              "/ @Bonecole",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                  color:
                                                      CustomColors.whiteColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    horizontalSpacer(10),
                                  ],
                                ),
                              ),
                            ),
                            verticalSpacer(40),
                            const Text(
                              "Cours Populaires",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: CustomColors.mainColor),
                            ),
                            verticalSpacer(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TousScreen(
                                                  currentPage: 1,
                                                )));
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: CustomColors.mainColor),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Terminales",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: CustomColors.mainColor),
                                      ),
                                    ),
                                  ),
                                ),
                                horizontalSpacer(12),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TousScreen(
                                                  currentPage: 2,
                                                )));
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: CustomColors.mainColor),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "10e Année",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: CustomColors.mainColor),
                                      ),
                                    ),
                                  ),
                                ),
                                horizontalSpacer(12),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TousScreen(
                                                  currentPage: 3,
                                                )));
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: CustomColors.mainColor),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "6e Année",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: CustomColors.mainColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            verticalSpacer(40),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                "Rencontrez nos Professeurs",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    color: CustomColors.mainColor),
                              ),
                            ),
                            verticalSpacer(10),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                "Commencez votre apprentissage avec les meilleurs enseignants.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: CustomColors.greyBgColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            verticalSpacer(10),
                            FutureBuilder<List<TeacherModel>>(
                                future:
                                    locator<UserRepository>().getAllTeachers(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // While the data is loading, display a loader
                                    return const Align(
                                      alignment: Alignment.centerRight,
                                      child: SizedBox(
                                          height: 10,
                                          width: 10,
                                          child: CircularProgressIndicator()),
                                    );
                                  } else if (snapshot.hasError) {
                                    // If there's an error, display an error message
                                    return Text('Error: ${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        final teacher = snapshot.data![index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 50.0, vertical: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(
                                                      0.5), // Color of the shadow
                                                  spreadRadius:
                                                      2, // Spread radius of the shadow
                                                  blurRadius:
                                                      5, // Blur radius of the shadow
                                                  offset: const Offset(0,
                                                      3), // Offset of the shadow
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 15),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 150,
                                                    // width: 100,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            teacher.imageUrl),
                                                      ),
                                                    ),
                                                  ),
                                                  verticalSpacer(10),
                                                  Text(
                                                    teacher.firstName +
                                                        teacher.lastName,
                                                    style: const TextStyle(
                                                        color: CustomColors
                                                            .blackColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  verticalSpacer(5),
                                                  teacher.subject.isNotEmpty &&
                                                          teacher
                                                              .level.isNotEmpty
                                                      ? Text(
                                                          "${teacher.subject} / ${teacher.level}",
                                                          style: const TextStyle(
                                                              color: CustomColors
                                                                  .blackColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      : const SizedBox.shrink(),
                                                  verticalSpacer(3),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 25.0),
                                                    child: Divider(
                                                      color: CustomColors
                                                          .greyBgColor
                                                          .withOpacity(0.4),
                                                    ),
                                                  ),
                                                  verticalSpacer(5),
                                                  Text(
                                                    teacher.body!.isEmpty
                                                        ? teacher.bio ?? ""
                                                        : teacher.body ?? "",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: CustomColors
                                                            .greyBgColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    // If
                                    //there's no data available, display an empty state
                                    return const Text('No data available');
                                  }
                                }),
                            verticalSpacer(40),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                "VOIR +",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    color: CustomColors.mainColor),
                              ),
                            ),
                            verticalSpacer(10),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                "Regardez nos guides tutoriels pour mieux navigeur.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: CustomColors.greyBgColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            verticalSpacer(20),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 10),
                              child: player,
                            ),
                            verticalSpacer(30),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: CustomColors.lightMainColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15),
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Ne ratez pas nos nouveautés et offres spéciales",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600,
                                          color: CustomColors.whiteColor,
                                        ),
                                      ),
                                      verticalSpacer(20),
                                      const Text(
                                        "Suivez nous sur...",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: CustomColors.whiteColor),
                                      ),
                                      verticalSpacer(25),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.facebook,
                                            color: CustomColors.whiteColor,
                                          ),
                                          horizontalSpacer(10),
                                          const Icon(
                                            FontAwesomeIcons.linkedin,
                                            color: CustomColors.whiteColor,
                                          ),
                                          horizontalSpacer(10),
                                          const Icon(
                                            FontAwesomeIcons.twitter,
                                            color: CustomColors.whiteColor,
                                          ),
                                          horizontalSpacer(10),
                                          const Text(
                                            "/ @bonecole",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: CustomColors.whiteColor),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            verticalSpacer(30),
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: CustomColors.darkGreyColor),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Bonecole",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: CustomColors.whiteColor),
                                    ),
                                    verticalSpacer(15),
                                    const Text(
                                      "Tel: +224 611 23 88 88",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: CustomColors.whiteColor),
                                    ),
                                    verticalSpacer(5),
                                    const Text(
                                      "Email du contact: contact@bonecole.com",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: CustomColors.whiteColor),
                                    ),
                                    verticalSpacer(25),
                                    const Text(
                                      "Accueil",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: CustomColors.whiteColor),
                                    ),
                                    verticalSpacer(5),
                                    const Text(
                                      "Cours",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: CustomColors.whiteColor),
                                    ),
                                    verticalSpacer(5),
                                    const Text(
                                      "Conditions d'utilisation",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: CustomColors.whiteColor,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    verticalSpacer(5),
                                    const Text(
                                      "politique de confidentialité",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: CustomColors.whiteColor,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    verticalSpacer(30),
                                    const Text(
                                      "© 2023 BONECOLE.INC. tous droits réservés",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: CustomColors.whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            verticalSpacer(
                                20 + (MediaQuery.of(context).padding.bottom)),
                            // YoutubePlayer(
                            //   controller: _controller,
                            //   showVideoProgressIndicator: true,
                            //   progressIndicatorColor: Colors.amber,
                            //   progressColors: const ProgressBarColors(
                            //     playedColor: Colors.amber,
                            //     handleColor: Colors.amberAccent,
                            //   ),
                            //   bottomActions: [
                            //     CurrentPosition(),
                            //     ProgressBar(
                            //       isExpanded: true,
                            //       colors: const ProgressBarColors(
                            //         playedColor: Colors.amber,
                            //         handleColor: Colors.amberAccent,
                            //       ),
                            //     ),
                            //     FullScreenButton(),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      // visible: ref.watch(isPlayingProvider) ||
                      //     ref.watch(playerProvider).state == PlayerState.paused,
                      child: Positioned(
                        bottom: 20,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                                color:
                                    CustomColors.greyBgColor.withOpacity(0.95),
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
                                      inactiveColor: CustomColors.lightOrange
                                          .withOpacity(0.5),
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
                )),
          );
        });
  }
}
