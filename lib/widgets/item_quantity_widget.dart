import 'package:ecommerce_task_test/constant/file_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_color.dart';
import '../page_detail/controller/product_detail_controller.dart';

class ItemQuantityWidget extends StatelessWidget {
  final ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppColor.greenColor, width: 3),
        color: AppColor.halfWhite,
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Decrement Button
          InkWell(
            onTap: () => controller.decrementQuantityItem(
              controller.currentImageIndex.value,
            ),
            child: SvgPicture.asset(FilePath.subtractIcon),
          ),
          SizedBox(width: 37),

          // Fixed width for quantity text to prevent shifting
          Obx(
                () => SizedBox(
              width: 30, // Fixed width for quantity space
              child: Center(
                child: Text(
                  controller
                      .product
                      .value
                      .quantities[controller.currentImageIndex.value]
                      ?.toString() ??
                      '1',
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: AppColor.darkGreenColor,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 30),

          // Increment Button
          InkWell(
            onTap: () => controller.incrementQuantityItem(
              controller.currentImageIndex.value,
            ),
            child: SvgPicture.asset(FilePath.addIcon),
          ),
        ],
      ),
    );
  }
}
