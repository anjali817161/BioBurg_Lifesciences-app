import 'package:bioburg_lifescience/modules/cart/controller/cart_controller.dart';
import 'package:bioburg_lifescience/modules/checkout/view/cheacout_view.dart';
import 'package:bioburg_lifescience/modules/wishlist/view/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  final CartController controller = Get.put(CartController());

  final Color themeBlue = const Color(0xff0066FF);
  final Color themeLight = const Color(0xffF2F6FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Cart",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: 1.2,
                    color: Colors.blue.shade800,
                  ),
                ),
               
              ],
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.15),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.blue.shade700),
                  onPressed: () {
                    Get.to(() => WishlistPage());
                  },
                ),
              ),
             
            ],
          ),
        ),
      ),
      backgroundColor: themeLight,
      body: SafeArea(
        child: Column(
          children: [
          
            Expanded(child: _buildContent()),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  // -------------------- HEADER --------------------
  Widget _buildHeader() {
    return Container(
      color: themeBlue,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
      width: double.infinity,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
          ),
          const SizedBox(width: 12),
          const Text(
            "My Cart (1)",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              // Navigate to Wishlist Page
              Get.to(() => WishlistPage());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "WISHLIST",
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          )
        ],
      ),
    );
  }

  // -------------------- MAIN BODY --------------------
  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _locationBox(),
          _freeDeliveryBanner(),
          _cartItem(),
          _couponBox(),
          _gstBox(),
          _priceDetails(),
          const SizedBox(height: 120),
        ],
      ),
    );
  }

  // -------------------- LOCATION BOX --------------------
  Widget _locationBox() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: Colors.black54),
          const SizedBox(width: 10),
          const Text("Showing availability at "),
          Text(
            "110020",
            style: TextStyle(
              color: themeBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: themeBlue,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              "CHANGE",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

  // -------------------- FREE DELIVERY BAR --------------------
  Widget _freeDeliveryBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: Row(
        children: [
          const Icon(Icons.local_shipping_outlined, color: Colors.green),
          const SizedBox(width: 8),
          const Text("Add ₹426 to your order for FREE Delivery"),
        ],
      ),
    );
  }

  // -------------------- CART ITEM --------------------
  Widget _cartItem() {
    return Obx(() => Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Text("TOTAL ${controller.cartItems.length} ITEM${controller.cartItems.length > 1 ? 'S' : ''}", style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Icon(Icons.delete_outline, color: Colors.black54)
            ],
          ),
          const SizedBox(height: 15),
          ...controller.cartItems.map((item) => _cartItemTile(item, controller.cartItems.indexOf(item))),
        ],
      ),
    ));
  }

  Widget _cartItemTile(CartItem item, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            color: themeLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(item.image, fit: BoxFit.contain),
        ),

        const SizedBox(width: 15),

        // Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Text(item.model, style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 6),

              Row(
                children: [
                  Text(
                    "₹${item.price}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  _qtyButton(index),
                ],
              ),

              const SizedBox(height: 10),
              Text(
                "Sub Total : ₹${(item.price * item.quantity.value).toStringAsFixed(0)}",
                style: TextStyle(
                  color: themeBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),
              const Text(
                "Item will be delivered in 2-4 days",
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // -------------------- QTY BUTTON --------------------
  Widget _qtyButton(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Obx(
        () => Row(
          children: [
            GestureDetector(
              onTap: () => controller.decreaseQty(index),
              child: const Icon(Icons.remove, size: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("Qty: ${controller.cartItems[index].quantity.value}"),
            ),
            GestureDetector(
              onTap: () => controller.increaseQty(index),
              child: const Icon(Icons.add, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------- COUPON BOX --------------------
  Widget _couponBox() {
    return _tile(Icons.percent, "Apply Coupon");
  }

  // -------------------- GST BOX --------------------
  Widget _gstBox() {
    return _tile(Icons.receipt_long_outlined, "Use GST Invoice");
  }

  Widget _tile(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Row(
        children: [
          Icon(icon, color: themeBlue),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontSize: 15)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded,
              size: 15, color: Colors.black45),
        ],
      ),
    );
  }

  // -------------------- PRICE DETAILS --------------------
  Widget _priceDetails() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(top: 10),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("PRICE DETAILS", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            _priceTile("Total MRP", "₹80"),
            _priceTile("Item Discount", "-₹${controller.discount}", green: true),
            _priceTile("Shipping Charge", "₹${controller.shipping}"),

            const Divider(height: 25),

            _priceTile("Grand Total", "₹${controller.grandTotal.toStringAsFixed(0)}",
                bold: true),
          ],
        ),
      ),
    );
  }

  Widget _priceTile(String title, String amount,
      {bool green = false, bool bold = false}) {
    return Row(
      children: [
        Text(title),
        const Spacer(),
        Text(
          amount,
          style: TextStyle(
            color: green ? Colors.green : Colors.black,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        )
      ],
    );
  }

  // -------------------- BOTTOM BAR --------------------
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2))
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.red),
          const SizedBox(width: 10),
          const Text("Add delivery address", style: TextStyle(fontSize: 15)),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Get.to(() => CheckoutPage());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: themeBlue,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minimumSize: Size(120, 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text("Continue"),
          )
        ],
      ),
    );
  }
}
