import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knovatortest/Controller/fireDBController.dart';
import 'package:knovatortest/Controller/homeController.dart';
import 'package:knovatortest/Modal/resumeModal.dart';

import '../Themes/appColors.dart';
import '../Themes/themeStyle.dart';

class ResumePreviewView extends StatelessWidget {
  FireDBController fireDBController = Get.put(FireDBController());
  HomeController homeController = Get.put(HomeController());
  RxBool isLoading = false.obs;

  loadData() async {
    isLoading.value = true;
    await fireDBController.getEduData(resumeID: homeController.resumeID.value);
    await fireDBController.getWorkExpData(
        resumeID: homeController.resumeID.value);
    await fireDBController.getProjectData(
        resumeID: homeController.resumeID.value);
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    ResumeModal resumeModal = Get.arguments['data'];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.whiteColor,
            )),
        title: Text("Preview"),
      ),
      body: Obx(
        () => isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                ),
              )
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.whiteColor,
                ),
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: Get.width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.greyColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Text(
                              resumeModal.name,
                              style: CustomTextStyle.text1,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 65,
                                      ),
                                      _customContainer(title: "ABOUT ME"),
                                      _customText(
                                          title:
                                              "Github : ${resumeModal.githubUrl}"),
                                      _customText(
                                          title:
                                              "LinkedIn : ${resumeModal.linkedInUrl}"),
                                      _customContainer(title: "CONTACT INFO"),
                                      _customText(title: resumeModal.phoneNum),
                                      _customText(title: resumeModal.email),
                                      _customText(title: resumeModal.address),
                                      _customContainer(title: "LANGUAGES"),
                                      _customText(
                                          title: resumeModal.languages,
                                          maxLine: 3),
                                      _customContainer(title: "ACHIEVEMENTS"),
                                      _customText(
                                          title: resumeModal.achivements),
                                      _customContainer(title: "INTARESTS"),
                                      _customText(title: resumeModal.interests),
                                      _customContainer(title: "OBJECTIVE"),
                                      _customText(
                                          title: resumeModal.objective,
                                          maxLine: 3),
                                      SizedBox(height: 5)
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _titleText(title: "WORK EXPERIENCE"),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          fireDBController.workExpModal.length,
                                      itemBuilder: (context, index) {
                                        var workData = fireDBController
                                            .workExpModal[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    _customText(
                                                        title: workData.compName
                                                            .toString(),
                                                        maxLine: 2),
                                                    _customText(
                                                        title:
                                                            "${workData.joinDate.toString()}\n${workData.endDate.toString()}",
                                                        maxLine: 2)
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    _customText(
                                                        title: workData.jobName
                                                            .toString(),
                                                        maxLine: 2),
                                                    _customText(
                                                        title: workData.desc,
                                                        maxLine: 2)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    _titleText(title: "EDUCATION"),
                                    ListView.builder(
                                      itemCount:
                                          fireDBController.addEduModal.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        var eduData = fireDBController
                                            .educationModal[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    _customText(
                                                        title: eduData.name,
                                                        maxLine: 2),
                                                    _customText(
                                                        title:
                                                            "${eduData.joinYear} to ${eduData.endYear}",
                                                        maxLine: 2)
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    _customText(
                                                        title: eduData.course
                                                            .toString(),
                                                        maxLine: 2),
                                                    _customText(
                                                        title: eduData
                                                            .percentage
                                                            .toString(),
                                                        maxLine: 2)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    _titleText(title: "PROJECT"),
                                    ListView.builder(
                                      itemCount:
                                          fireDBController.projectModal.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        var projectData = fireDBController
                                            .projectModal[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _customText(
                                                  title: projectData.projName,
                                                  maxLine: 1),
                                              _customText(
                                                  title: projectData.desc
                                                      .toString(),
                                                  maxLine: 3),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 30, 5, 20),
                        child: CircleAvatar(
                          backgroundColor: AppColors.blackColor,
                          maxRadius: 70,
                          minRadius: 50,
                          backgroundImage: NetworkImage(resumeModal.photoUrl),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  _customContainer({String title = ""}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: Get.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: AppColors.blackColor),
      height: 20,
      child: Text(
        title,
        style: CustomTextStyle.text4,
      ),
    );
  }

  _customText({String title = "", int maxLine = 1}) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLine,
      style: Get.textTheme.labelMedium,
    );
  }

  _titleText({String title = ""}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Get.textTheme.titleMedium,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4, left: 3),
              child: Divider(
                thickness: 2.0,
                color: Get.theme.dividerColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
