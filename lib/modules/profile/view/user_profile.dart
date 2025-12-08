import 'package:bioburg_lifescience/modules/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 15),
              _walletSection(),
              const SizedBox(height: 15),
              _orderStats(),
              const SizedBox(height: 20),
              _quickActions(),
              const SizedBox(height: 20),
              _profileOptions(),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // 🔹 HEADER SECTION
  // ------------------------------------------------------------------
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xff0A6CF0), // App Blue
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage("assets/images/profile.png"),
          ),
          const SizedBox(width: 15),
          Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.userName.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    controller.userEmail.value,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // 🔹 WALLET SECTION
  // ------------------------------------------------------------------
  Widget _walletSection() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade100],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade100,
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _walletItem(Icons.account_balance_wallet, "Wallet",
                controller.walletBalance.value),
            _walletItem(Icons.star, "Reward Points",
                controller.rewardPoints.value),
          ],
        ),
      ),
    );
  }

  Widget _walletItem(IconData icon, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.blue, size: 28),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------------
  // 🔹 ORDER STATS (Modern Glass Cards)
  // ------------------------------------------------------------------
  Widget _orderStats() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _statCard("Total Orders", controller.totalOrders.value.toString(),
              Icons.shopping_bag),
          _statCard("Pending", controller.pendingOrders.value.toString(),
              Icons.timer),
          _statCard("Delivered", controller.deliveredOrders.value.toString(),
              Icons.check_circle),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Container(
      width: 105,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.95),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.blue.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.blue, size: 26),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          )
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // 🔹 QUICK ACTIONS
  // ------------------------------------------------------------------
  Widget _quickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _actionButton(Icons.favorite, "Wishlist"),
        _actionButton(Icons.shopping_cart, "My Cart"),
        _actionButton(Icons.notifications, "Alerts"),
      ],
    );
  }

  Widget _actionButton(IconData icon, String title) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blue, size: 26),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  // ------------------------------------------------------------------
  // 🔹 PROFILE OPTIONS LIST
  // ------------------------------------------------------------------
  Widget _profileOptions() {
    return Column(
      children: [
        _optionTile("My Orders", Icons.receipt_long),
        _optionTile("Manage Address", Icons.location_on),
        _optionTile("Payment Methods", Icons.payment),
        _optionTile("Privacy & Security", Icons.lock),
        _optionTile("Help & Support", Icons.help_outline),
        _optionTile("Settings", Icons.settings),
        const SizedBox(height: 20),
        _logoutButton(),
      ],
    );
  }

  Widget _optionTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue, size: 28),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
    );
  }

  // ------------------------------------------------------------------
  // 🔹 LOGOUT BUTTON
  // ------------------------------------------------------------------
  Widget _logoutButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade600,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text(
          "Logout",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
