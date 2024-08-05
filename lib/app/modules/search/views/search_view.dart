import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:internshala_assignment/app/components/empty_widget.dart';
import 'package:internshala_assignment/app/components/internship_card.dart';
import 'package:internshala_assignment/app/routes/app_pages.dart';
import 'package:internshala_assignment/generated/locales.g.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchInternshipController> {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        scrolledUnderElevation: 0.0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(LocaleKeys.internships.tr),
        centerTitle: false,
        actions: [
          Obx(() {
            if (controller.isSearch.value) {
              return SizedBox(
                width: 180,
                child: Center(
                  child: TextFormField(
                    onChanged: (String? value) {
                      controller.searchFromInternships();
                    },
                    onFieldSubmitted: (String value){
                      controller.searchedInternshipData.isEmpty
                          ? Get.snackbar(
                          LocaleKeys.notFound.tr, LocaleKeys.internshipNotFound.tr)
                          : () {};
                      controller.isSearch.value = false;
                    },
                    controller: controller.searchTextController,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(onPressed: () {
                          controller.searchedInternshipData.isEmpty
                              ? Get.snackbar(
                              LocaleKeys.notFound.tr, LocaleKeys.internshipNotFound.tr)
                              : () {};
                          controller.isSearch.value = false;
                        }, icon: const Icon(Icons.search)),
                        hintText: LocaleKeys.searchHere.tr,
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
          Obx(() {
            if (controller.isSearch.value) {
              return Container();
            }
            else {
              return IconButton(onPressed: () {
                //ToDo: Implement search function
                controller.isSearch.value = true;
              }, icon: const Icon(Icons.search));
            }
          })
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 8,),
                      InkWell(
                          onTap: () {
                            //ToDo: Go to filters page
                            Get.toNamed(Routes.FILTERS);
                          },
                          child: Container(
                            width: 80,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.lightBlue),
                              borderRadius: BorderRadius.circular(28),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const Icon(Icons.filter_alt_outlined,
                                  color: Colors.lightBlue,),
                                Text(LocaleKeys.filters.tr,
                                    style: const TextStyle(
                                      color: Colors.lightBlue,))
                              ],
                            ),
                          )
                      ),
                      const SizedBox(width: 8,),
                      Obx(() {
                        if(controller.allFilters.isNotEmpty){
                          return Wrap(
                            direction: Axis.horizontal,
                            runSpacing: 12,
                            spacing: 12,
                            children: controller.allFilters,
                          );
                        }
                        else{
                          return Container();
                        }
                      }),
                      const SizedBox(width: 8,),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Obx(() {
                  if (controller.searchedInternshipData.isNotEmpty) {
                    return Text("${controller.searchedInternshipData
                        .length}, ${LocaleKeys.totalInternships.tr}");
                  }
                  if(controller.allFilters.isNotEmpty && controller.filteredInternshipData.isEmpty){
                    return Text("${controller.filteredInternshipData
                        .length}, ${LocaleKeys.totalInternships.tr}");
                  }
                  if (controller.filteredInternshipData.isEmpty) {
                    return Text("${controller.internshipData
                        .length}, ${LocaleKeys.totalInternships.tr}");
                  } else if (controller.filteredInternshipData.isNotEmpty) {
                    return Text("${controller.filteredInternshipData
                        .length}, ${LocaleKeys.totalInternships.tr}");
                  }
                  else {
                    return Text("${controller.internshipData
                        .length}, ${LocaleKeys.totalInternships.tr}");
                  }
                })
              ],
            ),
          ),
          Obx(() {
            if (controller.searchedInternshipData.isNotEmpty) {
              return Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return InternshipCard(
                          internshipData: controller
                              .searchedInternshipData[index],
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return const SizedBox(height: 12,);
                      },
                      itemCount: controller.searchedInternshipData.length));
            }
            else if(controller.allFilters.isNotEmpty && controller.filteredInternshipData.isEmpty){
              return Expanded(child: Center(child: EmptyWidget(title: LocaleKeys.notFound.tr,),));
            }
            else if(controller.filteredInternshipData.isNotEmpty && controller.searchedInternshipData.isNotEmpty){
              return Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return InternshipCard(
                          internshipData: controller
                              .searchedInternshipData[index],
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return const SizedBox(height: 12,);
                      },
                      itemCount: controller.searchedInternshipData.length));
            }
            else if (controller.internshipData.isNotEmpty &&
                controller.searchedInternshipData.isEmpty) {
              return Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return InternshipCard(
                          internshipData:
                          controller.filteredInternshipData.isEmpty
                              ? controller.internshipData[index]
                              : controller.filteredInternshipData[index],
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return const SizedBox(height: 12,);
                      },
                      itemCount: controller.filteredInternshipData.isEmpty
                          ? controller.internshipData.length
                          : controller.filteredInternshipData.length));
            } else if (controller.internshipData.isEmpty &&
                controller.searchedInternshipData.isEmpty) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.lightBlue,));
            } else {
              return Container(
                  decoration: const BoxDecoration(
                      color: Colors.white
                  ),
                  child: Center(child: EmptyWidget(title: LocaleKeys.noDataFound.tr))
              );
            }
          }),
        ],
      ),
    );
  }
}

