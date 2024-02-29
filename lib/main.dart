import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Localization/localizationService.dart';
import 'Routes/pages.dart';
import 'Themes/themes.dart';

void main() async {
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
