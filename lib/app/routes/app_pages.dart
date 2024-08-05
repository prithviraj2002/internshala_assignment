import 'package:get/get.dart';
import 'package:internshala_assignment/app/modules/search/views/add_city_view.dart';
import 'package:internshala_assignment/app/modules/search/views/add_profile_view.dart';
import 'package:internshala_assignment/app/modules/search/views/filters_view.dart';

import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.FILTERS,
      page: () => const FiltersView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.ADDCITY,
      page: () => AddCityView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.ADDPROFILE,
      page: () => AddProfileView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
  ];
}
