// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../page_detail/controller/product_detail_controller.dart';
//
// class QuantitySelector extends StatelessWidget {
//   final ProductController controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.remove_circle_outline),
//             onPressed: controller.decrement,
//           ),
//           Text(
//             controller.quantity.value.toString(),
//             style: TextStyle(fontSize: 18),
//           ),
//           IconButton(
//             icon: Icon(Icons.add_circle_outline),
//             onPressed: controller.increment,
//           ),
//         ],
//       );
//     });
//   }
// }
