import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Themes/appColors.dart';
import '../Themes/themeStyle.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  String title;
  void Function()? onTap;
  CustomButton({super.key, this.title = "", this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 50,
        width: Get.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.blackColor),
        child: Text(
          title,
          style: CustomTextStyle.text1,
        ),
      ),
    );
  }
}
