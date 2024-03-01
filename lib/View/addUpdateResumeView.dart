import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:knovatortest/Controller/fireDBController.dart';
import 'package:knovatortest/Localization/imageAssets.dart';
import 'package:knovatortest/Themes/appColors.dart';
import 'package:knovatortest/Themes/customTextFormField.dart';
import 'package:knovatortest/Themes/themeStyle.dart';
import 'package:knovatortest/Widgets/customButton.dart';

class AddUpdateResumeView extends StatefulWidget {
  AddUpdateResumeView({super.key});

  @override
  State<AddUpdateResumeView> createState() => _AddUpdateResumeViewState();
}

class _AddUpdateResumeViewState extends State<AddUpdateResumeView> {
  FireDBController fireDBController = Get.put(FireDBController());
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEduStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  DateTime selectedEduEndDate = DateTime.now();
  RxBool isLoadBtn = false.obs;

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
          .showSnackBar(SnackBar(content: Text("Image")));
      return null;
    }

    fireDBController.uploadimg(result.files.single.path!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.whiteColor,
            )),
        title: Text("Add Resume"),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        color: AppColors.whiteColor,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      backgroundImage: fireDBController.photoUrl.isNotEmpty
                          ? fireDBController.photoUrl
                                  .contains("firebasestorage")
                              ? NetworkImage(fireDBController.photoUrl)
                              : FileImage(File(fireDBController.photoUrl))
                                  as ImageProvider
                          : AssetImage(ImageAssets.prevImg),
                    ),
                    IconButton(
                        onPressed: () => selectImg(context),
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.blackColor,
                        ))
                  ],
                ),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hinttext: "Enter your Name",
                controller: fireDBController.nameController,
                labeltext: "Name",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: fireDBController.linkedInController,
                hinttext: "Enter your linkedin url",
                labeltext: "Linkedin",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: fireDBController.githubController,
                hinttext: "Enter your Github url",
                labeltext: "Github",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: fireDBController.numberController,
                hinttext: "5616256589",
                labeltext: "Number",
                keyboardType: TextInputType.number,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: fireDBController.emailController,
                hinttext: "adf@gmail.com",
                labeltext: "Email",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: fireDBController.addressController,
                hinttext: "city,state",
                labeltext: "Address",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: fireDBController.languagesController,
                hinttext: "Hindi,English,Gujarati",
                labeltext: "Languages",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: fireDBController.achivmentController,
                hinttext: "Best Employee",
                labeltext: "Achievements",
                maxLines: 3,
                keyboardType: TextInputType.name,
                obscureText: false,
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: fireDBController.interestsController,
                hinttext: "Singing,Playing sports",
                labeltext: "Interests",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: fireDBController.objectiveController,
                hinttext: "objective",
                labeltext: "Objective",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text(
                  "Work Experience",
                  style: Get.textTheme.titleLarge,
                ),
                trailing: IconButton(
                    onPressed: () => _workAlert(),
                    icon: Icon(
                      Icons.add,
                      color: AppColors.blackColor,
                    )),
              ),
              SizedBox(height: 5),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: fireDBController.addWorkModal.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Company Name : ${fireDBController.addWorkModal[index].compName}",
                        style: Get.textTheme.labelMedium,
                      ),
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
                  );
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text(
                  "Education",
                  style: Get.textTheme.titleLarge,
                ),
                trailing: IconButton(
                    onPressed: () => _educationAlert(),
                    icon: Icon(
                      Icons.add,
                      color: AppColors.blackColor,
                    )),
              ),
              SizedBox(height: 5),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: fireDBController.addEduModal.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "School/College Name : ${fireDBController.addEduModal[index].name}",
                        style: Get.textTheme.labelMedium,
                      ),
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
                  );
                },
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text(
                  "Project",
                  style: Get.textTheme.titleLarge,
                ),
                trailing: IconButton(
                    onPressed: () => _projectAlert(),
                    icon: Icon(
                      Icons.add,
                      color: AppColors.blackColor,
                    )),
              ),
              SizedBox(height: 5),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: fireDBController.addProjModal.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Project Name : ${fireDBController.addProjModal[index].projName}",
                        style: Get.textTheme.labelMedium,
                      ),
                      Text(
                        "About : ${fireDBController.addProjModal[index].desc}",
                        maxLines: 5,
                        style: Get.textTheme.labelMedium,
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => CustomButton(
                  onTap: () async {
                    if (isLoadBtn.value == false) {
                      isLoadBtn.value = true;
                      await fireDBController.setData();
                      isLoadBtn.value = false;
                    }
                  },
                  child: isLoadBtn.value
                      ? CircularProgressIndicator(
                          color: AppColors.whiteColor,
                        )
                      : Text(
                          "Add",
                          style: CustomTextStyle.text1,
                        ),
                ),
              )
            ],
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
            "Add Work Exeprience",
            style: Get.textTheme.titleLarge,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  controller: fireDBController.compNameController,
                  hinttext: "xyz Tech.",
                  labeltext: "Company name",
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  iconbutton:
                      IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: fireDBController.jobNameController,
                  hinttext: "xyz Tech.",
                  labeltext: "Job name",
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  iconbutton:
                      IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: fireDBController.descController,
                  hinttext: "Description.",
                  labeltext: "Description",
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  iconbutton:
                      IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Joining date",
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
                            Icons.calendar_month,
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
                            Icons.calendar_month,
                            color: AppColors.blackColor,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  child: Text("save"),
                  onTap: () async {
                    await fireDBController.addWorkModalData(
                        endDate:
                            '${selectedEndDate.year}/${selectedEndDate.month}/${selectedEndDate.day}',
                        joinDate:
                            '${selectedStartDate.year}/${selectedStartDate.month}/${selectedStartDate.day}');

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
            "Add Education",
            style: Get.textTheme.titleLarge,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  controller: fireDBController.schoolNameController,
                  hinttext: "xyz School",
                  labeltext: "School/College Name",
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  iconbutton:
                      IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: fireDBController.courseController,
                  hinttext: "Commers",
                  labeltext: "Course",
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  iconbutton:
                      IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: fireDBController.percentageController,
                  hinttext: "85%",
                  labeltext: "Percentage",
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  iconbutton:
                      IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Joining date",
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
                            Icons.calendar_month,
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
                            Icons.calendar_month,
                            color: AppColors.blackColor,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  child: Text("save"),
                  onTap: () async {
                    await fireDBController.addEduModalData(
                        endDate:
                            '${selectedEduEndDate.year}/${selectedEduEndDate.month}',
                        joinDate:
                            '${selectedEduStartDate.year}/${selectedEduStartDate.month}');

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

  _projectAlert() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Add Project",
            style: Get.textTheme.titleLarge,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  controller: fireDBController.projectNameController,
                  hinttext: "MDU",
                  labeltext: "Project Name",
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  iconbutton:
                      IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: fireDBController.projectDescController,
                  hinttext: "About Project",
                  labeltext: "About",
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  maxLines: 5,
                  iconbutton:
                      IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  child: Text("save"),
                  onTap: () async {
                    fireDBController.addProjModalData();

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
