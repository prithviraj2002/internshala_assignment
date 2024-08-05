import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:internshala_assignment/app/modules/search/controllers/search_controller.dart';

import '../../../../generated/locales.g.dart';

class AddProfileView extends GetView<SearchInternshipController> {
  const AddProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(LocaleKeys.profile.tr),
        centerTitle: false,
        actions: [
          TextButton(onPressed: () {
            controller.selectedProfiles.value = [];
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
          )
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
                controller.searchFromProfiles();
              },
              onFieldSubmitted: (String value) {
                controller.searchFromProfiles();
                controller.searchedProfiles.isEmpty ? Get.snackbar(
                    LocaleKeys.notFound.tr, LocaleKeys.profileNotFound.tr) : () {};
              },
              controller: controller.profileController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(onPressed: () {
                  controller.searchFromProfiles();
                  controller.searchedProfiles.isEmpty ? Get.snackbar(
                      LocaleKeys.notFound.tr, LocaleKeys.profileNotFound.tr) : () {};
                }, icon: const Icon(Icons.search)),
                hintText: LocaleKeys.searchHere.tr,
              ),
            ),
            Obx(() {
              if (controller.selectedProfiles.isEmpty) {
                return Container();
              } else if (controller.selectedProfiles.isNotEmpty) {
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
              } else {
                return Container();
              }
            }),
            const SizedBox(height: 20,),
            Obx(() {
              if (controller.searchedProfiles.isNotEmpty) {
                return Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return Row(
                        children: <Widget>[
                          Obx(() {
                            return Checkbox(
                                activeColor: Colors.lightBlue,
                                value: controller.selectedProfiles.contains(
                                    controller.searchedProfiles[index]),
                                onChanged: (bool? isSelected) {
                                  if (isSelected!) {
                                    controller.selectedProfiles.add(
                                        controller.searchedProfiles[index]);
                                  } else {
                                    controller.selectedProfiles.remove(
                                        controller.searchedProfiles[index]);
                                  }
                                }
                            );
                          }),
                          const SizedBox(width: 8,),
                          Text(controller.searchedProfiles[index]),
                        ],
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return const SizedBox(height: 12,);
                    },
                    itemCount: controller.searchedProfiles.length,
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return Row(
                        children: <Widget>[
                          Obx(() {
                            return Checkbox(
                                activeColor: Colors.lightBlue,
                                value: controller.selectedProfiles.contains(
                                    controller.profiles[index]),
                                onChanged: (bool? isSelected) {
                                  if (isSelected!) {
                                    controller.selectedProfiles.add(
                                        controller.profiles[index]);
                                  } else {
                                    controller.selectedProfiles.remove(
                                        controller.profiles[index]);
                                  }
                                }
                            );
                          }),
                          const SizedBox(width: 8,),
                          Text(controller.profiles[index]),
                        ],
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return const SizedBox(height: 12,);
                    },
                    itemCount: controller.profiles.length,
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
