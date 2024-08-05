import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../routes/app_pages.dart';
import '../controllers/search_controller.dart';

class FiltersView extends GetView<SearchInternshipController> {
  const FiltersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(LocaleKeys.filters.tr),
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_rounded)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                controller.clearAll();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.lightBlue)),
                child: Center(
                  child: Text(
                    LocaleKeys.clearAll.tr,
                    style: const TextStyle(color: Colors.lightBlue),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                controller.applyFilters();
                Get.back();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.lightBlue)),
                child: Center(
                  child: Text(
                    LocaleKeys.apply.tr,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Text(LocaleKeys.profile.tr),
              const SizedBox(
                height: 12,
              ),
              Obx(() {
                if(controller.selectedProfiles.isEmpty){
                  return InkWell(
                    onTap: () {
                      Get.toNamed(Routes.ADDPROFILE);
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.add,
                          color: Colors.lightBlue,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          LocaleKeys.addProfile.tr,
                          style: const TextStyle(color: Colors.lightBlue),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Wrap(
                      direction: Axis.horizontal,
                      runSpacing: 12,
                      spacing: 12,
                      children: List.generate(
                          controller.selectedProfiles.length,
                              (int index) {
                            return FilterChip(
                              deleteIcon: const Icon(Icons.close, color: Colors
                                  .white, size: 16),
                              onDeleted: () {
                                controller.selectedProfiles.removeAt(index);
                              },
                              avatar: Container(),
                              selected: true,
                              selectedColor: Colors.lightBlue,
                              backgroundColor: Colors.white,
                              label: Text(
                                controller.selectedProfiles[index],
                                style: const TextStyle(color: Colors.white),
                              ),
                              onSelected: (bool isSelected) {
                                if (isSelected) {

                                }
                              },
                            );
                          }
                      )
                  );
                }
              }),
              const SizedBox(
                height: 16,
              ),
              Text(LocaleKeys.city.tr),
              const SizedBox(
                height: 16,
              ),
              Obx(() {
                if (controller.selectedCities.isEmpty) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(Routes.ADDCITY);
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.add,
                          color: Colors.lightBlue,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          LocaleKeys.addCity.tr,
                          style: const TextStyle(color: Colors.lightBlue),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Wrap(
                      direction: Axis.horizontal,
                      runSpacing: 12,
                      spacing: 12,
                      children: List.generate(
                          controller.selectedCities.length,
                              (int index) {
                            return FilterChip(
                              deleteIcon: const Icon(Icons.close, color: Colors
                                  .white, size: 16),
                              onDeleted: () {
                                controller.selectedCities.removeAt(index);
                              },
                              avatar: Container(),
                              selected: true,
                              selectedColor: Colors.lightBlue,
                              backgroundColor: Colors.white,
                              label: Text(
                                controller.selectedCities[index],
                                style: const TextStyle(color: Colors.white),
                              ),
                              onSelected: (bool isSelected) {
                                if (isSelected) {

                                }
                              },
                            );
                          }
                      )
                  );
                }
              }),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(LocaleKeys.maxDuration.tr),
                  const SizedBox(
                    width: 8,
                  ),
                  Text("(${LocaleKeys.inMonths.tr})")
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButtonFormField(
                  dropdownColor: Colors.white,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  hint: Text(LocaleKeys.chooseDuration.tr),
                  items: List.generate(
                      controller.monthDuration.length,
                          (int index) =>
                          DropdownMenuItem(
                            value: controller.monthDuration[index],
                            child: Text(
                                controller.monthDuration[index].toString()),
                          )),
                  onChanged: (int? value) {
                    if (value != null) {
                      controller.selectedMonthDuration.value = value;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
