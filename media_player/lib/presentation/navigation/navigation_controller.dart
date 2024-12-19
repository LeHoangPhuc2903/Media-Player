import 'package:get/get.dart';

class NavigationController extends GetxController {
  // Điều hướng tới một trang mới
  void navigateTo(String routeName) {
    Get.toNamed(routeName);
  }

  // Thay thế trang hiện tại bằng trang mới
  void replaceWith(String routeName) {
    Get.offNamed(routeName);
  }

  // Quay lại trang trước
  void goBack() {
    if (Get.previousRoute.isNotEmpty) {
      Get.back();
    } else {
      print("Không thể quay lại, đang ở trang đầu tiên!");
    }
  }

  // Chuyển hướng tới một trang cụ thể hoặc quay lại nếu đang ở đó
  void navigateOrBack(String routeName) {
    if (Get.currentRoute == routeName) {
      Get.back();
    } else {
      navigateTo(routeName);
    }
  }

  // Đăng ký và in lịch sử điều hướng (debugging)
  void debugNavigation() {
    print("Route hiện tại: ${Get.currentRoute}");
    print("Route trước đó: ${Get.previousRoute}");
  }
}

