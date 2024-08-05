import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:internshala_assignment/generated/assets.dart';

import '../../../constants/endpoints.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.goToSearch();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(Assets.pngsInternshalaLogo)
      ),
    );
  }
}
