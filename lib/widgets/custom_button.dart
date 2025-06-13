import 'package:flutter/material.dart';
import '../main.dart';
import 'app_text.dart';

class AppButton extends StatelessWidget {
  final String titleText;
  final VoidCallback? onPressed;
  final Color textColor;
  final Color buttonColor;
  final Color? borderColor;
  final double? fontSize;
  final double? borderRadius;
  final FontWeight? fontWeight;
  final double? buttonWidth;
  final bool showLoader;

  const AppButton({
    super.key,
    required this.titleText,
    required this.onPressed,
    required this.buttonColor,
    required this.textColor,
    this.borderColor,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    this.buttonWidth,
    this.showLoader = false,
  });

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: mq.width > 800 ? 18 : 14, // More padding for web
          horizontal: 20,
        ),
        width: buttonWidth ?? (mq.width > 800 ? mq.width * 0.3 : double.infinity),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'asset/image/ic_baskit_image.png',
                height: mq.width > 800 ? 28 : 22, // Responsive icon size
              ),
              const SizedBox(width: 10),
              AppTextWidget(
                text: titleText,
                fontSize: fontSize ?? (mq.width > 800 ? 20 : 16),
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor,
              ),
              if (showLoader) ...[
                const SizedBox(width: 10),
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}