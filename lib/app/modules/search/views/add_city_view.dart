import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:internshala_assignment/app/modules/search/controllers/search_controller.dart';

import '../../../../generated/locales.g.dart';

class AddCityView extends GetView<SearchInternshipController> {
  const AddCityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(LocaleKeys.city.tr),
        centerTitle: false,
        actions: [
          TextButton(onPressed: () {
            controller.selectedCities.value = [];
          },
              child: Text(LocaleKeys.clearAll.tr,
                style: const TextStyle(color: Colors.lightBlue),)
          ),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 30,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  LocaleKeys.apply.tr, style: const TextStyle(color: Colors.white),),
              ),
            ),
          ),
          const SizedBox(width: 8,),
        ],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10,),
            TextFormField(
              onChanged: (String? value) {
                controller.searchFromCities();
              },
              controller: controller.cityController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(onPressed: () {
                  controller.searchFromCities();
                  controller.searchedCities.isEmpty ? Get.snackbar(LocaleKeys.notFound.tr, LocaleKeys.cityNotFound.tr) : () {};
                }, icon: const Icon(Icons.search)),
                hintText: LocaleKeys.searchCity.tr,
              ),
            ),
            Obx(() {
              if (controller.selectedCities.isEmpty) {
                return Container();
              } else if (controller.selectedCities.isNotEmpty) {
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
              } else {
                return Container();
              }
            }),
            const SizedBox(height: 20,),
            Obx(() {
              if(controller.searchedCities.isNotEmpty){
                return Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return Row(
                        children: <Widget>[
                          Obx(() {
                            return Checkbox(
                                activeColor: Colors.lightBlue,
                                value: controller.selectedCities.contains(
                                    controller.cities[index]),
                                onChanged: (bool? isSelected) {
                                  if (isSelected!) {
                                    controller.selectedCities.add(
                                        controller.cities[index]);
                                  } else {
                                    controller.selectedCities.remove(
                                        controller.cities[index]);
                                  }
                                }
                            );
                          }),
                          const SizedBox(width: 8,),
                          Text(controller.searchedCities[index]),
                        ],
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return const SizedBox(height: 12,);
                    },
                    itemCount: controller.searchedCities.length,
                  ),
                );
              } else{
                return Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return Row(
                        children: <Widget>[
                          Obx(() {
                            return Checkbox(
                                activeColor: Colors.lightBlue,
                                value: controller.selectedCities.contains(
                                    controller.cities[index]),
                                onChanged: (bool? isSelected) {
                                  if (isSelected!) {
                                    controller.selectedCities.add(
                                        controller.cities[index]);
                                  } else {
                                    controller.selectedCities.remove(
                                        controller.cities[index]);
                                  }
                                }
                            );
                          }),
                          const SizedBox(width: 8,),
                          Text(controller.cities[index]),
                        ],
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return const SizedBox(height: 12,);
                    },
                    itemCount: controller.cities.length,
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
