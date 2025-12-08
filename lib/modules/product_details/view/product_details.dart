import 'package:bioburg_lifescience/modules/product_details/controller/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductDetailsController controller =
      Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Obx(() => Text(controller.product['name']?.toString() ?? '')),
        backgroundColor: Colors.white,
      ),

      bottomNavigationBar: _bottomAddToCartBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _productImage(),
            _titleSection(),
            _priceSection(),
            Divider(),
            _deliverySection(),
            Divider(),
            _aboutSection(),
            Divider(),
            _relatedProductsTitle(),
            _relatedGrid(),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // IMAGE
  // -------------------------------------------------------------------
  Widget _productImage() {
    return Container(
      height: 260,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: Obx(() => Image.asset(
            "assets/images/slider2.webp",
            fit: BoxFit.contain,
          )),
    );
  }

  // -------------------------------------------------------------------
  // TITLE + DESCRIPTION
  // -------------------------------------------------------------------
  Widget _titleSection() {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.product['name']?.toString() ?? '',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),

              SizedBox(height: 8),

              Text(
                controller.product['short_description']?.toString() ?? '',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              SizedBox(height: 8),

              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Text("${controller.product['rating']?.toString() ?? ''} "),
                        Icon(Icons.star, size: 14, color: Colors.orange),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Text("46 Ratings"),
                ],
              ),
            ],
          ),
        ));
  }

  // -------------------------------------------------------------------
  // PRICE AREA
  // -------------------------------------------------------------------
  Widget _priceSection() {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Text(
                "₹${controller.product['price']}",
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 8),
              Text(
                "₹${controller.product['mrp']}",
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 8),
              Text(
                "25% OFF",
                style: TextStyle(
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }

  // -------------------------------------------------------------------
  // DELIVERY SECTION
  // -------------------------------------------------------------------
  Widget _deliverySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Delivery",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 10),
          _deliveryRow("Standard Delivery in 2 - 4 days"),
          _deliveryRow("Cash on Delivery available @ ₹50"),
          _deliveryRow("7 Days Easy Return"),
        ],
      ),
    );
  }

  Widget _deliveryRow(String text) {
    return Row(
      children: [
        Icon(Icons.check_circle, size: 18, color: Colors.green),
        SizedBox(width: 10),
        Expanded(child: Text(text)),
      ],
    );
  }

  // -------------------------------------------------------------------
  // ABOUT PRODUCT
  // -------------------------------------------------------------------
  Widget _aboutSection() {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("About Product",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              Text(
                controller.product['description']?.toString() ?? '',
                style: TextStyle(fontSize: 14, height: 1.4),
              ),
            ],
          ),
        ));
  }

  // -------------------------------------------------------------------
  // RELATED TITLE
  // -------------------------------------------------------------------
  Widget _relatedProductsTitle() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text("Related Products",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    );
  }

  // -------------------------------------------------------------------
  // RELATED GRID VIEW
  // -------------------------------------------------------------------
  Widget _relatedGrid() {
    return Obx(() => GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.relatedProducts.length,
          padding: EdgeInsets.symmetric(horizontal: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .68,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            var item = controller.relatedProducts[index];

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      spreadRadius: 1)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                     "assets/images/slider1.webp",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item['name']?.toString() ?? '',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "₹${item['price']?.toString() ?? ''}",
                      style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            );
          },
        ));
  }

  // -------------------------------------------------------------------
  // ADD TO CART BOTTOM BAR
  // -------------------------------------------------------------------
  Widget _bottomAddToCartBar() {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300, blurRadius: 4, offset: Offset(0, -2))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Add ₹426 more for FREE Delivery",
              style: TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: 120,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {},
              child: Text("Add to Cart"),
            ),
          )
        ],
      ),
    );
  }
}
