import 'package:bioburg_lifescience/modules/subcategories/view/sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({super.key});

  final List<Map<String, String>> categories = [
    {
      "name": "Homeopathy",
      "image": "https://cdn-icons-png.flaticon.com/512/1047/1047711.png"
    },
    {
      "name": "Unani",
      "image": "https://cdn-icons-png.flaticon.com/512/1047/1047713.png"
    },
    {
      "name": "Oral Care",
      "image": "https://cdn-icons-png.flaticon.com/512/483/483361.png"
    },
    {
      "name": "Baby Care",
      "image": "https://cdn-icons-png.flaticon.com/512/3209/3209885.png"
    },
    {
      "name": "Sexual Wellness",
      "image": "https://cdn-icons-png.flaticon.com/512/1048/1048940.png"
    },
    {
      "name": "Personal Care",
      "image": "https://cdn-icons-png.flaticon.com/512/1046/1046751.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // 🔹 Beautiful Heading
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 55, 18, 10),
            child: Text(
              "Categories",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.blue.shade800,
              ),
            ),
          ),

          // 🔹 Grid Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (context, index) {
                  return _buildCategoryCard(
                    name: categories[index]["name"]!,
                    image: categories[index]["image"]!,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({required String name, required String image}) {
    return GestureDetector(
      onTap: () {
        // Handle category card tap
        Get.to(() => SubCategories(categoryName: name));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.blue.shade100,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade50.withOpacity(0.6),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(2, 5),
            )
          ],
        ),
      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      
            // IMAGE HOLDER
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade50,
              ),
              padding: const EdgeInsets.all(10),
              child: Image.network(image),
            ),
      
            const SizedBox(height: 12),
      
            // TITLE
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade800,
              ),
            )
          ],
        ),
      ),
    );
  }
}
