import 'package:bioburg_lifescience/modules/trending/controller/trending_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrendingProductsPage extends StatelessWidget {
  TrendingProductsPage({Key? key}) : super(key: key);

  final TrendingController controller = Get.put(TrendingController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 PAGE HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Text(
              "🔥 Trending Products",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // 🔹 PRODUCT GRID
          Expanded(
            child: Obx(
              () => GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.70,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                ),
                itemCount: controller.trendingProducts.length,
                itemBuilder: (context, index) {
                  final item = controller.trendingProducts[index];

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🔹 PRODUCT IMAGE
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.asset(
                                item["image"],
                                height: 130,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 8),

                            // 🔹 PRODUCT NAME
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                item["name"],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            SizedBox(height: 4),

                            // 🔹 PRICE
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                item["price"],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),

                            Spacer(),

                            // 🔹 ADD TO CART BUTTON
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                height: 38,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () => controller.addToCart(item["id"]),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    "Add to Cart",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        // ❤️ FAV ICON — TOP RIGHT
                        Positioned(
                          right: 10,
                          top: 10,
                          child: GestureDetector(
                            onTap: () => controller.toggleFav(item["id"]),
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.white70,
                              child: Icon(
                                item["isFav"] ? Icons.favorite : Icons.favorite_border,
                                color: item["isFav"] ? Colors.red : Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                        ),

                        // 🔥 TRENDING LABEL
                        Positioned(
                          left: 0,
                          top: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade700,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Trending",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
