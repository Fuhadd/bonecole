import 'package:bonecole/screens/tous_page.dart';
import 'package:bonecole/utils/custom_colors.dart';
import 'package:bonecole/utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/homepage';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDrawerOpen = false;

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: CustomColors.mainColor),
        centerTitle: false,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
              const Text(
                "Convenablement avec les \nmeilleurs enseignants",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: CustomColors.mainColor),
              ),
              verticalSpacer(30),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(TousScreen.routeName);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColors.mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 16),
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 260,
                      width: ((MediaQuery.of(context).size.width) - 50) / 2,
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
                          width: ((MediaQuery.of(context).size.width) - 50) / 2,
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
                          width: ((MediaQuery.of(context).size.width) - 50) / 2,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            FontAwesomeIcons.quoteLeft,
                            color: CustomColors.lightOrange,
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Expanded(
                                  child: Text(
                                    "Le monde dans lequel vinrent les fulures gentsations en différent de celui auquel nous sanimes habituer. Al est princialial que mercis prépazions nos enfants ainsi que nosis-mêmeo peurs ce monde.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.italic,
                                        color: CustomColors.whiteColor),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    FontAwesomeIcons.quoteRight,
                                    color: CustomColors.lightOrange,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "~ ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: CustomColors.whiteColor),
                              ),
                              Text(
                                "Fedenaze Steven",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: CustomColors.whiteColor),
                              ),
                            ],
                          ),
                          verticalSpacer(25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                    color: CustomColors.whiteColor),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TousScreen(
                                currentPage: 1,
                              )));
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: CustomColors.mainColor),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TousScreen(
                                currentPage: 2,
                              )));
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: CustomColors.mainColor),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TousScreen(
                                currentPage: 3,
                              )));
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: CustomColors.mainColor),
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
              verticalSpacer(20 + (MediaQuery.of(context).padding.bottom))
            ],
          ),
        ),
      ),
    );
  }
}
