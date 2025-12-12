import 'package:bioburg_lifescience/modules/profile/controller/profile_controller.dart';
import 'package:bioburg_lifescience/modules/wishlist/view/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            const SizedBox(height: 20),
            _quickTiles(),
            const SizedBox(height: 20),
            _orderStats(),
            const SizedBox(height: 25),
            _profileOptions(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // 🔹 HEADER – Modern Pharmacy Style
  // ------------------------------------------------------------------
  Widget _header() {
    return Obx(
      () {
        final name = controller.userName.value;
        final letter = name.isNotEmpty ? name[0].toUpperCase() : "U";

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
          decoration: const BoxDecoration(
            color: Color(0xff0A6CF0),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
          child: Row(
            children: [
              // Circle with First Letter
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
                child: Text(
                  letter,
                  style: const TextStyle(
                    fontSize: 32,
                    color: Color(0xff0A6CF0),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 18),

              // Name + UserID
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "User ID: ${controller.userId.value}",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------------
  // 🔹 TOP TILES (Wishlist / Cart / Settings)
  // ------------------------------------------------------------------
  Widget _quickTiles() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _tile(Icons.favorite, "Wishlist", Colors.pink.shade400, (){Get.to(() => WishlistPage());}),
          _tile(Icons.shopping_cart, "My Cart", Colors.green.shade500, (){}),
          _tile(Icons.settings, "Settings", Colors.blue.shade600, (){}),
        ],
      ),
    );
  }

  Widget _tile(IconData icon, String title, Color color, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: color.withOpacity(.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------------
  // 🔹 ORDER STATS – Glass Cards
  // ------------------------------------------------------------------
  Widget _orderStats() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _statCard("Total Orders", controller.totalOrders.value.toString(),
                Icons.receipt_long, Colors.blue),
            _statCard("Pending", controller.pendingOrders.value.toString(),
                Icons.timer, Colors.orange),
            _statCard("Delivered", controller.deliveredOrders.value.toString(),
                Icons.check_circle, Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _statCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.95),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // 🔹 PROFILE OPTIONS LIST (Modern Tiles)
  // ------------------------------------------------------------------
  Widget _profileOptions() {
    return Column(
      children: [
        _optionTile("My Orders", Icons.shopping_bag),
        _optionTile("FAQ", Icons.medical_services),
        _optionTile("Help & Support", Icons.support_agent),
        _optionTile("About Us", Icons.info_outline),
      ],
    );
  }

  Widget _optionTile(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.blue, size: 26),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      ),
    );
  }
}
