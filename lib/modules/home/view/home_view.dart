import 'package:bioburg_lifescience/modules/home/controller/home_controller.dart';
import 'package:bioburg_lifescience/modules/home/widgets/side_drawer.dart';
import 'package:bioburg_lifescience/modules/subcategories/view/sub_categories.dart';
import 'package:bioburg_lifescience/modules/wishlist/view/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  final List<String> types = [
    "Disease",
    "Homeopathy",
    "Ayurveda",
    "Unani",
    "Vitamin & Nutrition",
    "Personal Care",
    "Baby Care",
    "Hair Care",
    "Fitness",
    "Sexual Wellness",
    "Immunity Booster",
    "Supports & Braces",
    "Surgical Stores",
    "Medical Equipment's",
    "Pet Care", 
    "Health Insurance",
  ];

  final List<String> topCategories =[
    "Pathology & Radiology",
    "Generic Medicine",
    "Patent Medicine",
    "Ethical",
    "Investors & Partners",
    "Jobs & Careers",
    "Our Presence",
    "Divisions",
    "Divisions",
  ];

  final List<String> bannerImages = [
    "assets/images/slider1.webp",
    "assets/images/slider2.webp",
    "assets/images/slider3.webp",
    "assets/images/slider4.webp",
    "assets/images/slider5.webp",
    "assets/images/slider6.webp",
    "assets/images/slider7.webp",
    "assets/images/slider8.webp",
  ];

  final List<Map<String, String>> categoryCards = [
    {
      "title": "Nutrition",
      "img": "assets/images/med1.png"
    },
    {
      "title": "Beauty & Personal Care",
      "img": "assets/images/med2.png"
    },
    {
      "title": "Sexual Wellness",
      "img": "assets/images/med3.png"
    },
    {
      "title": "Homeopathy",
      "img": "assets/images/doctor4.png"
    },
    {
      "title": "Baby Care",
      "img": "assets/images/doctor5.png"
    },
    {
      "title": "Vitamins & Supplements",
      "img": "assets/images/med2.png"
    },
    {
      "title": "Oral Care",
      "img": "assets/images/doctor4.png"
    },
    {
      "title": "Hair Care",
      "img": "assets/images/doctor1.png"
    },
  ];

  final String homeopathyBanner =
      "assets/images/home_banner.jpg";

  final List<String> allImages = [
    'assets/images/doctor1.png',
    'assets/images/doctor2.png',
    'assets/images/doctor3.png',
    'assets/images/doctor4.png',
    'assets/images/doctor5.png',
    'assets/images/med1.png',
    'assets/images/med2.png',
    'assets/images/med3.png',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔵 TOP BLUE BAR (WEB जैसा)
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        title: const Text(
          "BioBurg",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          GestureDetector(
            onTap: () {
             Get.to(() => WishlistPage());
            },
            child: Icon(Icons.favorite, color: Colors.white)),
          const SizedBox(width: 15),
          Icon(Icons.shopping_cart, color: Colors.white),
          const SizedBox(width: 15),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80), //
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const SizedBox(height: 10),

             _buildTopMenu(),
            const SizedBox(height: 10),
            // 🔍 SEARCH BAR
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for medicines, injections, health products...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),

            // 🔹 SCROLLABLE TOP MENU (Disease, Ayurveda...)
            _buildTypes(),
           
            const SizedBox(height: 15),

            // 🔵 Banner Slider
            CarouselSlider(
              items: bannerImages.map((img) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(img, fit: BoxFit.cover, width: 2000),
                );
              }).toList(),
              options: CarouselOptions(
                height: 160,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
            ),

            const SizedBox(height: 20),

            // 🔥 Popular Categories Heading
            _header("Popular Categories"),

            const SizedBox(height: 10),

            // 🟥 Horizontal Category Cards (Nutrition, Baby Care...)
            _horizontalCategoryCards(),

            const SizedBox(height: 20),

            // 🟩 Big Homeopathy Banner 
            _bigHomeopathyBanner(),

            const SizedBox(height: 20),
              // 🔥 All Images Section
            _header("Trending Near you"),
             const SizedBox(height: 10),

            // 🟦 GRID CARDS (same content)
            _gridCategories(),

            const SizedBox(height: 20),

          

            // const SizedBox(height: 10),

            // _allImagesGrid(),

            const SizedBox(height: 50),
          ],
        ),
     
      )
    );
  }

  
 //*********************************************************
// 🔹 TYPES SCROLLER (Improved UI)
//*********************************************************
Widget _buildTypes() {
  return FadeTransition(
    opacity: _fadeAnimation,
    child: Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: types.length,
        separatorBuilder: (_, __) => Container(
          width: 1,
          height: 25,
          color: Colors.grey.shade200,
          margin: const EdgeInsets.symmetric(vertical: 10),
        ),
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              Get.put(CategoryDrawerController()); // ensure loaded
              final controller = Get.find<CategoryDrawerController>();
              if (controller.getFullCategoryData(types[index]).isNotEmpty) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => CategoryDrawer(categoryName: types[index]),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              alignment: Alignment.center,
              child: Text(
                types[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade800,
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}


  //*********************************************************
  // 🔹 TOP MENU SCROLLER
  //*********************************************************
  Widget _buildTopMenu() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SizedBox(
        height: 80,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: topCategories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, index) {
            IconData icon;
            switch (topCategories[index]) {
              case "Disease":
                icon = Icons.local_hospital;
                break;
              case "Homeopathy":
                icon = Icons.healing;
                break;
              case "Ayurveda":
                icon = Icons.spa;
                break;
              case "Unani":
                icon = Icons.medical_services;
                break;
              case "Vitamin & Nutrition":
                icon = Icons.restaurant;
                break;
              case "Personal Care":
                icon = Icons.face;
                break;
              case "Baby Care":
                icon = Icons.child_care;
                break;
              case "Hair Care":
                icon = Icons.content_cut;
                break;
              case "Fitness":
                icon = Icons.fitness_center;
                break;
              case "Sexual Wellness":
                icon = Icons.favorite;
                break;
              default:
                icon = Icons.category;
            }
            return GestureDetector(
                onTap: () {
  Get.put(CategoryDrawerController()); // ensure loaded

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => CategoryDrawer(categoryName: topCategories[index]),
  );
},
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                transform: Matrix4.identity(),
                child: Container(
                  width: 80,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, color: Colors.blue.shade800, size: 24),
                      const SizedBox(height: 4),
                      Text(
                        topCategories[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  //*********************************************************
  // 🔹 Popular Categories Horizontal Cards
  //*********************************************************
  Widget _horizontalCategoryCards() {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryCards.length,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          final item = categoryCards[index];
          return Container(
            width: 90,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle category card tap
                    // Get.to(() => SubCategories(categoryName: item["title"]!));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: item["img"]!.startsWith('assets/')
                        ? Image.asset(
                            item["img"]!,
                            height: 60,
                            width: 90,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            item["img"]!,
                            height: 60,
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item["title"]!,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  //*********************************************************
  // 🟩 Homeopathy Banner
  //*********************************************************
  Widget _bigHomeopathyBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          "assets/images/home_banner.jpg",
          height: 180,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  //*********************************************************
  // 🔹 Grid Category Cards
  //*********************************************************
  Widget _gridCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categoryCards.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1),
        itemBuilder: (context, index) {
          final item = categoryCards[index];
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300)),
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Handle grid card tap
                      Get.to(() => SubCategories(categoryName: item["title"]!));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: item["img"]!.startsWith('assets/')
                          ? Image.asset(
                              item["img"]!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )
                          : Image.network(
                              item["img"]!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(item["title"]!,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
          );
        },
      ),
    );
  }

  //*********************************************************
  Widget _header(String text) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(text,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold)),
      );
}
