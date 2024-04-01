import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';

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
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
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
      ),
    );
  }
}

class PlainRowTextWidget extends StatelessWidget {
  final String title;
  final double fontSize;
  final double paddingTop;
  const PlainRowTextWidget({
    super.key,
    required this.title,
    this.fontSize = 12,
    this.paddingTop = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(top: paddingTop),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "○ ",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: CustomColors.blackColor,
                fontSize: fontSize,
                height: 1.7,
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: CustomColors.blackColor,
                  fontSize: fontSize,
                  height: 1.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
