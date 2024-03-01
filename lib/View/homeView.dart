import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knovatortest/Controller/fireDBController.dart';
import 'package:knovatortest/Controller/homeController.dart';
import 'package:knovatortest/Routes/pages.dart';
import 'package:knovatortest/Themes/appColors.dart';
import 'package:knovatortest/Themes/themeStyle.dart';
import 'package:knovatortest/Widgets/customButton.dart';

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

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Resume Builder"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
                onPressed: () {
                  Get.toNamed(Routes.AddUpdateResumeView);
                },
                icon: Icon(
                  Icons.add,
                  size: 35,
                  color: AppColors.whiteColor,
                )),
          )
        ],
      ),
      body: Obx(
        () => isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.deepBlueColor,
                  backgroundColor: AppColors.whiteColor,
                ),
              )
            : ListView.builder(
                itemCount: fireDBController.resumeModal.length,
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    width: Get.width,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    padding: EdgeInsets.symmetric(vertical: 5),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.whiteColor),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.toNamed(Routes.AddUpdateResumeView);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: AppColors.darkGreenColor,
                                )),
                            IconButton(
                                onPressed: () {
                                  fireDBController.deleteResume(
                                      fireDBController.resumeModal[index].id);
                                },
                                icon: Icon(
                                  Icons.delete,
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
                          width: Get.width / 2,
                          height: 40,
                          child: CustomButton(
                            onTap: () {
                              homeController.resumeID.value =
                                  fireDBController.resumeModal[index].id;
                              Get.toNamed(Routes.ResumePreviewView, arguments: {
                                'data': fireDBController.resumeModal[index]
                              });
                            },
                            child: Text(
                              "Preview",
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
    );
  }
}
