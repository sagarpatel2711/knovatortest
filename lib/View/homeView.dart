import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knovatortest/Localization/imageAssets.dart';
import 'package:knovatortest/Routes/pages.dart';
import 'package:knovatortest/Themes/appColors.dart';
import 'package:knovatortest/Widgets/customButton.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: 50,
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
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete,
                          color: AppColors.redColor,
                        ))
                  ],
                ),
                ListTile(
                  leading: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(ImageAssets.prevImg,
                          fit: BoxFit.contain)),
                  title: Text("Sagar Patel"),
                  subtitle: Text("patelsagar12.ps@gmail.com"),
                ),
                Container(
                  width: Get.width / 2,
                  height: 40,
                  child: CustomButton(
                    onTap: () {
                      Get.toNamed(Routes.ResumePreviewView);
                    },
                    title: "Preview",
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
