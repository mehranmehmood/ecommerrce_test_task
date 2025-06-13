import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_color.dart';
import '../page_detail/controller/product_detail_controller.dart';

class SpecificationAndDetailDropdownWidget extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 800) {
          return Obx(
            () => DropdownButtonFormField<String>(
              value: controller.selectedDetail.value,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
              isDense: false, // Ensures the button can expand
              iconEnabledColor: AppColor.greenColor,
              iconDisabledColor: AppColor.greenColor,
              iconSize: 30,

              items:
                  controller.fruits
                      .map(
                        (fruit) => DropdownMenuItem(
                          value: fruit,
                          child: Text(
                            fruit,
                            style: GoogleFonts.readexPro(
                              fontSize: 24,
                              color: AppColor.darkGreenColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.updateSelectedProduct(value);
                }
              },
            ),
          );
        } else {
          return Obx(
            () => DropdownButtonFormField<String>(
              value: controller.selectedDetail.value,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
              isDense: false,
              iconEnabledColor: AppColor.greenColor,
              iconDisabledColor: AppColor.greenColor,
              iconSize: 16,
              items:
                  controller.fruits
                      .map(
                        (fruit) => DropdownMenuItem(
                          value: fruit,
                          child: Text(
                            fruit,
                            style: GoogleFonts.readexPro(
                              fontSize: 13,
                              color: AppColor.darkGreenColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.updateSelectedProduct(value);
                }
              },
            ),
          );
        }
      },
    );
  }
}
