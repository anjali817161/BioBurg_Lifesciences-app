import 'package:bioburg_lifescience/modules/product_details/view/product_details.dart';
import 'package:bioburg_lifescience/modules/wishlist/controller/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistPage extends StatelessWidget {
  WishlistPage({super.key});

  final WishlistController controller = Get.put(WishlistController());

  static const List<String> assetImages = [
    'assets/images/med1.png',
    'assets/images/med2.png',
    'assets/images/med3.png',
    'assets/images/doctor1.png',
    'assets/images/doctor2.png',
    'assets/images/doctor3.png',
    'assets/images/doctor4.png',
    'assets/images/doctor5.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My Wishlist",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<WishlistController>(
          builder: (_) => controller.wishlist.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 80,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "No products in wishlist",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: controller.wishlist.length,
                  itemBuilder: (context, index) {
                    final item = controller.wishlist[index];
                    final imageIndex = index % assetImages.length;

                    return GestureDetector(
                      onTap: () {
                        // Navigate to product details
                        Get.to(() => ProductDetailsPage());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // PRODUCT IMAGE
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(14),
                                    topRight: Radius.circular(14),
                                  ),
                                  child: Image.asset(
                                    assetImages[imageIndex],
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // REMOVE FROM WISHLIST BUTTON
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () => controller.removeFromWishlist(item["id"]),
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.9),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // NAME
                                  Text(
                                    item["name"],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                      
                                  const SizedBox(height: 6),
                      
                                  // PRICE
                                  Text(
                                    item["price"],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                      
                                  const SizedBox(height: 4),
                      
                                  // OLD PRICE (if available)
                                  if (item["old_price"] != null)
                                    Text(
                                      item["old_price"],
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey.shade600,
                                        fontSize: 12,
                                      ),
                                    ),
                      
                                  // OFFER (if available)
                                  if (item["offer"] != null)
                                    Text(
                                      item["offer"],
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
