import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_maker/Controller/fireDBController.dart';
import 'package:resume_maker/Controller/homeController.dart';
import 'package:resume_maker/Themes/appColors.dart';
import 'package:resume_maker/Utility/logger.dart';

class ProjectView extends StatefulWidget {
  ProjectView({super.key});

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  FireDBController fireDBController = Get.put(FireDBController());

  RxBool isLoading = false.obs;

  RxSet<int> selectedIndices = <int>{}.obs;

  loadData() async {
    isLoading.value = true;
    await fireDBController.getProjectData(resumeID: "pLboDreG1UgnVTjWvTDS");
    isLoading.value = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Project ",
        ),
        actions: [
          IconButton(
              onPressed: () async {
                if (selectedIndices.isEmpty) {
                  logger.i("Selecct atleas one project");
                } else {
                  await fireDBController.selectProjectData();

                  logger.i("selected ID : $selectedIndices");
                }
              },
              icon: Icon(
                Icons.navigate_next_sharp,
                color: Colors.white,
              ))
        ],
      ),
      body: Obx(() => isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
              itemCount: fireDBController.projectModal.length,
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final isSelected = selectedIndices.contains(index);
                return InkWell(
                  // jzXvBypkJNX4kuz2eMXx
                  onTap: () async {
                    if (isSelected) {
                      selectedIndices.remove(index);
                    } else {
                      selectedIndices.add(index);
                      await fireDBController.selectProjectModalData(
                          projectId: fireDBController.projectModal[index].id,
                          name: fireDBController.projectModal[index].projName,
                          desc: fireDBController.projectModal[index].desc);
                      logger.i(
                          "sfdedad : ${fireDBController.selectedProjModal[0].projectID}");
                    }
                    logger.i("selected index : $selectedIndices");
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.whiteColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          fireDBController.projectModal[index].projName,
                          style: Get.textTheme.labelMedium,
                        ),
                        Text(
                          fireDBController.projectModal[index].desc,
                          style: Get.textTheme.labelMedium,
                        ),
                        !isSelected
                            ? Icon(
                                Icons.circle_outlined,
                                color: Colors.black,
                                size: 20,
                              )
                            : Icon(
                                Icons.check_circle,
                                color: AppColors.blueColor,
                                size: 20,
                              )
                      ],
                    ),
                  ),
                );
              },
            )),
    );
  }
}
