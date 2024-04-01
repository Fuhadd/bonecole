import 'package:bonecole/utils/custom_colors.dart';
import 'package:bonecole/utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/end_drawer.dart';
import '../widgets/privacy_policy_widget.dart';
import '../widgets/terms_and_condition_widget.dart';

class PrivacyPolicyScreen extends StatefulHookConsumerWidget {
  const PrivacyPolicyScreen({super.key});
  static const routeName = '/homepage';

  @override
  ConsumerState<PrivacyPolicyScreen> createState() =>
      _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends ConsumerState<PrivacyPolicyScreen> {
  bool _isDrawerOpen = false;
  int activeContainerIndex = 0;

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Container(
                height: 2,
                color: CustomColors.blackColor.withOpacity(0.3),
              ),
              verticalSpacer(40),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          activeContainerIndex = 0;
                        });
                      },
                      child: Container(
                        height: 40,
                        decoration: activeContainerIndex == 0
                            ? BoxDecoration(
                                color: CustomColors.blackColor,
                                border: Border.all(
                                  color: CustomColors.blackColor,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(7),
                              )
                            : BoxDecoration(
                                color: CustomColors.whiteColor,
                                border: Border.all(
                                  color: CustomColors.blackColor,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(7),
                              ),
                        child: Center(
                            child: Text(
                          "conditions d'utilisation",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: activeContainerIndex == 0
                                ? CustomColors.whiteColor
                                : CustomColors.blackColor,
                          ),
                        )),
                      ),
                    ),
                  ),
                  horizontalSpacer(10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          activeContainerIndex = 1;
                        });
                      },
                      child: Container(
                        height: 40,
                        decoration: activeContainerIndex == 1
                            ? BoxDecoration(
                                color: CustomColors.blackColor,
                                border: Border.all(
                                  color: CustomColors.blackColor,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(7),
                              )
                            : BoxDecoration(
                                color: CustomColors.whiteColor,
                                border: Border.all(
                                  color: CustomColors.blackColor,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(7),
                              ),
                        child: Center(
                            child: Text(
                          "politique confidentialité",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: activeContainerIndex == 1
                                ? CustomColors.whiteColor
                                : CustomColors.blackColor,
                          ),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpacer(20),
              Visibility(
                  visible: activeContainerIndex == 0,
                  child: const TermsAndConditionWidget()),
              Visibility(
                  visible: activeContainerIndex == 1,
                  child: const PrivacyPolicyWidget()),
            ],
          ),
        ),
      ),
    );
  }
}

class ArticleTitle extends StatelessWidget {
  final String title;
  const ArticleTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: CustomColors.blackColor,
                fontSize: 14,
                height: 1.7,
              ),
            ),
          ],
        ),
        verticalSpacer(8),
        Container(
          height: 3,
          width: double.infinity,
          decoration: const BoxDecoration(color: CustomColors.blackColor),
        ),
        verticalSpacer(8),
      ],
    );
  }
}

class PlainTextWidget extends StatelessWidget {
  final String title;
  final double fontSize;
  final double paddingTop;
  const PlainTextWidget({
    super.key,
    required this.title,
    this.fontSize = 12,
    this.paddingTop = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: CustomColors.blackColor,
          fontSize: fontSize,
          height: 1.7,
        ),
      ),
    );
  }
}
