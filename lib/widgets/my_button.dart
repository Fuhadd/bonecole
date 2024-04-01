import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final Color color;
  final bool isLoading;
  final String title;
  final double? width, height, fontSize;
  final Color textColor;

  const MyButton({
    super.key,
    required this.onTap,
    this.color = Colors.black,
    required this.title,
    this.isLoading = false,
    this.width,
    this.height = 55,
    this.fontSize = 16,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: const EdgeInsets.all(25),
        height: height,
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 5, // Spread radius
              blurRadius: 7, // Blur radius
              offset: const Offset(0, 3), // Offset
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: CustomColors.whiteColor,
                )
              : Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
        ),
      ),
    );
  }
}


// class MyButton extends StatelessWidget {
//   final Function()? onTap;
//   final Color color;
//   final bool isLoading;
//   final String title;

//   const MyButton(
//       {super.key,
//       required this.onTap,
//       this.color = Colors.black,
//       required this.title,
//       this.isLoading = false});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         // padding: const EdgeInsets.all(25),
//         height: 60,
//         margin: const EdgeInsets.symmetric(horizontal: 25),
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Center(
//           child: isLoading
//               ? const CircularProgressIndicator(
//                   color: CustomColors.whiteColor,
//                 )
//               : Text(
//                   title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }
