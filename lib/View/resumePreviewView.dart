import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Themes/appColors.dart';
import '../Themes/themeStyle.dart';

class ResumePreviewView extends StatelessWidget {
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
        title: Text("Preview"),
      ),
      body: Container(
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
                      "Sagar",
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 65,
                              ),
                              _customContainer(title: "ABOUT ME"),
                              _customText(title: "Website : "),
                              _customText(title: "LinkedIn : "),
                              _customText(title: "Facebook : "),
                              _customContainer(title: "CONTACT INFO"),
                              _customText(title: "+91 7600 777 594"),
                              _customText(title: "patelsagar12.ps@gmail.com"),
                              _customText(title: "Vadodara,Gujarat"),
                              _customContainer(title: "LANGUAGES"),
                              _customText(title: "English"),
                              _customText(title: "Hindi"),
                              _customContainer(title: "SKILL"),
                              _customText(title: "Skill 1"),
                              _customText(title: "Skill 2"),
                              _customContainer(title: "ACHIEVEMENTS"),
                              _customText(
                                  title: "Best Employee of 3rd Quater of 2023"),
                              _customContainer(title: "INTARESTS"),
                              _customText(title: "Singing"),
                              _customText(title: "Playing sports"),
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
                            _titleText(title: "OBJECTIVE"),
                            _customText(title: "Singing", maxLine: 3),
                            _titleText(title: "WORK EXPERIENCE"),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _customText(
                                          title: "Company Name", maxLine: 2),
                                      _customText(
                                          title: "01/01/2023\n01/01/2024",
                                          maxLine: 2)
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _customText(
                                          title: "Company Name", maxLine: 2),
                                      _customText(
                                          title: "01/01/2023\n01/01/2024",
                                          maxLine: 2)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _customText(
                                          title: "Company Name", maxLine: 2),
                                      _customText(
                                          title: "01/01/2023\n01/01/2024",
                                          maxLine: 2)
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _customText(
                                          title: "Company Name", maxLine: 2),
                                      _customText(
                                          title: "01/01/2023\n01/01/2024",
                                          maxLine: 2)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            _titleText(title: "EDUCATION"),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _customText(
                                          title: "School Name", maxLine: 2),
                                      _customText(
                                          title: "2015 - 2018", maxLine: 2)
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _customText(title: "Course", maxLine: 2),
                                      _customText(title: "4.0", maxLine: 2)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            _titleText(title: "PROJECT"),
                            _customText(title: "Description", maxLine: 3),
                            _titleText(title: "REFERENCE"),
                            _customText(title: "name", maxLine: 3),
                            _customText(title: "post", maxLine: 3),
                            _customText(title: "email", maxLine: 3),
                            _customText(title: "number", maxLine: 3)
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 30, 5, 20),
                child: CircleAvatar(
                  backgroundColor: AppColors.blackColor,
                  maxRadius: 70,
                  minRadius: 50,
                ),
              ),
            ],
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
