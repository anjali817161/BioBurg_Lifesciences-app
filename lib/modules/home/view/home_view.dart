import 'package:bioburg_lifescience/modules/cart/view/cart_view.dart';
import 'package:bioburg_lifescience/modules/home/controller/categories_controller.dart';
import 'package:bioburg_lifescience/modules/home/controller/home_controller.dart';
import 'package:bioburg_lifescience/modules/home/widgets/category_drawer.dart';
import 'package:bioburg_lifescience/modules/navbar/view/account_drawer.dart';
import 'package:bioburg_lifescience/modules/subcategories/view/sub_categories.dart';
import 'package:bioburg_lifescience/modules/wishlist/view/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
 import 'package:shimmer/shimmer.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentBannerIndex = 0;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn)
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOut)
    );
    
    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> types = [
    {"name": "Disease", "icon": Icons.medical_services_outlined},
    {"name": "Homeopathy", "icon": Icons.healing_outlined},
    {"name": "Ayurveda", "icon": Icons.spa_outlined},
    {"name": "Unani", "icon": Icons.local_hospital_outlined},
    {"name": "Vitamin & Nutrition", "icon": Icons.restaurant_outlined},
    {"name": "Personal Care", "icon": Icons.face_outlined},
    {"name": "Baby Care", "icon": Icons.child_care_outlined},
    {"name": "Hair Care", "icon": Icons.content_cut_outlined},
    {"name": "Fitness", "icon": Icons.fitness_center_outlined},
    {"name": "Sexual Wellness", "icon": Icons.favorite_outline},
    {"name": "Immunity Booster", "icon": Icons.shield_outlined},
    {"name": "Supports & Braces", "icon": Icons.accessibility_new_outlined},
    {"name": "Surgical Stores", "icon": Icons.medical_information_outlined},
    {"name": "Medical Equipment's", "icon": Icons.medical_information_outlined},
    {"name": "Pet Care", "icon": Icons.pets_outlined},
    {"name": "Health Insurance", "icon": Icons.health_and_safety_outlined},
  ];

  final List<Map<String, dynamic>> topCategories = [
    {"name": "Pathology & Radiology", "icon": Icons.biotech_outlined},
    {"name": "Generic Medicine", "icon": Icons.medication_liquid_outlined},
    {"name": "Patent Medicine", "icon": Icons.verified_outlined},
    {"name": "Ethical", "icon": Icons.verified_user_outlined},
    {"name": "Investors & Partners", "icon": Icons.handshake_outlined},
    {"name": "Jobs & Careers", "icon": Icons.work_outline_outlined},
    {"name": "Our Presence", "icon": Icons.location_city_outlined},
    {"name": "Divisions", "icon": Icons.dashboard_outlined},
    {"name": "Bioburg Group", "icon": Icons.dashboard_outlined},
  ];

  final List<String> bannerImages = [
    "assets/images/slider1.webp",
    "assets/images/slider2.webp",
    "assets/images/slider3.webp",
    "assets/images/slider4.webp",
    "assets/images/slider5.webp",
    "assets/images/slider6.webp",
    "assets/images/slider7.webp",
    "assets/images/slider8.jpeg",
  ];

  final List<Map<String, dynamic>> categoryCards = [
    {
      "title": "Nutrition",
      "img": "assets/images/med1.png",
      "price": "₹499",
      "originalPrice": "₹699",
      "rating": 4.5,
      "discount": "30% OFF"
    },
    {
      "title": "Beauty & Personal Care",
      "img": "assets/images/med2.png",
      "price": "₹299",
      "originalPrice": "₹450",
      "rating": 4.2,
      "discount": "35% OFF"
    },
    {
      "title": "Sexual Wellness",
      "img": "assets/images/med3.png",
      "price": "₹599",
      "originalPrice": "₹899",
      "rating": 4.7,
      "discount": "33% OFF"
    },
    {
      "title": "Homeopathy",
      "img": "assets/images/doctor4.png",
      "price": "₹249",
      "originalPrice": "₹399",
      "rating": 4.3,
      "discount": "38% OFF"
    },
    {
      "title": "Baby Care",
      "img": "assets/images/doctor5.png",
      "price": "₹349",
      "originalPrice": "₹499",
      "rating": 4.6,
      "discount": "30% OFF"
    },
    {
      "title": "Vitamins & Supplements",
      "img": "assets/images/med2.png",
      "price": "₹799",
      "originalPrice": "₹1199",
      "rating": 4.8,
      "discount": "33% OFF"
    },
    {
      "title": "Oral Care",
      "img": "assets/images/doctor4.png",
      "price": "₹199",
      "originalPrice": "₹299",
      "rating": 4.1,
      "discount": "33% OFF"
    },
    {
      "title": "Hair Care",
      "img": "assets/images/doctor1.png",
      "price": "₹449",
      "originalPrice": "₹649",
      "rating": 4.4,
      "discount": "31% OFF"
    },
  ];

  // Categories that have subcategories (should open bottom sheet)
  final List<String> categoriesWithSubItems = [
    "Disease",
    "Homeopathy",
    "Ayurveda",
    "Vitamin & Nutrition",
    "Personal Care",
    "Baby Care",
    "Fitness",
    "Sexual Wellness",
    "Unani",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade50,
      extendBodyBehindAppBar: true,
      
      // 🎨 LIGHT GRADIENT APP BAR
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
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
               
                child:  Image.asset(
                "assets/images/app_logo.jpeg",
                height: 90,
              ),
              ),
            ),
            title: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.min,
  children: [
    Text(
      "BioBurg",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        letterSpacing: 1.2,
        color: Colors.blue.shade800,
      ),
    ),
    const SizedBox(height: 1),
    Text(
      "जन औषधि केन्द्र",
      style: TextStyle(
        fontSize: 12,
        color: Colors.blue.shade600,
        fontWeight: FontWeight.w500,
      ),
    ),
  ],
),

            actions: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.15),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart_outlined, color: Colors.blue.shade700),
                  onPressed: () {
                    Get.to(() => CartPage());
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.15),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.menu_rounded, color: Colors.blue.shade700),
                  onPressed: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      endDrawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: const AccountDrawer(),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 110),

            // 🔝 TOP CATEGORIES
            _buildTopMenu(),
            const SizedBox(height: 20),

            // 🔍 SEARCH BAR
            _buildSearchBar(),
            const SizedBox(height: 20),

            // 🎯 TYPES SCROLLER
            _buildTypes(),
            const SizedBox(height: 20),

            // 🎠 BANNER SLIDER
            _buildBannerSlider(),
            const SizedBox(height: 25),

            // 🔥 POPULAR CATEGORIES
            _buildSectionHeader("Popular Categories", Icons.local_fire_department),
            const SizedBox(height: 15),
            horizontalCategoryCards(),
            const SizedBox(height: 25),

            // 🌿 HOMEOPATHY BANNER
            _bigHomeopathyBanner(),
            const SizedBox(height: 25),

            // 📊 TRENDING SECTION WITH PRODUCT DETAILS
            _buildSectionHeader("New Arrivals", Icons.new_releases_rounded),
            _gridCategories(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  //*********************************************************
  // 🔝 TOP MENU
  //*********************************************************
  Widget _buildTopMenu() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: topCategories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, index) {
              final category = topCategories[index];
              bool hasSubItems = categoriesWithSubItems.contains(category["name"]);
              
              return TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 400 + (index * 50)),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: GestureDetector(
                  onTap: () {
                    if (hasSubItems) {
                      Get.put(CategoryDrawerController());
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => CategoryDrawer(categoryName: category["name"]),
                      );
                    }
                  },
                  child: Container(
                    width: 95,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            category["icon"],
                            color: Colors.blue.shade700,
                            size: 26,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            category["name"],
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  //*********************************************************
  // 🔍 SEARCH BAR
  //*********************************************************
  Widget _buildSearchBar() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade300, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search medicines, health products...",
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              prefixIcon: Icon(Icons.search_rounded, color: Colors.blue.shade600, size: 26),
              suffixIcon: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.mic_rounded, color: Colors.white, size: 20),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ),
    );
  }

  //*********************************************************
  // 🎯 TYPES SCROLLER
  //*********************************************************
  Widget _buildTypes() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        height: 55,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: types.length,
          separatorBuilder: (_, __) => Container(
            width: 1,
            height: 30,
            margin: const EdgeInsets.symmetric(vertical: 12),
            color: Colors.grey.shade200,
          ),
          itemBuilder: (_, index) {
            final type = types[index];
            bool hasSubItems = categoriesWithSubItems.contains(type["name"]);
            
            return GestureDetector(
              onTap: () {
                if (hasSubItems) {
                  Get.put(CategoryDrawerController());
                  final controller = Get.find<CategoryDrawerController>();
                  if (controller.getFullCategoryData(type["name"]).isNotEmpty) {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => CategoryDrawer(categoryName: type["name"]),
                    );
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Icon(
                      type["icon"],
                      size: 18,
                      color: Colors.blue.shade600,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      type["name"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  //*********************************************************
  // 🎠 BANNER SLIDER
  //*********************************************************
  Widget _buildBannerSlider() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CarouselSlider(
            items: bannerImages.map((img) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    img,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: false,
              viewportFraction: 1.0,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentBannerIndex = index;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bannerImages.asMap().entries.map((entry) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _currentBannerIndex == entry.key ? 24 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _currentBannerIndex == entry.key
                    ? Colors.blue.shade600
                    : Colors.grey.shade300,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  //*********************************************************
  // 📝 SECTION HEADER
  //*********************************************************
  Widget _buildSectionHeader(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade600,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const Spacer(),
          // TextButton(
          //   onPressed: () {},
          //   child: Row(
          //     children: [
          //       Text(
          //         "View All",
          //         style: TextStyle(
          //           color: Colors.blue.shade600,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //       const SizedBox(width: 4),
          //       Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.blue.shade600),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  //*********************************************************
  // 🔥 HORIZONTAL CATEGORY CARDS
  //*********************************************************
 

Widget horizontalCategoryCards() {
  final CategoryController controller = Get.put(CategoryController());

  return SizedBox(
    height: 120,
    child: Obx(() {
      // *********************************************************
      // 🔥 SHIMMER LOADING WIDGET WHEN API IS LOADING
      // *********************************************************
      if (controller.isLoading.value) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: 100,
                margin: const EdgeInsets.only(right: 14),
                child: Column(
                  children: [
                    Container(
                      height: 75,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 12,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }

      // *********************************************************
      // 🔥 NO DATA CASE
      // *********************************************************
      if (controller.categories.isEmpty) {
        return const Center(child: Text("No Categories Found"));
      }

      // *********************************************************
      // 🔥 ACTUAL CATEGORY LIST
      // *********************************************************
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final item = controller.categories[index];

          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 500 + (index * 70)),
            curve: Curves.easeOutBack,
            tween: Tween(begin: 0.7, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: GestureDetector(
              onTap: () {
                // 👉 Navigate to category products page
                Get.to(() => SubCategoriesPage(categoryId: item.id, categoryTitle: item.title));
              },
              child: Container(
                width: 100,
                height: 120,
                margin: const EdgeInsets.only(right: 14),
                child: Column(
                  children: [
                    Container(
                      height: 95,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: Colors.grey.shade300, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          item.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.broken_image_outlined,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        item.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }),
  );
}


  //*********************************************************
  // 🌿 HOMEOPATHY BANNER
  //*********************************************************
  Widget _bigHomeopathyBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.asset(
                "assets/images/home_banner.jpg",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "SPECIAL OFFER",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Homeopathy Products",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //*********************************************************
  // 📊 GRID CATEGORIES WITH PRODUCT DETAILS
  //*********************************************************
  Widget _gridCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categoryCards.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final item = categoryCards[index];
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 600 + (index * 50)),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value,
                  child: child,
                ),
              );
            },
            child: GestureDetector(
              onTap: () {
                // Get.to(() => SubCategories(categoryName: item["title"]!));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image with Favorite Icon
                    Stack(
                      children: [
                        Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
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
                        // Discount Badge
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.shade600,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item["discount"],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // Favorite Icon
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.favorite_border_rounded,
                              color: Colors.red.shade400,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Product Details
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["title"]!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            const SizedBox(height: 4),
                        
                         
                            // Price Row
                            Row(
                              children: [
                                Text(
                                  item["price"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  item["originalPrice"],
                                  style: TextStyle(
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Add to Cart Button
                            SizedBox(
                              width: double.infinity,
                              height: 32,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade600,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.shopping_cart_outlined, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      "Add to Cart",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}