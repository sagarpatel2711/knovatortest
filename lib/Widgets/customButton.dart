import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Themes/appColors.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  Widget? child;
  void Function()? onTap;
  CustomButton({super.key, this.child, this.onTap});

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
        child: child,
      ),
    );
  }
}
