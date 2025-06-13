import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    navigateToNext();
  }

  void navigateToNext() async {
    // Wait for 3 seconds
    await Future.delayed(Duration(seconds: 3));

    // Check if the user is logged in
    if (_auth.currentUser != null) {
      Get.offAllNamed(RouteName.productDetailPage);
    } else {
      Get.offAllNamed(RouteName.authScreen);
    }
  }
}
