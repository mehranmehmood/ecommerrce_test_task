import 'package:get/get.dart';

class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final List<String> images;
  final List<String> colors;
  late RxList<bool> favorites;
  late RxMap<int, int> quantities; // Key: image index, Value: quantity

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.colors,
  }) {
    favorites =
        List<bool>.filled(
          images.length,
          false,
        ).obs; // Initialize after images are available
    // Initialize quantities with each image starting at quantity 1
    quantities = <int, int>{}.obs;
    for (int i = 0; i < images.length; i++) {
      quantities[i] = 1;
    }
  }
}
