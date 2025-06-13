import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../constant/file_path.dart';
import '../model/product_model.dart';
import '../model/suggest_item_model.dart';

class ProductController extends GetxController {
  var productList = <SuggestItemModel>[].obs;
  var selectedDetail = 'Specification and details'.obs;
  var selectedColorIndex = 0.obs;
  var quantity = 1.obs;
  var currentImageIndex = 0.obs;
  var rating = 1.0.obs; // Default to 1 star
  var itemQuantity = 1.obs;
  final fruits = [
    'Specification and details',
    'Specification and details 1',
    'Specification and details 2',
  ];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  void onInit() {
    super.onInit();
    loadProduct();
    loadFavorites();
    loadQuantities();

    print("shujja");
  }

  var product =
      ProductModel(
        id: '1',
        title: 'ASTRO A50 X',
        description: 'LIGHTSPEED Wireless Gaming Headset + Base Station',
        price: 99.00,
        images: [
          'asset/image/ic_headphone.png',
          'asset/image/ic_headphone.png',
          'asset/image/ic_headphone.png',
        ],
        colors: ['Black', 'White'],
      ).obs;

  void previousImage() {
    if (currentImageIndex.value > 0) {
      currentImageIndex.value--;
    }
  }

  void nextImage() {
    if (currentImageIndex.value < product.value.images.length - 1) {
      currentImageIndex.value++;
    }
  }
  void loadQuantities() async {
    String productId = product.value.id;

    DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();

    if (userDoc.exists) {
      Map<String, dynamic>? quantitiesMap = (userDoc.data() as Map<String, dynamic>?)?['quantities'];

      if (quantitiesMap != null) {
        for (int i = 0; i < product.value.images.length; i++) {
          String key = '$productId-$i';
          if (quantitiesMap.containsKey(key)) {
            product.value.quantities[i] = quantitiesMap[key];
          }
        }
        product.refresh();
      }
    }
  }
  void incrementQuantityItem(int index) async {
    String productId = product.value.id;
    product.value.quantities[index] = (product.value.quantities[index] ?? 1) + 1;
    product.refresh();

    await _firestore.collection('users').doc(userId).set({
      'quantities': {
        '$productId-$index': product.value.quantities[index],
      }
    }, SetOptions(merge: true));
  }

  void decrementQuantityItem(int index) async {
    String productId = product.value.id;
    int currentQuantity = product.value.quantities[index] ?? 1;

    if (currentQuantity > 1) {
      product.value.quantities[index] = currentQuantity - 1;
      product.refresh();

      await _firestore.collection('users').doc(userId).set({
        'quantities': {
          '$productId-$index': product.value.quantities[index],
        }
      }, SetOptions(merge: true));
    } else {
      Get.snackbar('Error', 'Minimum quantity is 1');
    }
  }
  void toggleFavorite(int index) async {
    if (product.value == null) return;

    product.value!.favorites[index] = !product.value!.favorites[index];
    product.refresh(); // Update UI immediately

    try {
      await _firestore.collection('products').doc(product.value!.id).set({
        'favorites': product.value!.favorites,
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error updating favorites: $e');
      Get.snackbar('Error', 'Failed to update favorite');
    }
  }
  // void toggleFavorite(int index) {
  //   product.value.favorites[index] = !product.value.favorites[index];
  //   product.refresh(); // Force UI update
  // }

  // void increment() {
  //   quantity.value++;
  // }
  //
  // void decrement() {
  //   if (quantity.value > 1) {
  //     quantity.value--;
  //   } else {
  //     Get.snackbar('Error', 'Minimum quantity is 1');
  //   }
  // }

  void selectColor(int index) {
    selectedColorIndex.value = index;
  }

  void addProduct(SuggestItemModel fruit) {
    productList.add(fruit);
  }

  void removeProduct(int id) {
    productList.removeWhere((fruit) => fruit.id == id);
  }

  void updateSelectedProduct(String value) {
    selectedDetail.value = value;
  }

  void updateRating(double newRating) {
    rating.value = newRating;
  }

  void incrementDigit() {
    itemQuantity.value++;
  }

  void decrementDigit() {
    if (quantity.value > 0) {
      itemQuantity.value--;
    }
  }

  void loadProduct() {
    productList.value = [
      SuggestItemModel(
        id: "2",
        price: "\$ 98.00",
        title: 'G502 X PLUS GAMING MOUSE',
        image: FilePath.earPhone,
      ),
      SuggestItemModel(
        id: "2",
        price: "\$ 98.00",
        title: 'G502 X PLUS GAMING MOUSE',
        image: FilePath.earPhone,
      ),
    ];
  }

  void toggleFavoriteItem(int index) async {
    String productId = product.value.id;
    bool isCurrentlyFavorite = product.value.favorites[index];
    bool newStatus = !isCurrentlyFavorite;

    // Update local state
    product.value.favorites[index] = newStatus;
    product.refresh();

    // Update Firestore
    await _firestore.collection('users').doc(userId).set({
      'favorites': {'$productId-$index': newStatus},
    }, SetOptions(merge: true));
  }

  void loadFavorites() async {
    String productId = product.value.id;

    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(userId).get();

    if (userDoc.exists) {
      Map<String, dynamic>? favoritesMap =
          (userDoc.data() as Map<String, dynamic>?)?['favorites'];

      if (favoritesMap != null) {
        for (int i = 0; i < product.value.favorites.length; i++) {
          String key = '$productId-$i';
          if (favoritesMap.containsKey(key)) {
            product.value.favorites[i] = favoritesMap[key];
          }
        }
        product.refresh();
      }
    }
  }
}
