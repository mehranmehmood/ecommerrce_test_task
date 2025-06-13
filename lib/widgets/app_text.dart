import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../constant/app_font.dart';

class AppTextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final Color? decorationColor;
  final TextAlign? textAlign;
  final double? wordSpacing;
  final FontStyle? fontStyle;

  const AppTextWidget({
    super.key,
    required this.text,
    this.wordSpacing,
    required this.color,
    required this.fontSize,
    this.fontWeight,
    this.decorationColor,
    this.textDecoration,
    this.textAlign,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      softWrap: true,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: AppFont.poppinsFont,
        color: color,
        wordSpacing: wordSpacing,
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        decoration: textDecoration,
        decorationColor: decorationColor,
      ),
    );
  }
}
