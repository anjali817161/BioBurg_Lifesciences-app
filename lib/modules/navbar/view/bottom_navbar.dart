import 'package:bioburg_lifescience/modules/cart/view/cart_view.dart';
import 'package:bioburg_lifescience/modules/dynamicSections/view/dynamic_section_view.dart';
import 'package:bioburg_lifescience/modules/navbar/controller/navigation_controller.dart';
import 'package:bioburg_lifescience/modules/trending/view/trending_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bioburg_lifescience/modules/home/view/home_view.dart';
import 'package:bioburg_lifescience/modules/categories/view/categories_view.dart';

class MainNavigation extends StatelessWidget {
  MainNavigation({super.key});

  final BottomNavController navController = Get.put(BottomNavController());

  final List<Widget> pages = [
    HomeView(),
    CategoriesPage(),
   TrendingProductsPage(),
SectionsView()  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: pages[navController.currentIndex.value],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navController.currentIndex.value,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          onTap: navController.changeTab,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
            BottomNavigationBarItem(icon: Icon(Icons.trending_up_rounded), label: "Trending"),
            BottomNavigationBarItem(icon: Icon(Icons.more_horiz_outlined), label: "more"),
          ],
        ),
      ),
    );
  }
}
