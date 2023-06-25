import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final Color color;
  final bool isLoading;

  const MyButton(
      {super.key,
      required this.onTap,
      this.color = Colors.black,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: const EdgeInsets.all(25),
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: CustomColors.whiteColor,
                )
              : const Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}
