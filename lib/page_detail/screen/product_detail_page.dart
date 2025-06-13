import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../auth/controller/auth_controller.dart';
import '../../constant/app_color.dart';
import '../../constant/file_path.dart';
import '../../widgets/color_sector.dart';
import '../../widgets/custom_app_bar_widget.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/item_quantity_widget.dart';
import '../../widgets/responsive_image_carousel.dart';
import '../../widgets/responsive_rating_bar.dart';
import '../../widgets/specification_and_detail_dropdown_widget.dart';
import '../controller/product_detail_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBarWidget(
        leadingWidth: 170,
        leading: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: InkWell(
            onTap: (){
            },
            child: SvgPicture.asset(
              FilePath.gameGeek,
              height: 40,
              width: 120,
              fit: BoxFit.contain,
            ),
          ),
        ),
        appIconWeb: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAppBarText("Categories"),
            _buildAppBarText("Brands"),
            _buildAppBarText("What’s New"),
            _buildAppBarText("Help"),
            _buildAppBarText("About"),
          ],
        ),
        appIconMobile: FilePath.appIon,
        actionsWeb: [
          SvgPicture.asset(FilePath.searchIcon, height: 18, width: 18),
          const SizedBox(width: 40),
          SvgPicture.asset(FilePath.personIcon, height: 18, width: 18),

          const SizedBox(width: 40),
          SvgPicture.asset(FilePath.emptyBasket, height: 18, width: 18),

          const SizedBox(width: 30),
        ],
        actionsMobile: [
          SvgPicture.asset(FilePath.searchIcon, height: 16, width: 16),
          const SizedBox(width: 24),
          SvgPicture.asset(FilePath.notificationIcon, height: 20, width: 20),
          const SizedBox(width: 24),

        ],
        menu: Padding(
          padding: const EdgeInsets.only(left: 23),
          child: SvgPicture.asset(
            FilePath.menuIcon,
            height: 14,
            width: 20,
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 40, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Products",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: null,
                                    style: GoogleFonts.readexPro(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.greyColor,
                                    ),
                                  ),
                                  Text(
                                    " / Gaming Headsets & Audio",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: null,
                                    style: GoogleFonts.readexPro(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.greyColor,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      " / Astro A50 X Wireless Headset",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: null,
                                      style: GoogleFonts.readexPro(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.blackColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ResponsiveImageCarousel(),
                              SizedBox(height: 22),
                              Center(
                                child: Image.asset(
                                  'asset/image/ic_earphone_two.png',
                                  height: 120,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24, top: 34),
                            child: buildDetailsForWeb(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 109),
                    Column(
                      children: [
                        DottedLine(
                          dashLength: 3.0,
                          dashGapLength: 3.0,
                          lineThickness: 1.5,
                          dashColor: AppColor.darkGreyColor,
                        ),
                        SizedBox(height: 12),
                        SpecificationAndDetailDropdownWidget(),
                        SizedBox(height: 12),
                        DottedLine(
                          dashLength: 3.0,
                          dashGapLength: 3.0,
                          lineThickness: 1.5,
                          dashColor: AppColor.darkGreyColor,
                        ),
                        SizedBox(height: 44),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 33,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: buildDetailsForMobile(),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.productList.length,
                    itemBuilder: (context, index) {
                      final fruit = controller.productList[index];
                      return ListTile(
                        leading: Image.asset(
                          fruit.image,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                        title: Text(fruit.title),
                        subtitle: Text('\$${fruit.price}'),
                      );
                    },
                    separatorBuilder:
                        (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                            height: 1,
                          ),
                        ),
                  ),
                  SizedBox(height: 46),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        DottedLine(
                          dashLength: 3.0,
                          dashGapLength: 3.0,
                          lineThickness: 1.5,
                          dashColor: AppColor.darkGreyColor,
                        ),
                        SizedBox(height: 12),
                        SpecificationAndDetailDropdownWidget(),
                        SizedBox(height: 12),
                        DottedLine(
                          dashLength: 3.0,
                          dashGapLength: 3.0,
                          lineThickness: 1.5,
                          dashColor: AppColor.darkGreyColor,
                        ),
                        SizedBox(height: 44),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildDetailsForWeb() {
    return Obx(() {
      final product = controller.product.value;
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.title,
              style: GoogleFonts.hammersmithOne(
                fontSize: 48,
                fontWeight: FontWeight.w400,
                color: AppColor.darkPurple,
              ),
            ),
            SizedBox(height: 16),
            Text(
              product.description,
              style: GoogleFonts.readexPro(
                color: AppColor.darkPurple,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            ResponsiveRatingBar(),
            SizedBox(height: 28),
            DottedLine(
              dashLength: 3.0,
              dashGapLength: 3.0,
              lineThickness: 1.5,
              dashColor: AppColor.darkGreyColor,
            ),
            SizedBox(height: 30),

            Text(
              '\$${product.price}.00',
              style: GoogleFonts.readexPro(
                fontSize: 36,
                color: AppColor.darkGreenColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Suggested payments with 6 month special financing",
              style: GoogleFonts.readexPro(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColor.darkGreenColor,
              ),
            ),

            SizedBox(height: 28),
            DottedLine(
              dashLength: 3.0,
              dashGapLength: 3.0,
              lineThickness: 1.5,
              dashColor: AppColor.darkGreyColor,
            ),
            SizedBox(height: 28),
            Text(
              'Choose a color',
              style: GoogleFonts.readexPro(
                fontSize: 24,
                color: Color(0xff0E020C),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 28),
            ColorSelector(),
            SizedBox(height: 37),
            DottedLine(
              dashLength: 3.0,
              dashGapLength: 3.0,
              lineThickness: 1.5,
              dashColor: AppColor.darkGreyColor,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ItemQuantityWidget(),
                SizedBox(width: 62),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Only ',
                          style: GoogleFonts.readexPro(
                            fontSize: 18,
                            color: AppColor.greyColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: '16 items ',
                          style: GoogleFonts.readexPro(
                            fontSize: 18,
                            color: AppColor.greenColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: 'left! Don’t miss it',
                          style: GoogleFonts.readexPro(
                            fontSize: 18,
                            color: AppColor.greyColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                SizedBox(width: 62),
              ],
            ),
            SizedBox(height: 56),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: AppButton(
                    titleText: 'Add to Card',
                    buttonColor: AppColor.greenColor,
                    textColor: AppColor.whiteColor,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 17),
                // Obx(
                //   () => Container(
                //     padding: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                //     decoration: BoxDecoration(
                //       border: Border.all(color: Color(0xff0D2612), width: 3),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: IconButton(
                //       icon: Icon(
                //         controller.product.value.favorites[controller
                //                 .currentImageIndex
                //                 .value]
                //             ? Icons.favorite
                //             : Icons.favorite_border,
                //         color:
                //             controller.product.value.favorites[controller
                //                     .currentImageIndex
                //                     .value]
                //                 ? Colors.red
                //                 : AppColor.darkGreenColor,
                //         size: 30,
                //       ),
                //       onPressed:
                //           () => controller.toggleFavorite(
                //             controller.currentImageIndex.value,
                //           ),
                //     ),
                //   ),
                // ),
                Obx(
                      () => Container(
                    padding: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff0D2612), width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(
                        controller.product.value?.favorites[controller.currentImageIndex.value] == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: controller.product.value?.favorites[controller.currentImageIndex.value] == true
                            ? Colors.red
                            : AppColor.darkGreenColor,
                        size: 30,
                      ),
                      onPressed: () {
                        controller.toggleFavoriteItem(controller.currentImageIndex.value);
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 56),
            Center(
              child: DottedBorder(
                options: RectDottedBorderOptions(
                  color: AppColor.darkGreyColor,
                  strokeWidth: 3,
                  dashPattern: [4, 4],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .center, // ✅ Center image with text block
                        children: [
                          Image.asset(
                            "asset/image/ic_school_bus.png",
                            height: 25,
                            width: 25,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .center, // ✅ Center texts inside column
                              children: [
                                Text(
                                  'Your Text Here',
                                  style: GoogleFonts.readexPro(
                                    fontSize: 18,
                                    color: Color(0xff0D2612),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Enter your Postal Code for Delivery Availability',
                                  style: GoogleFonts.readexPro(
                                    fontSize: 18,
                                    color: Color(0xff0D2612),
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      DottedLine(
                        dashLength: 4.0,
                        dashGapLength: 4.0,
                        lineThickness: 3.0,
                        dashColor: Color(0xff6A6969),
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "asset/image/ic_bastik_one.png",
                            height: 25,
                            width: 25,
                          ),
                          SizedBox(width: 16), // Reduced spacing
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Return Delivery',
                                  style: GoogleFonts.readexPro(
                                    fontSize: 18,
                                    color: Color(0xff0D2612),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Free delivery 30 Days return',
                                  style: GoogleFonts.readexPro(
                                    fontSize: 18,
                                    color: Color(0xff0D2612),
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buildDetailsForMobile() {
    return Obx(() {
      final product = controller.product.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Products",
                overflow: TextOverflow.ellipsis,
                maxLines: null,
                style: GoogleFonts.readexPro(
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                  color: AppColor.greyColor,
                ),
              ),
              Text(
                " / Gaming Headsets & Audio",
                overflow: TextOverflow.ellipsis,
                maxLines: null,
                style: GoogleFonts.readexPro(
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                  color: AppColor.greyColor,
                ),
              ),
              Expanded(
                child: Text(
                  " / Astro A50 X Wireless Headset",
                  overflow: TextOverflow.ellipsis,
                  maxLines: null,
                  style: GoogleFonts.readexPro(
                    fontSize: 9,
                    fontWeight: FontWeight.w400,
                    color: AppColor.blackColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 22),

          Container(
            padding: EdgeInsets.only(top: 4, bottom: 3, left: 7, right: 6),
            decoration: BoxDecoration(
              color: AppColor.darkGreenColor,
             // borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              "Astro series",
              overflow: TextOverflow.ellipsis,
              maxLines: null,
              style: GoogleFonts.readexPro(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: AppColor.whiteColor,
              ),
            ),
          ),
          SizedBox(height: 8),

          Text(
            product.title,
            style: GoogleFonts.hammersmithOne(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColor.darkPurple,
            ),
          ),
          SizedBox(height: 8),
          Text(
            product.description,
            style: GoogleFonts.readexPro(
              color: AppColor.darkPurple,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          ResponsiveRatingBar(),
          SizedBox(height: 10),
          DottedLine(
            dashLength: 3.0,
            dashGapLength: 3.0,
            lineThickness: 1.5,
            dashColor: AppColor.darkGreyColor,
          ),
          SizedBox(height: 15),

          Text(
            '\$${product.price}',
            style: GoogleFonts.readexPro(
              fontSize: 13,
              color: AppColor.darkGreenColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Suggested payments with 6 month special financing",
            style: GoogleFonts.readexPro(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: AppColor.darkGreenColor,
            ),
          ),
          SizedBox(height: 35),
          ResponsiveImageCarousel(),
          SizedBox(height: 8),
          ColorSelector(),
          SizedBox(height: 4),
          Text(
            'Black',
            style: GoogleFonts.readexPro(
              fontWeight: FontWeight.w300,
              fontSize: 13,
              color: AppColor.blackColor,
            ),
          ),
          // SizedBox(height: 16),
          // QuantitySelector(),
          SizedBox(height: 16),
          Center(
            child: Text(
              "In stock. Ready for shipping.",
              style: GoogleFonts.readexPro(
                fontWeight: FontWeight.w500,
                fontSize: 9,
                color: AppColor.greenColor,
              ),
            ),
          ),
          SizedBox(height: 8),
          AppButton(
            titleText: 'Add to Card',
            buttonColor: AppColor.greenColor,
            textColor: AppColor.whiteColor,
            onPressed: () {},
          ),
          SizedBox(height: 23),
          Row(
            children: [
              SvgPicture.asset(FilePath.shipmentImage, height: 13, width: 18),
              SizedBox(width: 8),
              Text(
                "In stock. Ready for shipping.",
                style: GoogleFonts.readexPro(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColor.blackColor,
                ),
              ),
              SizedBox(width: 4),

              SvgPicture.asset(FilePath.questionMark, height: 11, width: 11),
            ],
          ),
          SizedBox(height: 16),
          Text(
            "Made to play with the innovative PLAYSYNC. Connect Xbox + PS5 + PC/mac at the same time and play on all 3 systems. PRO-G GRAPHENE audio transducers achieve unprecedented clarity and response. LIGHTSPEED enables the highest levels of wireless audio performance.",
            // overflow: TextOverflow.ellipsis,
            maxLines: null,
            style: GoogleFonts.readexPro(
              fontWeight: FontWeight.w500,
              fontSize: 9,
              color: AppColor.greenColor,
            ),
          ),
          SizedBox(height: 28),
          Row(
            children: [
              SvgPicture.asset(FilePath.labelIcon, height: 30, width: 30),
              SizedBox(width: 8),
              Text(
                "Free express shipping",
                style: GoogleFonts.readexPro(
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                  color: AppColor.blackColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 25),

          Text(
            "Items we suggest",
            style: GoogleFonts.readexPro(
              fontWeight: FontWeight.w600,
              fontSize: 11,
              color: AppColor.blackColor,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildAppBarText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColor.darkGreenColor,
        ),
      ),
    );
  }
}
