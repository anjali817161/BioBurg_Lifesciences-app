import 'package:bioburg_lifescience/modules/product_details/view/product_details.dart';
import 'package:bioburg_lifescience/modules/productslist/controller/productlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListPage extends StatelessWidget {
  final String subcategoryName;
  ProductListPage({super.key, required this.subcategoryName}) {
    // Pass selected subcategory name to controller
    controller.setSubcategory(subcategoryName);
  }

  final ProductListController controller =
      Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<ProductListController>(
          builder: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 HEADING (NO APP BAR)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Text(
                  controller.subcategoryName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),

              const Divider(height: 1),

              // 🔹 Product List
              Expanded(
                child: ListView.separated(
                  
                  itemCount: controller.products.length,
                  padding: const EdgeInsets.all(12),
                  separatorBuilder: (_, __) =>
                      const Divider(height: 30, thickness: 1),
                  itemBuilder: (context, index) {
                    final item = controller.products[index];

                    return GestureDetector(
                      onTap: () {
                        // Navigate to product details
                        Get.to(() => ProductDetailsPage());
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // PRODUCT IMAGE
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item.image,
                              height: 95,
                              width: 95,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 14),
                      
                          // PRODUCT DETAILS
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title
                                Text(
                                  item.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 6),
                      
                                // Rating
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        item.rating.toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 11),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      "•  Fast Delivery",
                                      style: TextStyle(
                                          color: Colors.blue.shade700,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                      
                                const SizedBox(height: 8),
                      
                                // Prices Row
                                Row(
                                  children: [
                                    Text(
                                      "₹${item.price}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      "₹${item.oldPrice}",
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                      
                                const SizedBox(height: 10),
                      
                                // ADD Button
                                Container(
                                  height: 36,
                                  width: 90,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade800,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "+ ADD",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      
                          // FAVORITE BUTTON
                          InkWell(
                            onTap: () => controller.toggleFavorite(index),
                            child: Icon(
                              item.isFav
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
