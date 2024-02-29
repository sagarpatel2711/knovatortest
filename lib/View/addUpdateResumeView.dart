import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:knovatortest/Themes/appColors.dart';
import 'package:knovatortest/Themes/customTextFormField.dart';

class AddUpdateResumeView extends StatefulWidget {
  AddUpdateResumeView({super.key});

  @override
  State<AddUpdateResumeView> createState() => _AddUpdateResumeViewState();
}

class _AddUpdateResumeViewState extends State<AddUpdateResumeView> {
  DateTime selectedDate = DateTime.now();

  void _selectDate(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      pickerMode: DateTimePickerMode.date,
      initialDateTime: selectedDate,
      minDateTime: DateTime(2020),
      maxDateTime: DateTime(2025),
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          selectedDate = dateTime;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: CircleAvatar(
                  maxRadius: 50,
                  minRadius: 50,
                  backgroundColor: AppColors.blackColor,
                ),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hinttext: "Enter your Name",
                labeltext: "Name",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hinttext: "Enter your linkedin url",
                labeltext: "Linkedin url",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hinttext: "5616256589",
                labeltext: "Number",
                keyboardType: TextInputType.number,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hinttext: "adf@gmail.com",
                labeltext: "Email",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hinttext: "city,state",
                labeltext: "Address",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hinttext: "Hindi,English,Gujarati",
                labeltext: "Languages",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hinttext: "Best Employee",
                labeltext: "Achievements",
                maxLines: 3,
                keyboardType: TextInputType.name,
                obscureText: false,
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hinttext: "Singing,Playing sports",
                labeltext: "Interests",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hinttext: "objective",
                labeltext: "Objective",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              Text(
                "Work Experience",
                style: Get.textTheme.titleLarge,
              ),
              SizedBox(height: 5),
              CustomTextFormField(
                hinttext: "xyz Tech.",
                labeltext: "Company name",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hinttext: "Flutter Developer",
                labeltext: "Job name",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hinttext: "Flutter Developer",
                labeltext: "Description",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Joining date",
                style: Get.textTheme.labelMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                    style: Get.textTheme.labelMedium,
                  ),
                  IconButton(
                      onPressed: () => _selectDate(context),
                      icon: Icon(
                        Icons.calendar_month,
                        color: AppColors.blackColor,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "From",
                      style: Get.textTheme.labelMedium,
                    ),
                  ),
                  Text(
                    '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                    style: Get.textTheme.labelMedium,
                  ),
                  IconButton(
                      onPressed: () => _selectDate(context),
                      icon: Icon(
                        Icons.calendar_month,
                        color: AppColors.blackColor,
                      )),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Education",
                style: Get.textTheme.titleLarge,
              ),
              SizedBox(height: 5),
              CustomTextFormField(
                hinttext: "xyx sch",
                labeltext: "School name",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hinttext: "Course",
                labeltext: "Course",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hinttext: "60%",
                labeltext: "Persiontage",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Joining date",
                style: Get.textTheme.labelMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                    style: Get.textTheme.labelMedium,
                  ),
                  IconButton(
                      onPressed: () => _selectDate(context),
                      icon: Icon(
                        Icons.calendar_month,
                        color: AppColors.blackColor,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "From",
                      style: Get.textTheme.labelMedium,
                    ),
                  ),
                  Text(
                    '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                    style: Get.textTheme.labelMedium,
                  ),
                  IconButton(
                      onPressed: () => _selectDate(context),
                      icon: Icon(
                        Icons.calendar_month,
                        color: AppColors.blackColor,
                      )),
                ],
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hinttext: "mobile app",
                labeltext: "Project Name",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hinttext: "About Project",
                labeltext: "About Project",
                keyboardType: TextInputType.name,
                obscureText: false,
                iconbutton:
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
