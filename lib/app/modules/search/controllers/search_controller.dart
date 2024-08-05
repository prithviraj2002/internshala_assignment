import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internshala_assignment/app/services/api_manager/api_manager.dart';
import 'package:internshala_assignment/app/routes/app_pages.dart';

import '../../../../generated/locales.g.dart';
import '../../../data/model/internship_data_model.dart';

class SearchInternshipController extends GetxController {
  TextEditingController searchTextController = TextEditingController();
  TextEditingController startingDateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController profileController = TextEditingController();

  RxList<InternshipData> internshipData = <InternshipData>[].obs;
  RxList<InternshipData> searchedInternshipData = <InternshipData>[].obs;
  RxList<InternshipData> filteredInternshipData = <InternshipData>[].obs;

  RxBool isSearch = false.obs;

  List<int> monthDuration = [
    1,2,3,4,6,12,24,36
  ];

  RxInt selectedMonthDuration = 0.obs;

  List<String> profiles = [
    LocaleKeys.administrationIntern.tr,
    LocaleKeys.administrationInterRemote.tr,
    LocaleKeys.brandManagementIntern.tr,
    LocaleKeys.androidAppDevelopmentIntern.tr,
    LocaleKeys.businessAnalyticsIntern.tr,
    LocaleKeys.productManagementIntern.tr,
    LocaleKeys.dataScienceIntern.tr,
  ];

  RxList<String> selectedProfiles = <String>[].obs;

  RxList<String> searchedProfiles = <String>[].obs;

  List<String> cities = [
    LocaleKeys.gurgaon.tr,
    LocaleKeys.munnar.tr,
    LocaleKeys.tarnTaran.tr,
    LocaleKeys.bangaPhilipines.tr,
    LocaleKeys.delhi.tr,
    LocaleKeys.delhiNcr.tr,
    LocaleKeys.bangalore.tr,
    LocaleKeys.hyderabad.tr,
    LocaleKeys.kolkata.tr,
    LocaleKeys.chennai.tr,
    LocaleKeys.ahmedabad.tr,
  ];

  RxList<String> selectedCities = <String>[].obs;

  RxList<String> searchedCities = <String>[].obs;

  RxList<FilterChip> allFilters = <FilterChip>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

  void searchFromInternships(){
    String searchText = searchTextController.text;
    searchedInternshipData.value = [];
    for(InternshipData data in internshipData){
      if(data.title!.toLowerCase() == searchText.toLowerCase() || data.title!.toLowerCase().contains(searchText.toLowerCase())){
        searchedInternshipData.add(data);
      }
    }
  }

  void searchFromCities(){
    searchedCities.value = [];
    String cityText = cityController.text;
    for(String city in cities){
      if(city.toLowerCase() == cityText.toLowerCase() || city.toLowerCase().contains(cityText.toLowerCase())){
        searchedCities.add(city);
      }
    }
  }

  void searchFromProfiles(){
    searchedProfiles.value = [];
    String profileText = profileController.text;
    for(String profile in profiles){
      if(profileText.toLowerCase() == profile.toLowerCase() || profile.toLowerCase().contains(profileText.toLowerCase())){
        searchedProfiles.add(profile);
      }
    }
  }

  void applyFilters(){
    filteredInternshipData.value = [];
    allFilters.value = [];
    if(selectedProfiles.isNotEmpty){
      for(String profile in selectedProfiles){
        allFilters.add(
            FilterChip(
              selected: true,
              selectedColor: Colors.lightBlue,
              backgroundColor: Colors.white,
              label: Text(
                profile,
                style: const TextStyle(color: Colors.white),
              ), onSelected: (bool value) {  },
            )
        );
        for(InternshipData data in internshipData){
          if(data.title == profile){
            filteredInternshipData.contains(data) ? (){} : filteredInternshipData.add(data);
          }
        }
      }
    }

    if(selectedCities.isNotEmpty){
      for(String city in selectedCities){
        allFilters.add(
            FilterChip(
              selected: true,
              selectedColor: Colors.lightBlue,
              backgroundColor: Colors.white,
              label: Text(
                city,
                style: const TextStyle(color: Colors.white),
              ), onSelected: (bool value) {  },
            )
        );
        for(InternshipData data in internshipData){
          List<String?> locationNames = data.locationNames ?? [];
          if(locationNames.isEmpty){
            () {};
          }
          else if(locationNames.isNotEmpty){
            String firstLocation = locationNames.first ?? "";
            if(firstLocation == city && firstLocation.isNotEmpty){
              filteredInternshipData.contains(data) ? (){} : filteredInternshipData.add(data);
            }
          }
        }
      }
    }

    if(selectedMonthDuration.value > 0 ){
      allFilters.add(
          FilterChip(
            selected: true,
            selectedColor: Colors.lightBlue,
            backgroundColor: Colors.white,
            label: Text(
              "${selectedMonthDuration.value} months",
              style: const TextStyle(color: Colors.white),
            ), onSelected: (bool value) {  },
          )
      );
      for(InternshipData data in internshipData){
        if(int.parse(data.duration![0]) == selectedMonthDuration.value){
          filteredInternshipData.contains(data) ? (){} : filteredInternshipData.add(data);
        }
      }
    }
  }

  void clearAll(){
    selectedMonthDuration.value = 0;
    filteredInternshipData.value = [];
    allFilters.value = [];
    selectedProfiles.value = [];
    selectedCities.value = [];
  }

  Future<void> getData() async{
    List<dynamic> internshipIDs = [];
    try{
      final data = await APIManager.getInternshipData();
      Map<String, dynamic> result = jsonDecode(data.body);
      if(data.statusCode == 200){
        internshipIDs = result['internship_ids'];
        for(int i = 0; i < internshipIDs.length; i++){
          internshipData.add(InternshipData.fromJson(result['internships_meta'][internshipIDs[i].toString()]));
        }
      } else{
        Get.snackbar(LocaleKeys.error.tr, LocaleKeys.somethingWentWrong.tr);
      }
    } catch(e){
      Get.snackbar(LocaleKeys.error.tr, LocaleKeys.somethingWentWrong.tr);
      rethrow;
    }
  }
}
