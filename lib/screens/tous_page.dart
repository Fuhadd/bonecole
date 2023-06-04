import 'package:bonecole/utils/custom_colors.dart';
import 'package:bonecole/utils/spacers.dart';
import 'package:flutter/material.dart';

import '../widgets/terminales_gridview.dart';
import '../widgets/tous_gridview.dart';
import 'homescreen.dart';

class TousScreen extends StatefulWidget {
  const TousScreen({super.key});
  static const routeName = '/tousScreen';

  @override
  State<TousScreen> createState() => _TousScreenState();
}

class _TousScreenState extends State<TousScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: CustomColors.mainColor),
        elevation: 0,
        centerTitle: false,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: CustomColors.mainColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : const SizedBox.shrink(),
        title: SizedBox(
            height: 60, child: Image.asset('assets/images/bonecole_logo.png')),
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: 20.0),
        //     child: Icon(
        //       Icons.menu,
        //       color: CustomColors.mainColor,
        //       size: 35,
        //     ),
        //   )
        // ],
      ),
      endDrawer: const Drawer(
        child: EndDrawer(),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (_currentPage > 0) {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: CustomColors.mainColor),
                              color: _currentPage == 0
                                  ? CustomColors.mainColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "Tous",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: _currentPage == 0
                                        ? CustomColors.whiteColor
                                        : CustomColors.mainColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      horizontalSpacer(25),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (_currentPage < 2 - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: CustomColors.mainColor),
                                borderRadius: BorderRadius.circular(8),
                                color: _currentPage == 1
                                    ? CustomColors.mainColor
                                    : Colors.transparent),
                            child: Center(
                              child: Text(
                                "Terminales",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: _currentPage == 1
                                        ? CustomColors.whiteColor
                                        : CustomColors.mainColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpacer(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: CustomColors.mainColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              "10ème Année",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: CustomColors.mainColor),
                            ),
                          ),
                        ),
                      ),
                      horizontalSpacer(25),
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: CustomColors.mainColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              "6ème Année",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: CustomColors.mainColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpacer(20),
                Expanded(
                    child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  // onPageChanged: (int page) {
                  //   setState(() {
                  //     _currentPage = page;
                  //   });
                  // },
                  children: const [
                    TousGridview(),
                    TerminalesGridview(),
                    // ThirdOnboardingPage(),
                  ],
                )),
                // const TousGridview(),
                verticalSpacer(50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
