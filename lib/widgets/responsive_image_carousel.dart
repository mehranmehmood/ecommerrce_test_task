import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_color.dart';
import '../page_detail/controller/product_detail_controller.dart';

class ResponsiveImageCarousel extends StatelessWidget {
  final ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWeb = screenWidth > 800;

    return Obx(() {
      if (controller.product.value == null) return CircularProgressIndicator();

      final image =
          controller.product.value!.images[controller.currentImageIndex.value];
      final isFavorite =
          controller.product.value!.favorites[controller
              .currentImageIndex
              .value];

      return Column(
        children: [
          isWeb
              ? _buildWebLayout(image, isFavorite)
              : _buildMobileLayout(image, isFavorite),
          SizedBox(height: 22),
          isWeb ? SizedBox(height: 108) : _buildIndicator(),
        ],
      );
    });
  }

  // Mobile Layout
  Widget _buildMobileLayout(String image, bool isFavorite) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.darkGreenColor),
          onPressed: controller.previousImage,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: AppColor.lightGreyColor),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Image.asset(image, height: 300, fit: BoxFit.contain),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : AppColor.darkGreenColor,
                    size: 30,
                  ),
                  onPressed: () {
                    controller.toggleFavoriteItem(
                      controller.currentImageIndex.value,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios, color: AppColor.darkGreenColor),
          onPressed: controller.nextImage,
        ),
      ],
    );
  }

  // Web Layout
  Widget _buildWebLayout(String image, bool isFavorite) {
    return Container(
      decoration: BoxDecoration(color: AppColor.lightGreyColor),
      height: 699,
      child: Stack(
        children: [
          Center(child: Image.asset(image, height: 450, fit: BoxFit.contain)),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColor.darkGreenColor,
                  size: 40,
                ),
                onPressed: controller.previousImage,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.darkGreenColor,
                  size: 40,
                ),
                onPressed: controller.nextImage,
              ),
            ),
          ),
          // Positioned(
          //   top: 10,
          //   right: 10,
          //   child: IconButton(
          //     icon: Icon(
          //       isFavorite ? Icons.favorite : Icons.favorite_border,
          //       color: isFavorite ? Colors.red : AppColor.darkGreenColor,
          //       size: 35,
          //     ),
          //     onPressed: () {
          //       controller.toggleFavorite(controller.currentImageIndex.value);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  // Image Indicator
  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        controller.product.value!.images.length,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color:
                controller.currentImageIndex.value == index
                    ? Colors.black
                    : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
