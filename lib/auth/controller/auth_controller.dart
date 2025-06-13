import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import '../../routes/routes.dart';


class AuthController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  late GoogleSignIn googleSignIn;

  @override
  void onInit() {
    googleSignIn = GoogleSignIn();
    super.onInit();
  }

  @override
  void onReady() {
    checkLoginStatus();
    super.onReady();
  }

  void checkLoginStatus() {
    User? user = firebaseAuth.currentUser;
    String? currentRoute = Get.currentRoute;

    if (user != null && currentRoute != RouteName.productDetailPage) {
      Get.offAllNamed(RouteName.productDetailPage);
    } else if (user == null && currentRoute != RouteName.authScreen) {
      Get.offAllNamed(RouteName.authScreen);
    }
  }

  login() async {
    EasyLoading.show(status: "Logging in...", maskType: EasyLoadingMaskType.clear);

    try {
      if (kIsWeb) {
        // Web Login
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        final UserCredential userCredential = await firebaseAuth.signInWithPopup(googleProvider);
        var user = userCredential.user;

        if (user != null) {
          print("✅ Web User Logged In: ${user.email}");
          EasyLoading.dismiss();
          Get.offAllNamed(RouteName.productDetailPage);
        }
      } else {
        // Mobile Login
        GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

        if (googleSignInAccount == null) {
          EasyLoading.dismiss();
          return;
        }

        GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await firebaseAuth.signInWithCredential(oAuthCredential);
        var user = firebaseAuth.currentUser;

        if (user != null) {
          await user.reload();
          user = firebaseAuth.currentUser;

          print("✅ Mobile User Logged In: ${user?.email}");
          EasyLoading.dismiss();
          Get.offAllNamed(RouteName.productDetailPage);
        }
      }
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      handleAuthException(e);
    } catch (e) {
      EasyLoading.dismiss();
      print("❌ General Error during login: $e");
      Get.snackbar(
        "Error",
        "An unexpected error occurred. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void handleAuthException(FirebaseAuthException e) async {
    if (Get.isSnackbarOpen) Get.closeAllSnackbars();

    if (e.code == 'user-disabled') {
      print("⚠️ User account is disabled. Logging out...");
      await firebaseAuth.signOut();
      await googleSignIn.signOut();

      Get.snackbar(
        "Error",
        "Your account has been disabled by admin",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      print("❌ FirebaseAuthException: ${e.code}");
      Get.snackbar(
        "Error",
        "FirebaseAuthException: ${e.code}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void logout() async {
    try {
      await firebaseAuth.signOut();
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }

      print("✅ User successfully logged out.");
      Get.offAllNamed(RouteName.authScreen);
    } catch (e) {
      print("❌ Error during logout: $e");
      Get.snackbar(
        "Error",
        "An error occurred while logging out. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

// class AuthController extends GetxController {
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//
//   late GoogleSignIn googleSignIn;
//   final GoogleSignIn googleSignInOne = GoogleSignIn(
//     clientId: kIsWeb ? "641197976047-ravg9eecsens4tq4tteeqpmgfdu1s9r0.apps.googleusercontent.com" : null,
//   );
//
//   @override
//   void onInit() {
//     googleSignIn = GoogleSignIn();
//     super.onInit();
//   }
//
//   @override
//   void onReady() {
//     checkLoginStatus(); // Check login on app start
//     super.onReady();
//   }
//
//   /// Check if user is already logged in
//   void checkLoginStatus() {
//     User? user = firebaseAuth.currentUser;
//     // Get the current route
//     String? currentRoute = Get.currentRoute;
//
//     if (user != null && currentRoute != RouteName.productDetailPage) {
//       // User is logged in and not already on product detail page
//       Get.offAllNamed(RouteName.productDetailPage);
//     } else if (user == null && currentRoute != RouteName.authScreen) {
//       // User is not logged in and not already on auth screen
//       Get.offAllNamed(RouteName.authScreen);
//     }
//     // If the current route is correct, do nothing to avoid redundant navigation
//   }
//
//   login() async {
//     GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//     EasyLoading.show(status: "Login...", maskType: EasyLoadingMaskType.clear);
//     if (googleSignInAccount == null) {
//       return;
//     }
//
//     try {
//       GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;
//       OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );
//
//       await firebaseAuth.signInWithCredential(oAuthCredential);
//       var user = firebaseAuth.currentUser;
//
//       if (user != null) {
//         await user.reload();
//         user = firebaseAuth.currentUser;
//
//         print("✅ User Logged In: ${user?.email}");
//         EasyLoading.dismiss();
//
//         Get.offAllNamed(RouteName.productDetailPage);
//       }
//     } on FirebaseAuthException catch (e) {
//       EasyLoading.dismiss();
//       handleAuthException(e);
//     } catch (e) {
//       EasyLoading.dismiss();
//       print("❌ General Error during login: $e");
//       Get.snackbar(
//         "Error",
//         "An unexpected error occurred. Please try again.",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   void handleAuthException(FirebaseAuthException e) async {
//     if (Get.isSnackbarOpen) Get.closeAllSnackbars();
//
//     if (e.code == 'user-disabled') {
//       print("⚠️ User account is disabled. Logging out...");
//       await firebaseAuth.signOut();
//       await googleSignIn.signOut();
//
//       Get.snackbar(
//         "Error",
//         "Your account has been disabled by admin",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } else {
//       print("❌ FirebaseAuthException: ${e.code}");
//       Get.snackbar(
//         "Error",
//         "FirebaseAuthException: ${e.code}",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   void logout() async {
//     try {
//       await firebaseAuth.signOut();
//       await googleSignIn.signOut();
//
//       print("✅ User successfully logged out.");
//       Get.offAllNamed(RouteName.authScreen);
//     } catch (e) {
//       print("❌ Error during logout: $e");
//       Get.snackbar(
//         "Error",
//         "An error occurred while logging out. Please try again.",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
// }
