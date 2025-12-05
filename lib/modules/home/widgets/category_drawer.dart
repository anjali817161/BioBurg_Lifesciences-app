import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bioburg_lifescience/modules/home/controller/home_controller.dart';

class CategoryDrawer extends StatelessWidget {
  final String categoryName;

  CategoryDrawer({super.key, required this.categoryName});

  final controller = Get.put(CategoryDrawerController());

  @override
  Widget build(BuildContext context) {
   List<Map<String, dynamic>> items = controller.getFullCategoryData(categoryName);


    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      height: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drawer Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004AAD), // Blue theme
                ),
              ),
              Icon(Icons.close, size: 26, color: Colors.grey[700]),
            ],
          ),

          const SizedBox(height: 8),
          Divider(color: Colors.blue.shade200),

          const SizedBox(height: 5),

          // Drawer List
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) =>
                  Divider(color: Colors.blue.shade100, height: 10),
              itemBuilder: (_, index) {
                final item = items[index];

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue.shade100),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      initiallyExpanded: false,
                      tilePadding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      childrenPadding:
                          const EdgeInsets.only(left: 20, bottom: 10, right: 10),

                      leading: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(
                          Icons.category,
                          color: Colors.blue.shade700,  
                          size: 18,
                        ),
                      ),

                      title: Text(
                        item['title'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade900,
                        ),
                      ),

                      iconColor: Colors.blue,
                      collapsedIconColor: Colors.blue.shade300,

                      children: (item['subcategories'] as List<dynamic>).map((sub) {
                        return GestureDetector(
                          onTap: () {
                            // Navigation later
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 6),
                            margin: const EdgeInsets.only(bottom: 6),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Colors.blue.shade300,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_right,
                                    color: Colors.blue.shade700, size: 20),
                                const SizedBox(width: 4),
                                Text(
                                  sub,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
