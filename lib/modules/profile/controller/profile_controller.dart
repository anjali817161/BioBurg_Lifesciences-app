import 'package:get/get.dart';

class ProfileController extends GetxController {
  var userName = "John Doe".obs;
  var userId = "".obs;
  var userEmail = "john.doe@example.com".obs;
  var walletBalance = "₹ 2,450".obs;
  var rewardPoints = "320".obs;

  var totalOrders = 18.obs;
  var pendingOrders = 3.obs;
  var deliveredOrders = 15.obs;
}
