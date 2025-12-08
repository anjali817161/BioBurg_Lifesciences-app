import 'package:bioburg_lifescience/modules/cart/view/cart_view.dart';
import 'package:bioburg_lifescience/modules/profile/view/user_profile.dart';
import 'package:bioburg_lifescience/modules/wishlist/view/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountDrawer extends StatefulWidget {
  const AccountDrawer({super.key});

  @override
  State<AccountDrawer> createState() => _AccountDrawerState();
}

class _AccountDrawerState extends State<AccountDrawer> {
  bool isCorporateExpanded = false;

  // TODO: Replace with actual user data from your auth controller
  String userName = "User Name";

  String getInitials(String name) {
    List<String> nameParts = name.trim().split(' ');
    if (nameParts.isEmpty) return 'U';
    if (nameParts.length == 1) return nameParts[0][0].toUpperCase();
    return (nameParts[0][0] + nameParts[nameParts.length - 1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          bottomLeft: Radius.circular(0),
        ),
      ),
      child: Container(
        color: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // USER PROFILE SECTION
            Container(
              height: 140,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF004AAD), Color(0xFF0066DD)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  // Circular Avatar with Initials
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Text(
                      getInitials(userName),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF004AAD),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // User Name
                  Expanded(
                    child: Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // LIST ITEMS
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 8),
                  
                  // CORPORATE LOGIN SECTION (Special Design)
                  _buildCorporateSection(),
                  
                  const SizedBox(height: 8),
                  Divider(color: Colors.blue.shade200, thickness: 2),
                  
                  _buildListItem(Icons.person, "Profile", onTap: () {
                    Get.back();
                    Get.to(() => UserProfilePage());
                  }),
                  _divider(),
                  _buildListItem(Icons.shopping_cart, "Orders History", onTap: () {
                    Get.back();
                    Get.to(() => CartPage());
                  }),
                  _divider(),
                  _buildListItem(Icons.favorite, "My Wishlist", onTap: () {
                    Get.back();
                    Get.to(() => WishlistPage());
                  }),
                  _divider(),
                  _buildListItem(Icons.help, "FAQs", onTap: () {
                    Get.back();
                    // TODO: Navigate to FAQs page
                  }),
                  _divider(),
                  _buildListItem(Icons.info, "About Us", onTap: () {
                    Get.back();
                    // TODO: Navigate to About Us page
                  }),
                  _divider(),
                  _buildListItem(Icons.policy, "Policies", onTap: () {
                    Get.back();
                    // TODO: Navigate to Policies page
                  }),
                  _divider(),
                  _buildListItem(Icons.logout, "Logout", onTap: () {
                    _showLogoutDialog(context);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCorporateSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF004AAD), Color(0xFF0055CC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Main Corporate Login Button
          InkWell(
            onTap: () {
              setState(() {
                isCorporateExpanded = !isCorporateExpanded;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Icon(Icons.business, color: Colors.white, size: 26),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      "Corporate Login",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Icon(
                    isCorporateExpanded 
                        ? Icons.keyboard_arrow_up 
                        : Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          
          // Dropdown Items
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  Divider(color: Colors.white.withOpacity(0.3), height: 1),
                  _buildDropdownItem(
                    icon: Icons.login,
                    title: "Vendor Login",
                    onTap: () {
                      Get.back();
                      // TODO: Navigate to Vendor Login Page
                      // Get.to(() => VendorLoginPage());
                      Get.snackbar(
                        "Vendor Login",
                        "Navigate to Vendor Login Page",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.blue,
                        colorText: Colors.white,
                      );
                    },
                  ),
                  Divider(color: Colors.white.withOpacity(0.2), height: 1),
                  _buildDropdownItem(
                    icon: Icons.app_registration,
                    title: "Vendor Registration",
                    onTap: () {
                      Get.back();
                      // TODO: Navigate to Vendor Registration Page
                      // Get.to(() => VendorRegistrationPage());
                      Get.snackbar(
                        "Vendor Registration",
                        "Navigate to Vendor Registration Page",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.blue,
                        colorText: Colors.white,
                      );
                    },
                  ),
                ],
              ),
            ),
            crossFadeState: isCorporateExpanded 
                ? CrossFadeState.showSecond 
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Divider(color: Colors.blue.shade100, height: 1);

  Widget _buildListItem(IconData icon, String title, {void Function()? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade700),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Colors.blue.shade900,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.blue.shade300),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Get.back(); // Close drawer
                // TODO: Implement logout logic
                Get.snackbar(
                  "Logged Out",
                  "You have been successfully logged out",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              },
              child: Text("Logout", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}