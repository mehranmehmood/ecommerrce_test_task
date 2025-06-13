import 'package:ecommerce_task_test/firebase_options.dart';
import 'package:ecommerce_task_test/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

late Size mq;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: false);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      unknownRoute: AppRouter.getUnknownRoute(),
      initialRoute: AppRouter.getInitialRoute(),
      getPages: AppRouter.getPages(),
      builder: EasyLoading.init(),
    );
  }
}
