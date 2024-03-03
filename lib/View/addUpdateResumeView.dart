import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:knovatortest/Controller/fireDBController.dart';
import 'package:knovatortest/Controller/homeController.dart';
import 'package:knovatortest/Localization/iconAssets.dart';
import 'package:knovatortest/Localization/imageAssets.dart';
import 'package:knovatortest/Routes/pages.dart';
import 'package:knovatortest/Themes/appColors.dart';
import 'package:knovatortest/Themes/customTextFormField.dart';
import 'package:knovatortest/Themes/themeStyle.dart';
import 'package:knovatortest/Widgets/customButton.dart';

class AddUpdateResumeView extends StatefulWidget {
  @override
  State<AddUpdateResumeView> createState() => _AddUpdateResumeViewState();
}

class _AddUpdateResumeViewState extends State<AddUpdateResumeView> {
  FireDBController fireDBController = Get.put(FireDBController());
  HomeController homeController = Get.put(HomeController());
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEduStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  DateTime selectedEduEndDate = DateTime.now();
  RxBool isLoadBtn = false.obs;
  GlobalKey<FormState> formKey = GlobalKey();

  void _selectStartDate(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      pickerMode: DateTimePickerMode.date,
      initialDateTime: selectedStartDate,
      minDateTime: DateTime(2020),
      maxDateTime: DateTime(2025),
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          selectedStartDate = dateTime;
        });
      },
    );
  }

  void _selectEduStartDate(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      pickerMode: DateTimePickerMode.date,
      initialDateTime: selectedEduStartDate,
      minDateTime: DateTime(2020),
      maxDateTime: DateTime(2025),
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          selectedEduStartDate = dateTime;
        });
      },
    );
  }

  void _selectEndDate(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      pickerMode: DateTimePickerMode.date,
      initialDateTime: selectedEndDate,
      minDateTime: DateTime(2020),
      maxDateTime: DateTime(2025),
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          selectedEndDate = dateTime;
        });
      },
    );
  }

  void _selectEduEndDate(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      pickerMode: DateTimePickerMode.date,
      initialDateTime: selectedEduEndDate,
      minDateTime: DateTime(2020),
      maxDateTime: DateTime(2025),
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          selectedEduEndDate = dateTime;
        });
      },
    );
  }

  void selectImg(context) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if (result == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Image")));
      return null;
    }

    await fireDBController.uploadimg(result.files.single.path!);
    setState(() {});
  }

  bool isLoad = false;

  updateData() async {
    if (homeController.selecTedID.value != "") {
      isLoad = true;
      var index = homeController.selectedIndex.value;
      var resumeUpdate = fireDBController.resumeModal[index];
      fireDBController.nameController.text = resumeUpdate.name;
      fireDBController.linkedInController.text = resumeUpdate.linkedInUrl;
      fireDBController.githubController.text = resumeUpdate.githubUrl;
      fireDBController.numberController.text = resumeUpdate.phoneNum;
      fireDBController.emailController.text = resumeUpdate.email;
      fireDBController.addressController.text = resumeUpdate.address;
      fireDBController.languagesController.text = resumeUpdate.languages;
      fireDBController.achivmentController.text = resumeUpdate.achivements;
      fireDBController.interestsController.text = resumeUpdate.interests;
      fireDBController.objectiveController.text = resumeUpdate.objective;
      fireDBController.photoUrl = resumeUpdate.photoUrl;
      await fireDBController.getProjectData(resumeID: resumeUpdate.id);
      await fireDBController.getWorkExpData(resumeID: resumeUpdate.id);
      await fireDBController.getEduData(resumeID: resumeUpdate.id);

      fireDBController.addProjModal.value = fireDBController.projectModal;
      fireDBController.addEduModal.value = fireDBController.educationModal;
      fireDBController.addWorkModal.value = fireDBController.workExpModal;

      isLoad = false;
      setState(() {});
    } else {
      fireDBController.nameController.text = "";
      fireDBController.linkedInController.text = "";
      fireDBController.githubController.text = "";
      fireDBController.numberController.text = "";
      fireDBController.emailController.text = "";
      fireDBController.addressController.text = "";
      fireDBController.languagesController.text = "";
      fireDBController.achivmentController.text = "";
      fireDBController.interestsController.text = "";
      fireDBController.objectiveController.text = "";
      fireDBController.photoUrl = "";
      fireDBController.addProjModal.clear();
      isLoad = false;
    }
  }

  @override
  void initState() {
    updateData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String patttern = r'(^(?:[+0]9{10})?[0-9]{10}$)';
    RegExp regExp1 = RegExp(patttern);
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              IconAssets.arrowBackIcon,
              color: AppColors.whiteColor,
            )),
        title: Text(homeController.selecTedID.value.isNotEmpty
            ? "Update Resume"
            : "addresume".tr),
      ),
      body: isLoad
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: formKey,
              child: Container(
                height: Get.height,
                width: Get.width,
                color: AppColors.whiteColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: AppColors.whiteColor,
                              backgroundImage: fireDBController
                                      .photoUrl.isNotEmpty
                                  ? fireDBController.photoUrl
                                          .contains("firebasestorage")
                                      ? NetworkImage(fireDBController.photoUrl)
                                      : FileImage(
                                              File(fireDBController.photoUrl))
                                          as ImageProvider
                                  : AssetImage(ImageAssets.prevImg),
                            ),
                            IconButton(
                                onPressed: () async {
                                  selectImg(context);
                                },
                                icon: Icon(
                                  IconAssets.cameraIcon,
                                  color: AppColors.blackColor,
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        hinttext: "entername".tr,
                        controller: fireDBController.nameController,
                        labeltext: "name".tr,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name can't Empty";
                          } else if (value.length < 3) {
                            return "Enter Minimum 3 Charecter";
                          } else {
                            return null;
                          }
                        },
                        obscureText: false,
                        iconbutton: IconButton(
                            onPressed: () {},
                            icon: Icon(IconAssets.personIcon)),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: fireDBController.linkedInController,
                        hinttext: "enterlinkedinurl".tr,
                        labeltext: "linkedin".tr,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        iconbutton: IconButton(
                            onPressed: () {}, icon: Icon(IconAssets.webIcon)),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: fireDBController.githubController,
                        hinttext: "entergithuburl".tr,
                        labeltext: "github".tr,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        iconbutton: IconButton(
                            onPressed: () {}, icon: Icon(IconAssets.webIcon)),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: fireDBController.numberController,
                        hinttext: "5616256589",
                        labeltext: "number".tr,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your PhonevNumber".tr;
                          } else if (!regExp1.hasMatch(value)) {
                            return "Enter valid Phone Number".tr;
                          }
                          return null;
                        },
                        iconbutton: IconButton(
                            onPressed: () {}, icon: Icon(IconAssets.phoneIcon)),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: fireDBController.emailController,
                        hinttext: "adf@gmail.com",
                        labeltext: "email".tr,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "enteremail".tr;
                          } else if (!regExp.hasMatch(value.trim())) {
                            return "entervalidemail".tr;
                          }
                          return null;
                        },
                        iconbutton: IconButton(
                            onPressed: () {}, icon: Icon(IconAssets.emailcon)),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: fireDBController.addressController,
                        hinttext: "city".tr,
                        labeltext: "address".tr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "City can't Empty";
                          } else if (value.length < 3) {
                            return "Enter Minimum 3 Charecter";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        iconbutton: IconButton(
                            onPressed: () {},
                            icon: Icon(IconAssets.locationcon)),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: fireDBController.languagesController,
                        hinttext: "hindi".tr,
                        labeltext: "sanguages".tr,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Languages can't Empty";
                          } else if (value.length < 3) {
                            return "Enter Minimum 3 Charecter";
                          } else {
                            return null;
                          }
                        },
                        iconbutton: IconButton(
                            onPressed: () {}, icon: Icon(IconAssets.langIcon)),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: fireDBController.achivmentController,
                        hinttext: "achievements".tr,
                        labeltext: "Achievements".tr,
                        maxLines: 3,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: fireDBController.interestsController,
                        hinttext: "sports".tr,
                        labeltext: "interests".tr,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        iconbutton: IconButton(
                            onPressed: () {}, icon: Icon(IconAssets.flagIcon)),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: fireDBController.objectiveController,
                        hinttext: "objectives".tr,
                        labeltext: "objectives".tr,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        iconbutton: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.person)),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        title: Text(
                          "workexperience".tr,
                          style: Get.textTheme.titleLarge,
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              fireDBController.compNameController.clear();
                              fireDBController.descController.clear();
                              fireDBController.jobNameController.clear();

                              _workAlert();
                            },
                            icon: Icon(
                              IconAssets.addIcon,
                              color: AppColors.blackColor,
                            )),
                      ),
                      const SizedBox(height: 5),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: fireDBController.addWorkModal.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: IconButton(
                                onPressed: () {
                                  homeController.workID.value =
                                      fireDBController.addWorkModal[index].id;
                                  fireDBController.compNameController.text =
                                      fireDBController
                                          .addWorkModal[index].compName;
                                  fireDBController.jobNameController.text =
                                      fireDBController
                                          .addWorkModal[index].jobName;
                                  fireDBController.descController.text =
                                      fireDBController.addWorkModal[index].desc;
                                  _workAlert();
                                },
                                icon: const Icon(
                                  Icons.edit_document,
                                  color: AppColors.blackColor,
                                )),
                            horizontalTitleGap: -10,
                            title: Text(
                              "Company Name : ${fireDBController.addWorkModal[index].compName}",
                              style: Get.textTheme.labelMedium,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Job Name : ${fireDBController.addWorkModal[index].jobName}",
                                  style: Get.textTheme.labelMedium,
                                ),
                                Text(
                                  "Description: ${fireDBController.addWorkModal[index].desc}",
                                  style: Get.textTheme.labelMedium,
                                ),
                                Text(
                                  "Joining Date: ${fireDBController.addWorkModal[index].joinDate}",
                                  style: Get.textTheme.labelMedium,
                                ),
                                Text(
                                  "Ending Date: ${fireDBController.addWorkModal[index].endDate}",
                                  style: Get.textTheme.labelMedium,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        title: Text(
                          "educations".tr,
                          style: Get.textTheme.titleLarge,
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              homeController.eduID.value = "";
                              fireDBController.schoolNameController.text = "";
                              fireDBController.percentageController.text = "";
                              fireDBController.courseController.text = "";
                              _educationAlert();
                            },
                            icon: const Icon(
                              Icons.add,
                              color: AppColors.blackColor,
                            )),
                      ),
                      const SizedBox(height: 5),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: fireDBController.addEduModal.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: IconButton(
                                onPressed: () {
                                  homeController.eduID.value =
                                      fireDBController.addEduModal[index].id;
                                  fireDBController.schoolNameController.text =
                                      fireDBController.addEduModal[index].name;
                                  fireDBController.percentageController.text =
                                      fireDBController
                                          .addEduModal[index].percentage;
                                  fireDBController.courseController.text =
                                      fireDBController
                                          .addEduModal[index].course;
                                  // selectedEduStartDate = fireDBController
                                  //     .addEduModal[index].joinYear as DateTime;
                                  // selectedEduEndDate = fireDBController
                                  //     .addEduModal[index].endYear as DateTime;

                                  _educationAlert();
                                },
                                icon: const Icon(
                                  Icons.edit_document,
                                  color: AppColors.blackColor,
                                )),
                            horizontalTitleGap: -10,
                            title: Text(
                              "School/College Name : ${fireDBController.addEduModal[index].name}",
                              style: Get.textTheme.labelMedium,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Course : ${fireDBController.addEduModal[index].course}",
                                  style: Get.textTheme.labelMedium,
                                ),
                                Text(
                                  "Percentage: ${fireDBController.addEduModal[index].percentage} %",
                                  style: Get.textTheme.labelMedium,
                                ),
                                Text(
                                  "${fireDBController.addEduModal[index].joinYear}-${fireDBController.addEduModal[index].endYear}",
                                  style: Get.textTheme.labelMedium,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        title: Text(
                          "projects".tr,
                          style: Get.textTheme.titleLarge,
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              homeController.projectID.value = "";
                              fireDBController.projectNameController.clear();
                              fireDBController.projectNameController.clear();
                              _projectAlert();
                            },
                            icon: Icon(
                              IconAssets.addIcon,
                              color: AppColors.blackColor,
                            )),
                      ),
                      const SizedBox(height: 5),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: fireDBController.addProjModal.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                leading: IconButton(
                                    onPressed: () {
                                      homeController.projectID.value =
                                          fireDBController
                                              .addProjModal[index].id;
                                      fireDBController
                                              .projectNameController.text =
                                          fireDBController
                                              .addProjModal[index].projName;

                                      fireDBController
                                              .projectDescController.text =
                                          fireDBController
                                              .addProjModal[index].desc;

                                      _projectAlert(
                                          id: fireDBController
                                              .addProjModal[index].id,
                                          projDescCon: fireDBController
                                              .projectDescController.text,
                                          projNameCont: fireDBController
                                              .projectNameController.text);
                                    },
                                    icon: const Icon(
                                      Icons.edit_document,
                                      color: AppColors.blackColor,
                                    )),
                                horizontalTitleGap: -10,
                                title: Text(
                                  "Project Name : ${fireDBController.addProjModal[index].projName}",
                                  style: Get.textTheme.labelMedium,
                                ),
                                subtitle: Text(
                                  "About : ${fireDBController.addProjModal[index].desc}",
                                  maxLines: 5,
                                  style: Get.textTheme.labelMedium,
                                ),
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => CustomButton(
                          onTap: () async {
                            if (isLoadBtn.value == false) {
                              if (formKey.currentState!.validate()) {
                                isLoadBtn.value = true;
                                if (homeController.selecTedID.value != "") {
                                  await fireDBController.updateResume(
                                      homeController.selecTedID.value);
                                } else {
                                  await fireDBController.setData();
                                }
                                await fireDBController.getData();
                                fireDBController.projectNameController.clear();
                                fireDBController.descController.clear();
                                fireDBController.linkedInController.clear();
                                fireDBController.githubController.clear();
                                fireDBController.emailController.clear();
                                fireDBController.addressController.clear();
                                fireDBController.languagesController.clear();
                                fireDBController.achivmentController.clear();
                                fireDBController.objectiveController.clear();
                                fireDBController.numberController.clear();
                                fireDBController.compNameController.clear();
                                fireDBController.jobNameController.clear();
                                fireDBController.schoolNameController.clear();
                                fireDBController.courseController.clear();
                                fireDBController.percentageController.clear();
                                fireDBController.projectNameController.clear();
                                fireDBController.projectDescController.clear();
                                fireDBController.nameController.clear();

                                selectedStartDate = DateTime.now();
                                selectedEduStartDate = DateTime.now();
                                selectedEndDate = DateTime.now();
                                selectedEduEndDate = DateTime.now();
                                fireDBController.addProjModal.clear();
                                fireDBController.addEduModal.clear();
                                fireDBController.photoUrl = "";
                                fireDBController.addWorkModal.clear();
                                Get.offAllNamed(Routes.HomeView);

                                isLoadBtn.value = false;
                              }
                            }
                          },
                          child: isLoadBtn.value
                              ? const CircularProgressIndicator(
                                  color: AppColors.deepBlueColor,
                                  backgroundColor: AppColors.whiteColor,
                                )
                              : Text(
                                  homeController.selecTedID.value.isNotEmpty
                                      ? "Update"
                                      : "add".tr,
                                  style: CustomTextStyle.text1,
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  _workAlert() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            homeController.workID.value != ""
                ? "Update Workexprience"
                : "addworkexeprience".tr,
            style: Get.textTheme.titleLarge,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  controller: fireDBController.compNameController,
                  hinttext: "xyztech".tr,
                  labeltext: "companyname".tr,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  iconbutton: IconButton(
                      onPressed: () {}, icon: Icon(IconAssets.compactIcon)),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: fireDBController.jobNameController,
                  hinttext: "flutterdevloper".tr,
                  labeltext: "job".tr,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  iconbutton: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.person)),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: fireDBController.descController,
                  hinttext: "description".tr,
                  labeltext: "description".tr,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  iconbutton: IconButton(
                      onPressed: () {}, icon: Icon(IconAssets.detailsIcon)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "joiningdate".tr,
                  style: Get.textTheme.labelMedium,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.blackColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${selectedStartDate.year}/${selectedStartDate.month}/${selectedStartDate.day}',
                        style: Get.textTheme.labelMedium,
                      ),
                      IconButton(
                          onPressed: () => _selectStartDate(context),
                          icon: Icon(
                            IconAssets.calendarIcon,
                            color: AppColors.blackColor,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "To",
                    style: Get.textTheme.labelMedium,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.blackColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${selectedEndDate.year}/${selectedEndDate.month}/${selectedEndDate.day}',
                        style: Get.textTheme.labelMedium,
                      ),
                      IconButton(
                          onPressed: () {
                            _selectEndDate(context);
                          },
                          icon: Icon(
                            IconAssets.calendarIcon,
                            color: AppColors.blackColor,
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  child: Text(
                      homeController.workID.value != "" ? "Update" : "add".tr),
                  onTap: () async {
                    if (homeController.workID.value != "") {
                      await fireDBController.updateWorkData(
                          endYear: selectedEndDate.toString(),
                          joinYear: selectedStartDate.toString(),
                          projID: homeController.workID.value,
                          resumeID: homeController.selecTedID.value);
                    } else {
                      await fireDBController.addWorkModalData(
                          endDate:
                              '${selectedEndDate.year}/${selectedEndDate.month}/${selectedEndDate.day}',
                          joinDate:
                              '${selectedStartDate.year}/${selectedStartDate.month}/${selectedStartDate.day}');
                    }
                    fireDBController.compNameController.clear();
                    fireDBController.jobNameController.clear();
                    fireDBController.descController.clear();
                    selectedEndDate = DateTime.now();
                    selectedStartDate = DateTime.now();
                    setState(() {});
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _educationAlert() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            homeController.eduID.value != ""
                ? "Update Education"
                : "addeducation".tr,
            textAlign: TextAlign.center,
            style: Get.textTheme.titleLarge,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  controller: fireDBController.schoolNameController,
                  hinttext: "xyzschool".tr,
                  labeltext: "scname".tr,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  iconbutton: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.person)),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: fireDBController.courseController,
                  hinttext: "commerce".tr,
                  labeltext: "course".tr,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  iconbutton: IconButton(
                      onPressed: () {}, icon: Icon(IconAssets.subjectIcon)),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: fireDBController.percentageController,
                  hinttext: "85",
                  labeltext: "percentage".tr,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  iconbutton: IconButton(
                      onPressed: () {}, icon: Icon(IconAssets.percentageIcon)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "joiningdate".tr,
                  style: Get.textTheme.labelMedium,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.blackColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${selectedEduStartDate.year}/${selectedEduStartDate.month}',
                        style: Get.textTheme.labelMedium,
                      ),
                      IconButton(
                          onPressed: () => _selectEduStartDate(context),
                          icon: Icon(
                            IconAssets.calendarIcon,
                            color: AppColors.blackColor,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "To",
                    style: Get.textTheme.labelMedium,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.blackColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${selectedEduEndDate.year}/${selectedEduEndDate.month}',
                        style: Get.textTheme.labelMedium,
                      ),
                      IconButton(
                          onPressed: () {
                            _selectEduEndDate(context);
                          },
                          icon: Icon(
                            IconAssets.calendarIcon,
                            color: AppColors.blackColor,
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  child: Text(
                      homeController.eduID.value != "" ? "Update" : "add".tr),
                  onTap: () async {
                    if (homeController.eduID.value != "") {
                      await fireDBController.updateEduData(
                          endYear: selectedEduEndDate.toString(),
                          joinYear: selectedEduStartDate.toString(),
                          projID: homeController.eduID.value,
                          resumeID: homeController.selecTedID.value);
                    } else {
                      await fireDBController.addEduModalData(
                          endDate:
                              '${selectedEduEndDate.year}/${selectedEduEndDate.month}',
                          joinDate:
                              '${selectedEduStartDate.year}/${selectedEduStartDate.month}');
                    }
                    fireDBController.schoolNameController.clear();
                    fireDBController.courseController.clear();
                    fireDBController.percentageController.clear();
                    selectedEduEndDate = DateTime.now();
                    selectedEduStartDate = DateTime.now();

                    setState(() {});
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _projectAlert(
      {String id = "", String projNameCont = "", String projDescCon = ""}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            homeController.projectID.value != ""
                ? "Update Project"
                : "addproject".tr,
            textAlign: TextAlign.center,
            style: Get.textTheme.titleLarge,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  controller: fireDBController.projectNameController,
                  hinttext: "MDU",
                  labeltext: "projectname".tr,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  iconbutton: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.near_me)),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: fireDBController.projectDescController,
                  hinttext: "aboutproject".tr,
                  labeltext: "about".tr,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  maxLines: 5,
                  iconbutton: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.abc_outlined)),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  child: Text("add".tr),
                  onTap: () async {
                    if (homeController.projectID.value != "") {
                      await fireDBController.updateProjModalData(
                          projID: homeController.projectID.value,
                          resumeID: homeController.selecTedID.value);
                    } else {
                      await fireDBController.addProjModalData();
                    }

                    fireDBController.projectNameController.clear();
                    fireDBController.projectDescController.clear();
                    setState(() {});
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
