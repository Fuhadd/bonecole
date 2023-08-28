import 'package:bonecole/screens/my_courses_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/course_model.dart';
import '../screens/homescreen.dart';
import '../screens/screens_view_model.dart';
import '../utils/custom_colors.dart';
import '../utils/spacers.dart';

class EndDrawer extends StatefulWidget {
  const EndDrawer({
    super.key,
  });

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          padding: const EdgeInsets.symmetric(horizontal: 65),
          margin: EdgeInsets.zero,
          // decoration: const BoxDecoration(
          //   color: Colors.blue,
          // ),
          child: SizedBox(
            // width: 100,
            // height: 100,
            child: SvgPicture.asset(
              "assets/icons/bonecole_icon.svg",
              color: Colors.white,
              // height: 20,
              // width: 100,
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 10.0),
        //   child: ListTile(
        //     title: const Text(
        //       'Home',
        //       style: TextStyle(
        //         fontSize: 24,
        //         fontWeight: FontWeight.w600,
        //         fontStyle: FontStyle.italic,
        //         color: Colors.white,
        //       ),
        //     ),
        //     onTap: () {
        //       Navigator.of(context).pushReplacement(
        //           MaterialPageRoute(builder: (context) => const HomeScreen()));
        //     },
        //   ),
        // ),

        SideMenus(
          title: "Home",
          icon: FontAwesomeIcons.house,
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
        // verticalSpacer(10),
        SideMenus(
          title: "My Courses",
          icon: FontAwesomeIcons.book,
          isLoading: isLoading,
          onTap: () async {
            setState(() {
              isLoading = true;
            });
            List<DownloadedCourseModel> curriculums =
                await ScreenViewModel().getAllDownloadedCurriculums();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyCoursesScreen(
                      curriculums: curriculums,
                    )));
            setState(() {
              isLoading = false;
            });
          },
        ),
        // verticalSpacer(10),
        const SideMenus(
          title: "My Profile",
          icon: FontAwesomeIcons.addressBook,
        ),
        // verticalSpacer(10),
        const SideMenus(
          title: "Chat",
          icon: FontAwesomeIcons.solidMessage,
        ),
        // verticalSpacer(10),
        const SideMenus(
          title: "Settings",
          icon: FontAwesomeIcons.gear,
        ),
        verticalSpacer(10),
      ],
    );
  }
}

class SideMenus extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  final bool isLoading;
  const SideMenus({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListTile(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: Colors.white,
            ),
            horizontalSpacer(20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
            isLoading
                ? Row(
                    children: [
                      horizontalSpacer(10),
                      const SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: CustomColors.whiteColor,
                        ),
                      )
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
