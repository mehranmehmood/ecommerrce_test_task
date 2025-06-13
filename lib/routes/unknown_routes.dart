import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnknownRouteScreen extends StatelessWidget {
  const UnknownRouteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Unknown route',
          style: Get.textTheme.bodyLarge,
        ),
      ),
    );
  }
}
