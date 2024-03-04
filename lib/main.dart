import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_maker/Controller/fireDBController.dart';
import 'package:resume_maker/Controller/homeController.dart';

import 'Localization/localizationService.dart';
import 'Routes/pages.dart';
import 'Themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(FireDBController());
  Get.put(HomeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.HomeView,
      getPages: Pages.routes,
      theme: Themes.lightTheme,
      // darkTheme: Themes.darkTheme,
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
    );
  }
}
