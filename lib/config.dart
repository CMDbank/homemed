import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final String baseUrl = "http://192.168.1.129:8000";

var Textstyle = GoogleFonts.notoSansThai(
    textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));

class textstyle extends StatelessWidget {
  final text;
  final fontSize;
  final fontWeight;
  final color;
  textstyle({this.text, required this.fontSize, this.fontWeight, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.notoSansThai(
          textStyle: TextStyle(
              fontSize: fontSize.toDouble(),
              fontWeight: fontWeight,
              color: color)),
    );
  }
}

class textstyle_eng extends StatelessWidget {
  final text;
  final double fontSize;
  final fontWeight;
  final color;
  textstyle_eng(
      {this.text, required this.fontSize, this.fontWeight, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.notoSans(
          textStyle: TextStyle(
              fontSize: fontSize.toDouble(),
              fontWeight: fontWeight,
              color: color)),
    );
  }
}
