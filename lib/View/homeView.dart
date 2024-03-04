import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:resume_maker/Controller/fireDBController.dart';
import 'package:resume_maker/Controller/homeController.dart';
import 'package:resume_maker/Localization/iconAssets.dart';
import 'package:resume_maker/Routes/pages.dart';
import 'package:resume_maker/Themes/appColors.dart';
import 'package:resume_maker/Themes/themeStyle.dart';
import 'package:resume_maker/Widgets/customButton.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key});
  FireDBController fireDBController = Get.put(FireDBController());
  HomeController homeController = Get.put(HomeController());
  RxBool isLoading = false.obs;
  loadData() async {
    isLoading.value = true;
    await fireDBController.getData();
    isLoading.value = false;
  }

  Future<void> pullRequest() async {
    fireDBController.getData();
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      appBar: AppBar(
        title: Text("resumebuilder".tr),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
                onPressed: () {
                  homeController.selecTedID.value = "";
                  homeController.selectedIndex.value = 0;
                  Get.toNamed(Routes.AddUpdateResumeView);
                },
                icon: Icon(
                  IconAssets.addIcon,
                  size: 35,
                  color: AppColors.whiteColor,
                )),
          )
        ],
      ),
      body: LiquidPullToRefresh(
        onRefresh: pullRequest,
        color: Colors.transparent,
        backgroundColor: AppColors.whiteColor,
        showChildOpacityTransition: false,
        child: Obx(
          () => isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.deepBlueColor,
                    backgroundColor: AppColors.whiteColor,
                  ),
                )
              : fireDBController.resumeModal.isEmpty
                  ? Center(
                      child: Text(
                        "resumeisempty".tr,
                        style: CustomTextStyle.text1,
                      ),
                    )
                  : ListView.builder(
                      itemCount: fireDBController.resumeModal.length,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          width: Get.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 5),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.whiteColor),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        homeController.selecTedID.value =
                                            fireDBController
                                                .resumeModal[index].id;
                                        homeController.selecTedID.value =
                                            fireDBController
                                                .resumeModal[index].id;
                                        homeController.selectedIndex.value =
                                            index;
                                        Get.toNamed(Routes.AddUpdateResumeView);
                                      },
                                      icon: Icon(
                                        IconAssets.editIcon,
                                        color: AppColors.darkGreenColor,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        fireDBController.deleteResume(
                                            fireDBController
                                                .resumeModal[index].id);
                                        fireDBController.getData();
                                      },
                                      icon: Icon(
                                        IconAssets.deleteIcon,
                                        color: AppColors.redColor,
                                      ))
                                ],
                              ),
                              ListTile(
                                leading: Container(
                                  height: 80,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(fireDBController
                                              .resumeModal[index].photoUrl),
                                          fit: BoxFit.contain)),
                                ),
                                title: Text(
                                  fireDBController.resumeModal[index].name,
                                  style: Get.textTheme.labelMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  fireDBController.resumeModal[index].email,
                                  style: CustomTextStyle.text5,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(),
                                width: Get.width / 2,
                                height: 40,
                                child: CustomButton(
                                  onTap: () {
                                    homeController.selecTedID.value =
                                        fireDBController.resumeModal[index].id;
                                    Get.toNamed(Routes.ResumePreviewView,
                                        arguments: {
                                          'data': fireDBController
                                              .resumeModal[index]
                                        });
                                  },
                                  child: Text(
                                    "preview".tr,
                                    style: CustomTextStyle.text1,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
