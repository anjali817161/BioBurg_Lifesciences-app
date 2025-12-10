import 'package:bioburg_lifescience/modules/home/controller/categories_controller.dart';
import 'package:bioburg_lifescience/modules/subcategories/view/sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  // final List<Map<String, String>> categories = [

  final CategoryController controller = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade300,
                Colors.blue.shade200,
                Colors.white.withOpacity(0.3),
              ],
              stops: const [0.0, 0.6, 1.0],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            
            title: Row(
              children: [
                Text(
                  "Categories",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: 1.2,
                    color: Colors.blue.shade800,
                  ),
                ),
               
              ],
            ),
           
          ),
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          // 🔹 Grid Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: GridView.builder(
                itemCount: controller.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (context, index) {

                  final cat = controller.categories[index];
                  return _buildCategoryCard(
                    name: cat.title,
                    image: cat.imageUrl,
                    id: cat.id
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({required String name, required String image, required String id}) {
    return GestureDetector(
      onTap: () {
        // Handle category card tap
        Get.to(() => SubCategoriesPage(categoryId: id, categoryTitle: name));
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
