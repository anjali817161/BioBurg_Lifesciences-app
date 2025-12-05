import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bioburg_lifescience/modules/auth/login/view/login_view.dart';

class SelectUserTypeView extends StatefulWidget {
  const SelectUserTypeView({super.key});

  @override
  State<SelectUserTypeView> createState() => _SelectUserTypeViewState();
}

class _SelectUserTypeViewState extends State<SelectUserTypeView>
    with SingleTickerProviderStateMixin {
  int selected = -1;

  late AnimationController _controller;
  late Animation<double> _jumpAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );

    _jumpAnimation = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onTap(int index) async {
    setState(() => selected = index);

    await _controller.forward();
    await _controller.reverse();

    // Navigate to login page with user type
    String userType = '';
    switch (index) {
      case 0:
        userType = 'User';
        break;
      case 1:
        userType = 'Corporate';
        break;
     
    }
    Get.to(() => LoginSignupPage(userType: userType));
  }

  Widget buildBox({
    required String title,
    required String image,
    required int index,
  }) {
    bool isSelected = (selected == index);

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: ScaleTransition(
          scale: isSelected ? _jumpAnimation : AlwaysStoppedAnimation(1.0),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color:  Colors.white,
              border: Border.all(
                color: isSelected ? Colors.blueAccent : Colors.white12,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image animation
                AnimatedScale(
                  duration: const Duration(milliseconds: 250),
                  scale: isSelected ? 1.13 : 1.0,
                  curve: Curves.easeOutBack,
                  child: Image.asset(
                    image,
                    height:150,
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text(
              "Select User Type",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Choose how you want to log in",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 40),

            /// 🔥 FOUR CARDS IN 2x2 GRID
            Column(
              children: [
                Row(
                  children: [
                    buildBox(
                      title: "User login",
                      image: "assets/images/doctor1.png",
                      index: 0,
                    ),
                    buildBox(
                      title: "Corporate login",
                      image: "assets/images/med1.png",
                      index: 1,
                    ),
                  ],
                ),
                // const SizedBox(height: 20),
                // Row(
                //   children: [
                //     buildBox(
                //       title: "Vendor login",
                //       image: "assets/images/doctor2.png",
                //       index: 2,
                //     ),
                //     buildBox(
                //       title: "B2C login",
                //       image: "assets/images/doctor3.png",
                //       index: 3,
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
