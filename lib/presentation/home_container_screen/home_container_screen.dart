import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/presentation/bangxephang_tab_container_screen/bangxephang_tab_container_screen.dart';
import 'package:lang_s_application4/presentation/theloai_screen/theloai_screen.dart';
import 'package:lang_s_application4/presentation/canhan_screen/canhan_screen.dart';
import 'package:lang_s_application4/presentation/home_page/home_page.dart';
import 'package:lang_s_application4/widgets/custom_bottom_bar.dart';

// ignore_for_file: must_be_immutable
class HomeContainerScreen extends StatelessWidget {
  HomeContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Navigator(
                  key: navigatorKey,
                  initialRoute: AppRoutes.homePage,
                  onGenerateRoute: (routeSetting) => PageRouteBuilder(
                      pageBuilder: (ctx, ani, ani1) =>
                          getCurrentPage(routeSetting.name!),
                      transitionDuration: Duration(seconds: 0))),
            ),
            bottomNavigationBar: _buildBottomBar(context)));
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Homelightbluea700:
        return AppRoutes.homePage;
      case BottomBarEnum.Bookmarklight:
        return AppRoutes.bangxephangTabContainerScreen;
      case BottomBarEnum.Deskaltlight:
        return AppRoutes.theloaiScreen;
      case BottomBarEnum.Icon:
        return AppRoutes.canhanScreen;
      default:
        return AppRoutes.homePage;
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homePage:
        return HomePage();
      case AppRoutes.bangxephangTabContainerScreen:
        return BangxephangTabContainerScreen();
      case AppRoutes.theloaiScreen:
        return TheloaiScreen();
      case AppRoutes.canhanScreen:
        return CanhanScreen();
      default:
        return DefaultWidget();
    }
  }
}
