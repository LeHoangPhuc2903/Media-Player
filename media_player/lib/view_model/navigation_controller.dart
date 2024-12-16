import 'package:get/get.dart';

class NavigationController extends GetxController {
  void navigateTo(String routeName) {
    Get.toNamed(routeName);
  }

  void replaceWith(String routeName) {
    Get.offNamed(routeName);
  }
}
