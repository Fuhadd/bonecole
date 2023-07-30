import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/custom_colors.dart';

class PDFViewerPage extends StatefulWidget {
  final File file;
  const PDFViewerPage({super.key, required this.file});

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: CustomColors.mainColor),
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: CustomColors.mainColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: SvgPicture.asset(
          "assets/icons/bonecole_icon.svg",
          height: 50,
        ),
      ),
      body: PDFView(
        filePath: widget.file.path,
      ),
    );
  }
}
