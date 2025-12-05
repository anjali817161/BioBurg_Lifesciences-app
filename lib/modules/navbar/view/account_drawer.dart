import 'package:bioburg_lifescience/modules/wishlist/view/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountDrawer extends StatelessWidget {
  const AccountDrawer({super.key});

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
            // USER NAME SECTION
            Container(
              height: 120,
              padding: const EdgeInsets.all(16),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "User Name",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004AAD),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.blue.shade200, thickness: 2,),

            // LIST ITEMS
            Expanded(
              child: ListView(
                children: [
                  _buildListItem(Icons.person, "Profile", onTap: () {}),
                  _divider(),
                  _buildListItem(Icons.shopping_cart, "Orders History", onTap: () {}),
                  _divider(),
                  _buildListItem(Icons.favorite, "My Wishlist", onTap: () {
                    Get.to(() => WishlistPage());
                  }),
                  _divider(),
                  _buildListItem(Icons.help, "FAQs", onTap: () {}),
                  _divider(),
                  _buildListItem(Icons.info, "About Us", onTap: () {}),
                  _divider(),
                  _buildListItem(Icons.policy, "Policies", onTap: () {}),
                  _divider(),
                  _buildListItem(Icons.logout, "Logout"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Divider(color: Colors.blue.shade100);

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
      onTap: onTap,
    );
  }
}
