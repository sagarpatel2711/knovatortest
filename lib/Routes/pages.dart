import 'package:get/get.dart';
import 'package:knovatortest/View/homeView.dart';

part 'routes.dart';

class Pages {
  static List<GetPage> routes = [
    GetPage(
        name: _Paths.HOMEVIEW,
        page: () => HomeView(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 200)),
  ];
}
