import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:internshala_assignment/generated/locales.g.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      locale: const Locale('en', 'US'),
      translationsKeys: AppTranslation.translations,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
