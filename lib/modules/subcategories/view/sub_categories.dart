import 'package:bioburg_lifescience/modules/productslist/view/productlist_view.dart';
import 'package:bioburg_lifescience/modules/subcategories/controller/subcategories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategories extends StatelessWidget {
  final String categoryName;
  SubCategories({super.key, required this.categoryName});

  final SubCategoryController controller = Get.put(SubCategoryController());

  @override
  Widget build(BuildContext context) {
    controller.loadCategory(categoryName);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          categoryName,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          var data = controller.allCategories[controller.selectedCategory];
          List subCats = data["subcategories"];
          String selectedSubCat = subCats[controller.selectedSubCategory.value];

          List products = data["products"][selectedSubCat];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ⭐ PAGE TITLE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  selectedSubCat,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),

              Expanded(
                child: Row(
                  children: [
                    // LEFT SIDE CATEGORY LIST ---------------------------
                    _leftCategoryList(subCats),

                    // RIGHT SIDE PRODUCT LIST ----------------------------
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(12),
                        children: [
                          ...controller.paginatedProducts().map(
                            (p) => Column(
                              children: [
                                _productTile(p),
                                const SizedBox(height: 10),
                                Divider(color: Colors.grey.shade300),
                                const SizedBox(height: 14),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                           GestureDetector(
          onTap: (){
            Get.to(() => ProductListPage(subcategoryName: selectedSubCat));
          },
          child: Container(
            height: 34,
            width: 75,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "View More",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ),


 const SizedBox(height: 10),
                          _paginationBar(controller.getProducts().length),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // LEFT SIDE CATEGORY LIST UI
  Widget _leftCategoryList(subCats) {
    return Container(
      width: 115,
      color: Colors.white,
      child: ListView.builder(
        itemCount: subCats.length,
        itemBuilder: (_, index) {
          bool isSelected = index == controller.selectedSubCategory.value;

          return InkWell(
            onTap: () {
              controller.changeSubCategory(index);
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
                    radius: 23,
                    backgroundColor:
                        isSelected ? Colors.blue.shade100 : Colors.grey.shade200,
                    child: Icon(
                      Icons.medical_services,
                      color: isSelected ? Colors.blue : Colors.black54,
                      size: 22,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subCats[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? Colors.blue.shade900 : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ⭐ UPDATED PRODUCT CARD UI
  Widget _productTile(p) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // IMAGE + LIKE BUTTON
        Stack(
          children: [
            // PRODUCT IMAGE
            Container(
              width: 95,
              height: 95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(p["image"]),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // ❤️ LIKE BUTTON
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.85),
                ),
                child: const Icon(
                  Icons.favorite_border,
                  size: 18,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(width: 12),

        // PRODUCT DETAILS
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PRODUCT TITLE
              Text(
                p["title"],
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 6),

              // RATING
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      p["rating"],
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "${p["rating_count"]} reviews",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                  )
                ],
              ),
              const SizedBox(height: 8),

              // PRICE
              Row(
                children: [
                  Text(
                    p["price"],
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    p["old_price"],
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    p["offer"],
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // ADD BUTTON + COUNTER
              _addButton(p),
            ],
          ),
        )
      ],
    );
  }

  // ADD BUTTON / COUNTER UI
  Widget _addButton(p) {
    return Obx(() {
      int qty = controller.cartMap[p["id"]] ?? 0;

      if (qty == 0) {
        return GestureDetector(
          onTap: () => controller.addToCart(p),
          child: Container(
            height: 34,
            width: 75,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "ADD",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        );
      }

      return Container(
        height: 34,
        width: 90,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue.shade700),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => controller.decreaseQty(p),
              child: const Icon(Icons.remove, size: 18),
            ),
            Text("$qty",
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            GestureDetector(
              onTap: () => controller.increaseQty(p),
              child: const Icon(Icons.add, size: 18),
            ),
          ],
        ),
      );
    });
  }

  // PAGINATION BAR
  Widget _paginationBar(int totalProducts) {
    return Obx(() {
      int totalPages = (totalProducts / controller.itemsPerPage).ceil().toInt();

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18),
            onPressed: controller.currentPage.value > 1
                ? () => controller.currentPage.value--
                : null,
          ),
          Text(
            "${controller.currentPage.value} / $totalPages",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 18),
            onPressed: controller.currentPage.value < totalPages
                ? () => controller.currentPage.value++
                : null,
          ),
        ],
      );
    });
  }
}
