import 'package:ecommerce_task_test/constant/file_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant/app_color.dart';
import '../controller/auth_controller.dart';

class AuthScreen extends StatelessWidget {
   AuthScreen({super.key});
   final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double horizontalPadding = kIsWeb ? screenSize.width * 0.1 : 20.0;
    final double buttonWidth = kIsWeb
        ? screenSize.width * 0.4
        : screenSize.width * 0.8;
    final double maxButtonWidth = kIsWeb ? 400.0 : 300.0;
    final double fontSize = kIsWeb ? 18.0 : 17.5;

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: horizontalPadding,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: maxButtonWidth,
                  ),
                  child: Container(
                    height: 48,
                    width: buttonWidth,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: () {
                          authController.login();
                        },
                        borderRadius: BorderRadius.circular(8),
                        splashColor: AppColor.blackColor.withOpacity(0.1),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 10),
                              Image.asset(
                                FilePath.loginIcon,
                                height: 20, // Slightly larger for better visibility
                                width: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Sign in with Google",
                                style: GoogleFonts.poppins(
                                  color: AppColor.blackColor,
                                  fontSize: fontSize,
                                  letterSpacing: -0.41,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}