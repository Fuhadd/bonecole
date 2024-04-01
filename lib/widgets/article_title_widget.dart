import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';
import '../utils/spacers.dart';

class ArticleTitle extends StatelessWidget {
  final String title;
  final Widget? child;
  const ArticleTitle({
    super.key,
    required this.title,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        child ??
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
