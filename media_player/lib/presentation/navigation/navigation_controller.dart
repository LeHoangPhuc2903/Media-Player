import 'package:get/get.dart';

class NavigationController extends GetxController {
  
  void navigateTo(String routeName) {
    Get.toNamed(routeName);
  }

  void replaceWith(String routeName) {
    Get.offNamed(routeName);
  }

  void goBack() {
    if (Get.previousRoute.isNotEmpty) {
      Get.back();
    } else {
      print("Không thể quay lại, đang ở trang đầu tiên!");
    }
  }

  void navigateOrBack(String routeName) {
    if (Get.currentRoute == routeName) {
      Get.back();
    } else {
      navigateTo(routeName);
    }
  }

  void debugNavigation() {
    print("Route hiện tại: ${Get.currentRoute}");
    print("Route trước đó: ${Get.previousRoute}");
  }
}

