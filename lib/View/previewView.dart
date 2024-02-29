import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knovatortest/Localization/imageAssets.dart';
import 'package:knovatortest/Routes/pages.dart';
import 'package:knovatortest/Themes/themeStyle.dart';
import 'package:knovatortest/Widgets/customButton.dart';

class PreviewView extends StatelessWidget {
  const PreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "Resume Preview",
              style: CustomTextStyle.text3,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: Get.height / 1.5,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                      image: AssetImage(ImageAssets.prevImg),
                      fit: BoxFit.contain)),
            ),
            const Spacer(),
            CustomButton(
              onTap: () => Get.toNamed(Routes.HomeView),
              title: "Next",
            )
          ],
        ),
      ),
    );
  }
}
