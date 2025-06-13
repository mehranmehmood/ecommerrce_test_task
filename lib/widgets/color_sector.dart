import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../page_detail/controller/product_detail_controller.dart';

class ColorSelector extends StatelessWidget {
  final ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // Set sizes based on device
    double itemSize = screenWidth > 800 ? 66 : 16;
    double marginRight = screenWidth > 800 ? 31 : 8;

    return Obx(() {
      return Row(
        children: List.generate(controller.product.value.colors.length, (
          index,
        ) {
          bool isSelected = controller.selectedColorIndex.value == index;
          return GestureDetector(
            onTap: () => controller.selectColor(index),
            child: Container(
              margin: EdgeInsets.only(right: marginRight),
              width: itemSize,
              height: itemSize,
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.white,
                border: Border.all(color: Colors.black),
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      );
    });
  }
}
