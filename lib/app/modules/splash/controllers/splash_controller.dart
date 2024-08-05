import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  void goToSearch(){
    Future.delayed(const Duration(seconds: 3), (){
      Get.offAllNamed(Routes.SEARCH);
    });
  }
}
