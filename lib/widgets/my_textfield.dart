import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../utils/custom_colors.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }
}

Widget customTextField(String name,
    {required String hintText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Widget? prefix,
    String? initialValue,
    bool isHint = false,
    bool obscureText = false,
    String? helperText,
    String? Function(String?)? validator,
    void Function()? onSuffixTap,
    void Function(String?)? onChanged}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: FormBuilderTextField(
      initialValue: initialValue,
      // cursorColor: CustomColors.,
      name: name,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          suffixIcon: GestureDetector(
            onTap: onSuffixTap,
            child: Icon(
              suffixIcon,
              size: 16,
              color: CustomColors.blackIconColor,
            ),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500])),
    ),
  );
}

Widget customMultiTextField(String name,
    {required String hintText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Widget? prefix,
    String? initialValue,
    bool isHint = false,
    bool obscureText = false,
    String? helperText,
    String? Function(String?)? validator,
    void Function()? onSuffixTap,
    void Function(String?)? onChanged}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0.0),
    child: FormBuilderTextField(
      initialValue: initialValue,
      // cursorColor: CustomColors.,
      maxLines: 4,
      name: name,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        contentPadding: EdgeInsets.all(10.0),
      ),
    ),
  );
}
