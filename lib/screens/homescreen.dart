import 'package:bonecole/screens/tous_page.dart';
import 'package:bonecole/utils/custom_colors.dart';
import 'package:bonecole/utils/spacers.dart';
import 'package:flutter/material.dart';
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
        title: SizedBox(
            height: 60, child: Image.asset('assets/images/bonecole_logo.png')),
        // actions: [
        //   GestureDetector(
        //     onTap: _toggleDrawer,
        //     child: Padding(
        //       padding: const EdgeInsets.only(right: 20.0),
        //       child: GestureDetector(
        //         onTap: () {
        //           if (!_isDrawerOpen) {
        //             Scaffold.of(context).openEndDrawer();
        //           } else {
        //             Navigator.of(context).pop();
        //           }
        //           _toggleDrawer();
        //         },
        //         child: const Icon(
        //           Icons.menu,
        //           color: CustomColors.mainColor,
        //           size: 35,
        //         ),
        //       ),
        //     ),
        //   )
        // ],
      ),
      endDrawer: const Drawer(
        child: EndDrawer(),
      ),
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
                    fontWeight: FontWeight.w700,
                    color: CustomColors.mainColor),
              ),
              verticalSpacer(20),
              const Text(
                "Convenablement avec les \nmeilleurs enseignants",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
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
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
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
                              'assets/images/boy_smiling_yellow.png',
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
                                  'assets/images/lady_smiling_orange.png',
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
                            color: CustomColors.mainColor,
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/boy_smiling_blue.png',
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
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        FontAwesomeIcons.quoteLeft,
                        color: CustomColors.lightOrange,
                      ),
                      const Expanded(
                        child: SizedBox(
                          child: Text(
                            "Le monde dans lequel vinrent les fulures gentsations en différent de celui auquel nous sanimes habituer. Al est princialial que mercis prépazions nos enfants ainsi que nosis-mêmeo peurs ce monde.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
                                color: CustomColors.whiteColor),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 40,
                          ),
                          const Icon(
                            FontAwesomeIcons.quoteRight,
                            color: CustomColors.lightOrange,
                          ),
                        ],
                      ),
                      horizontalSpacer(10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 20,
                          ),
                          const Text(
                            "Etudiez Sans limites!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: CustomColors.whiteColor),
                          ),
                          verticalSpacer(20),
                          Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.squareFacebook,
                                size: 20,
                              ),
                              horizontalSpacer(5),
                              const FaIcon(
                                FontAwesomeIcons.instagram,
                                size: 20,
                              ),
                              horizontalSpacer(5),
                              const Text(
                                "/ @bonecole",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EndDrawer extends StatelessWidget {
  const EndDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          // decoration: BoxDecoration(
          //   color: Colors.blue,
          // ),
          child: SizedBox(
              height: 60,
              child: Image.asset('assets/images/bonecole_logo.png')),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: ListTile(
            title: const Text(
              'Home',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
        ),
        verticalSpacer(20),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: ListTile(
            title: const Text(
              'Books',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const TousScreen()));
            },
          ),
        ),
      ],
    );
  }
}
