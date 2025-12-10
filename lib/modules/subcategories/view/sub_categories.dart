import 'package:bioburg_lifescience/modules/home/controller/home_categories_controller.dart';
import 'package:bioburg_lifescience/modules/home/model/home_categories_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoriesPage extends StatelessWidget {
  final String categoryId;
  final String categoryTitle;

  SubCategoriesPage({super.key, required this.categoryId, required this.categoryTitle});

  final CategoryDetailsController controller = Get.put(CategoryDetailsController());

  @override
  Widget build(BuildContext context) {
    controller.loadMainCategory(categoryId); // 🔥 load subcategories + products

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(categoryTitle, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Row(
          children: [
            // ---------------------------------------------------
            // LEFT SIDE : SUBCATEGORIES LIST
            // ---------------------------------------------------
            Container(
              width: 115,
              color: Colors.white,
              child: ListView.builder(
                itemCount: controller.subCategories.length,
                itemBuilder: (_, index) {
                  final sub = controller.subCategories[index];
                  bool isSelected = sub.id == controller.categoryName.value;

                  return InkWell(
                    onTap: () {
                      controller.loadSubCategory(sub.id); // 🔥 load subcat products
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.shade50 : Colors.white,
                        border: isSelected
                            ? const Border(
                                left: BorderSide(color: Colors.blue, width: 4),
                              )
                            : null,
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor:
                                isSelected ? Colors.blue.shade100 : Colors.grey.shade200,
                            child: const Icon(Icons.medical_services, size: 20),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            sub.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // ---------------------------------------------------
            // RIGHT SIDE : PRODUCT LIST
            // ---------------------------------------------------
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: controller.products.length,
                itemBuilder: (_, index) {
                  final p = controller.products[index];

                  return Column(
                    children: [
                      productTile(p),
                      const SizedBox(height: 12),
                      Divider(color: Colors.grey.shade300),
                      const SizedBox(height: 12),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  // ---------------------------------------------------
  // PRODUCT TILE
  // ---------------------------------------------------
  Widget productTile(ProductModel p) {
    return GestureDetector(
      onTap: () {
        // Get.to(() => ProductDetailsPage(product: p));
      },
      child: Row(
        children: [
          // IMAGE -----------------
          Container(
            width: 95,
            height: 95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(p.images.first),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // DETAILS -----------------
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.title,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),

                Row(
                  children: [
                    Text(
                      "₹${p.price}",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 6),

                    if (p.mrp != null)
                      Text(
                        "₹${p.mrp}",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 10),

                // ADD BUTTON
                addButton(p),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------
  // ADD BUTTON (STATIC FOR NOW)
  // ---------------------------------------------------
  Widget addButton(ProductModel p) {
    return Container(
      height: 34,
      width: 75,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text("ADD", style: TextStyle(color: Colors.white)),
    );
  }
}
