import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../auth/controller/auth_controller.dart';
import '../constant/app_color.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final AuthController authController = Get.put(AuthController());

  CustomAppBarWidget({
    super.key,
    required this.actionsWeb,
    required this.menu,
    required this.actionsMobile,
    required this.leading,
    required this.appIconWeb, // Widget for Web
    required this.appIconMobile, // String (SVG path) for Mobile
    this.leadingWidth = 120,
    this.leadingWidthMobile = 45,
  });

  final Widget? leading;
  final Widget? menu;
  final Widget? appIconWeb; // Web Title/Menu
  final String? appIconMobile; // Mobile Center Logo (SVG Path)
  final List<Widget>? actionsWeb;
  final List<Widget>? actionsMobile;
  final double leadingWidth;
  final double leadingWidthMobile;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWeb = screenWidth >= 1024;

    return AppBar(
      backgroundColor: AppColor.whiteColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leadingWidth: isWeb ? leadingWidth : leadingWidthMobile,
      leading: isWeb ? leading : menu,
      centerTitle: true,
      title: isWeb ? appIconWeb : _buildMobileLogo(),
      actions: isWeb ? actionsWeb : actionsMobile,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: Colors.grey[100], height: 1),
      ),
    );
  }

  /// Mobile Center Logo
  Widget _buildMobileLogo() {
    return InkWell(
      onTap: (){
        authController.logout();
      },
      child: SvgPicture.asset(
        appIconMobile ?? '',
        height: 16,
        width: 47,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
