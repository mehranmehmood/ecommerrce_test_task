import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_color.dart';
import '../page_detail/controller/product_detail_controller.dart';

class ResponsiveRatingBar extends StatelessWidget {
  final ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Set sizes based on screen width
    double starSize = screenWidth > 800 ? 20 : 13;
    double textSize = screenWidth > 800 ? 16 : 9;
    double spacing = screenWidth > 800 ? 10 : 5;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(
          () => RatingBar.builder(
            itemSize: starSize,
            initialRating: controller.rating.value,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) {
              controller.updateRating(rating);
            },
          ),
        ),
        SizedBox(width: spacing), // Proper horizontal space
        Text(
          '(121)', // You can make this dynamic if needed
          style: GoogleFonts.inter(
            fontSize: textSize,
            fontWeight: FontWeight.w400,
            color: AppColor.greyColor,
          ),
        ),
      ],
    );
  }
}
