import 'package:ecommerce_task_test/constant/file_path.dart';
import 'package:ecommerce_task_test/splash/controller/splash_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});
  final SplashController authController = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double logoSize = kIsWeb
        ? screenSize.width * 0.3
        : screenSize.width * 0.5;
    final double maxLogoSize = kIsWeb ? 300.0 : 200.0; // Max size cap for web and mobile

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxLogoSize,
              maxHeight: maxLogoSize,
            ),
            child: SvgPicture.asset(
              FilePath.appLogoForWeb,
              width: logoSize,
              height: logoSize,
              fit: BoxFit.contain, // Ensure SVG scales properly
            ),
          ),
        ),
      ),
    );
  }
}