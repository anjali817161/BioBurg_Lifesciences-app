import 'dart:io';
import 'package:bioburg_lifescience/modules/cart/controller/cart_controller.dart';
import 'package:bioburg_lifescience/modules/navbar/view/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CheckoutPage extends StatefulWidget {
  @override
  State createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State {
  final CartController cartController = Get.find();
  
  // Payment selection
  final RxString selectedPayment = "COD".obs;
  
  // Multiple Addresses
  final RxList<Map<String, String>> addresses = RxList([
    {
      "id": "1",
      "name": "John Doe",
      "address": "45, Green Park Colony, Mumbai - 400001",
      "phone": "+91 9876543210"
    },
    {
      "id": "2",
      "name": "John Doe",
      "address": "Apt 202, Sunshine Tower, Bangalore - 560034",
      "phone": "+91 9876543211"
    }
  ]);
  
  // Selected Address
  final RxString selectedAddressId = RxString("1");
  
  // Upload Prescription
  final Rx prescriptionImage = Rx(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade300,
                Colors.blue.shade200,
                Colors.white.withOpacity(0.3),
              ],
              stops: const [0.0, 0.6, 1.0],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child:  GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
            ),
            title: Row(
              children: [
                Text(
                  "Checkout",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: 1.2,
                    color: Colors.blue.shade800,
                  ),
                ),
               
              ],
            ),
            
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              _sectionTitle("Shipping Address"),
              _addressSelector(),
              const SizedBox(height: 20),
              _sectionTitle("Payment Method"),
              _paymentOptions(),
              const SizedBox(height: 20),
              _sectionTitle("Upload Prescription"),
              _prescriptionUpload(),
              const SizedBox(height: 20),
              _sectionTitle("Order Summary"),
              _orderSummary(),
              const SizedBox(height: 20),
              _placeOrderButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
    );
  }

  // ========== ADDRESS SELECTOR WITH RADIO BUTTONS ==========
  Widget _addressSelector() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(15),
        decoration: _boxStyle(),
        child: Column(
          children: [
            ...addresses.map((addr) {
              return Column(
                children: [
                  RadioListTile(
                    value: addr["id"]!,
                    groupValue: selectedAddressId.value,
                    onChanged: (value) {
                      selectedAddressId.value = value!;
                    },
                    activeColor: const Color(0xff0A6CF0),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          addr["name"]!,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          addr["address"]!,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Phone: ${addr["phone"]!}",
                          style: const TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                    secondary: GestureDetector(
                      onTap: () => _editAddressSheet(addr["id"]!),
                      child: const Icon(Icons.edit,
                          color: Color(0xff0A6CF0), size: 20),
                    ),
                  ),
                  const Divider(),
                ],
              );
            }).toList(),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _addNewAddressSheet,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff0A6CF0), width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add, color: Color(0xff0A6CF0)),
                      SizedBox(width: 8),
                      Text(
                        "Add New Address",
                        style: TextStyle(
                            color: Color(0xff0A6CF0),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ========== ADD NEW ADDRESS ==========
  void _addNewAddressSheet() {
    TextEditingController nameController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    showModalBottomSheet(
      context: Get.context!,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 20,
              right: 20,
              top: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Add New Address",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: addressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Address",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          addressController.text.isNotEmpty &&
                          phoneController.text.isNotEmpty) {
                        String newId =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        addresses.add({
                          "id": newId,
                          "name": nameController.text.trim(),
                          "address": addressController.text.trim(),
                          "phone": phoneController.text.trim(),
                        });
                        selectedAddressId.value = newId;
                        Get.back();
                        Get.snackbar("Success", "Address added successfully",
                            backgroundColor: Colors.green,
                            colorText: Colors.white);
                      } else {
                        Get.snackbar("Error", "Please fill all fields",
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff0A6CF0)),
                    child: const Text("Add Address",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  // ========== EDIT ADDRESS ==========
  void _editAddressSheet(String addressId) {
    Map<String, String> addr =
        addresses.firstWhere((element) => element["id"] == addressId);

    TextEditingController nameController =
        TextEditingController(text: addr["name"]);
    TextEditingController addressController =
        TextEditingController(text: addr["address"]);
    TextEditingController phoneController =
        TextEditingController(text: addr["phone"]);

    showModalBottomSheet(
      context: Get.context!,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 20,
              right: 20,
              top: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Edit Address",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: addressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Address",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          int index = addresses.indexWhere(
                              (element) => element["id"] == addressId);
                          addresses[index] = {
                            "id": addressId,
                            "name": nameController.text.trim(),
                            "address": addressController.text.trim(),
                            "phone": phoneController.text.trim(),
                          };
                          Get.back();
                          Get.snackbar("Success", "Address updated",
                              backgroundColor: Colors.green,
                              colorText: Colors.white);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff0A6CF0)),
                        child: const Text("Update",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (addresses.length > 1) {
                            addresses.removeWhere(
                                (element) => element["id"] == addressId);
                            selectedAddressId.value = addresses[0]["id"]!;
                            Get.back();
                            Get.snackbar("Success", "Address deleted",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          } else {
                            Get.snackbar(
                                "Error", "You must have at least one address",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text("Delete",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  // ========== PAYMENT OPTIONS ==========
  Widget _paymentOptions() {
    return Obx(
      () => Container(
        decoration: _boxStyle(),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            _radioTile("COD", "Cash on Delivery", Icons.delivery_dining),
            _radioTile("ONLINE", "UPI / Online Payment", Icons.phone_iphone),
            _radioTile("CARD", "Debit / Credit Card", Icons.credit_card),
          ],
        ),
      ),
    );
  }

  Widget _radioTile(String value, String label, IconData icon) {
    return RadioListTile(
      value: value,
      groupValue: selectedPayment.value,
      onChanged: (v) => selectedPayment.value = v!,
      activeColor: const Color(0xff0A6CF0),
      title: Text(label),
      secondary: Icon(icon, color: Colors.blue),
    );
  }

  // ========== PRESCRIPTION UPLOAD ==========
  Widget _prescriptionUpload() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(15),
        decoration: _boxStyle(),
        child: Column(
          children: [
            prescriptionImage.value == null
                ? GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Colors.blue.shade200, width: 2),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.upload_file,
                                size: 45, color: Colors.blue),
                            SizedBox(height: 8),
                            Text("Upload Doctor Prescription",
                                style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          prescriptionImage.value!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () => prescriptionImage.value = null,
                        child: const Text("Remove",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      prescriptionImage.value = File(img.path);
    }
  }

  // ========== ORDER SUMMARY ==========
  Widget _orderSummary() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: _boxStyle(),
      child: Obx(
        () => Column(
          children: [
            ...cartController.cartItems.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${item.name} x${item.quantity}",
                        style: const TextStyle(fontSize: 14)),
                    Text(
                      "₹${(item.price * item.quantity.value).toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Amount",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                  "₹${cartController.totalAmount.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0A6CF0)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ========== PLACE ORDER BUTTON ==========
  Widget _placeOrderButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Get.to(() => const OrderSuccessPage());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text("Place Order",
            style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }

  BoxDecoration _boxStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.blue.shade100),
      boxShadow: [
        BoxShadow(
            color: Colors.blue.shade50,
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 3))
      ],
    );
  }
}

// ========== SUCCESS PAGE ==========
class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/success.gif", height: 180),
              const SizedBox(height: 20),
              const Text("Order Placed Successfully!",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green)),
              const SizedBox(height: 10),
              const Text(
                "Thank you for shopping with us.\nYour order will be delivered soon.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Get.off(() => MainNavigation()),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0A6CF0),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: const Text("Back to Home",
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}