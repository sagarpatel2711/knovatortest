import 'package:get/get.dart';
import 'package:knovatortest/View/addUpdateResumeView.dart';
import 'package:knovatortest/View/homeView.dart';
import 'package:knovatortest/View/previewView.dart';
import 'package:knovatortest/View/resumePreviewView.dart';

part 'routes.dart';

class Pages {
  static List<GetPage> routes = [
    GetPage(
        name: _Paths.PreviewView,
        page: () => PreviewView(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: _Paths.HomeView,
        page: () => HomeView(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: _Paths.AddUpdateResumeView,
        page: () => AddUpdateResumeView(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: _Paths.ResumePreviewView,
        page: () => ResumePreviewView(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 200)),
  ];
}
