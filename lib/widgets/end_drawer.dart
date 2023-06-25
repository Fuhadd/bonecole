import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/homescreen.dart';
import '../screens/tous_page.dart';
import '../utils/spacers.dart';

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
          child: SvgPicture.asset(
            "assets/icons/bonecole_icon.svg",
            height: 40,
          ),
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
