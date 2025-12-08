import 'dart:io';
import 'package:get/get.dart';

class CartItem {
  final String image;
  final String name;
  final String model;
  final double price;
  RxInt quantity;

  CartItem({
    required this.image,
    required this.name,
    required this.model,
    required this.price,
    required int qty,
  }) : quantity = qty.obs;
}

class CartController extends GetxController {
  var cartItems = <CartItem>[
    CartItem(
      image: "assets/images/med1.png",
      name: "Digital Thermometer",
      model: "Model A9",
      price: 299.00,
      qty: 1,
    ),
    CartItem(
      image: "assets/images/med2.png",
      name: "BP Monitor",
      model: "BP-02 Pro",
      price: 1499.00,
      qty: 2,
    ),
  ].obs;

  void increaseQty(int index) {
    cartItems[index].quantity++;
    update();
  }

  void decreaseQty(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      update();
    }
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
    update();
  }

  double get totalAmount {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.quantity.value;
    }
    return total;
  }

  double get shipping => 50;
  double get discount => 6;
  double get grandTotal => totalAmount + shipping - discount;

  // Payment selection
  final RxString selectedPayment = "COD".obs;

  // Dummy Address
  final RxString address = "45, Green Park Colony, Mumbai - 400001".obs;

  // Upload Prescription
  final Rx<File?> prescriptionImage = Rx<File?>(null);

  void changeAddress(String newAddress) {
    address.value = newAddress;
  }

  void selectPayment(String payment) {
    selectedPayment.value = payment;
  }

  void setPrescriptionImage(File? image) {
    prescriptionImage.value = image;
  }

  void placeOrder() {
    // Logic to place order, e.g., clear cart
    cartItems.clear();
    update();
  }
}
