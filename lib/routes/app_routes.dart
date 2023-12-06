import 'package:flutter/material.dart';
import 'package:lang_s_application4/presentation/home_container_screen/home_container_screen.dart';
import 'package:lang_s_application4/presentation/bangxephang_tab_container_screen/bangxephang_tab_container_screen.dart';
import 'package:lang_s_application4/presentation/theloai_screen/theloai_screen.dart';
import 'package:lang_s_application4/presentation/overlaythemtheloai_screen/overlaythemtheloai_screen.dart';
import 'package:lang_s_application4/presentation/overlaychinhsuathongtin_screen/overlaychinhsuathongtin_screen.dart';
import 'package:lang_s_application4/presentation/login_screen/login_screen.dart';
import 'package:lang_s_application4/presentation/canhan_screen/canhan_screen.dart';
import 'package:lang_s_application4/presentation/thongtincanhan_screen/thongtincanhan_screen.dart';
import 'package:lang_s_application4/presentation/canhan_chuadangnhap_screen/canhan_chuadangnhap_screen.dart';
import 'package:lang_s_application4/presentation/register_screen/register_screen.dart';
import 'package:lang_s_application4/presentation/tusachdadoc_screen/tusachdadoc_screen.dart';
import 'package:lang_s_application4/presentation/tusachyeuthich_screen/tusachyeuthich_screen.dart';
import 'package:lang_s_application4/presentation/sachcuatoi_screen/sachcuatoi_screen.dart';
import 'package:lang_s_application4/presentation/themsach_screen/themsach_screen.dart';
import 'package:lang_s_application4/presentation/sach_screen/sach_screen.dart';
import 'package:lang_s_application4/presentation/sach_danhsachchuong_screen/sach_danhsachchuong_screen.dart';
import 'package:lang_s_application4/presentation/sach_chinhsuaone_screen/sach_chinhsuaone_screen.dart';
import 'package:lang_s_application4/presentation/sach_chinhsuathree_screen/sach_chinhsuathree_screen.dart';
import 'package:lang_s_application4/presentation/sach_chinhsuatwo_screen/sach_chinhsuatwo_screen.dart';
import 'package:lang_s_application4/presentation/sach_doc_screen/sach_doc_screen.dart';
import 'package:lang_s_application4/presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String homePage = '/home_page';

  static const String homeContainerScreen = '/home_container_screen';

  static const String bangxephangPage = '/bangxephang_page';

  static const String bangxephangTabContainerScreen =
      '/bangxephang_tab_container_screen';

  static const String theloaiScreen = '/theloai_screen';

  static const String overlaythemtheloaiScreen = '/overlaythemtheloai_screen';

  static const String overlaychinhsuathongtinScreen =
      '/overlaychinhsuathongtin_screen';

  static const String danhsachtheloaiadminPage = '/danhsachtheloaiadmin_page';

  static const String loginScreen = '/login_screen';

  static const String canhanScreen = '/canhan_screen';

  static const String thongtincanhanScreen = '/thongtincanhan_screen';

  static const String canhanChuadangnhapScreen = '/canhan_chuadangnhap_screen';

  static const String registerScreen = '/register_screen';

  static const String tusachdadocScreen = '/tusachdadoc_screen';

  static const String tusachyeuthichScreen = '/tusachyeuthich_screen';

  static const String sachcuatoiScreen = '/sachcuatoi_screen';

  static const String themsachScreen = '/themsach_screen';

  static const String sachScreen = '/sach_screen';

  static const String sachDanhsachchuongScreen = '/sach_danhsachchuong_screen';

  static const String sachChinhsuaoneScreen = '/sach_chinhsuaone_screen';

  static const String sachChinhsuathreeScreen = '/sach_chinhsuathree_screen';

  static const String sachChinhsuatwoScreen = '/sach_chinhsuatwo_screen';

  static const String sachDocScreen = '/sach_doc_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    homeContainerScreen: (context) => HomeContainerScreen(),
    bangxephangTabContainerScreen: (context) => BangxephangTabContainerScreen(),
    theloaiScreen: (context) => TheloaiScreen(),
    overlaythemtheloaiScreen: (context) => OverlaythemtheloaiScreen(),
    overlaychinhsuathongtinScreen: (context) => OverlaychinhsuathongtinScreen(),
    loginScreen: (context) => LoginScreen(),
    canhanScreen: (context) => CanhanScreen(), // replace with actual userId
    thongtincanhanScreen: (context) => ThongtincanhanScreen(),
    canhanChuadangnhapScreen: (context) => CanhanChuadangnhapScreen(),
    registerScreen: (context) => RegisterScreen(),
    tusachdadocScreen: (context) => TusachdadocScreen(),
    tusachyeuthichScreen: (context) => TusachyeuthichScreen(),
    sachcuatoiScreen: (context) => SachcuatoiScreen(),
    themsachScreen: (context) => ThemsachScreen(),
    sachScreen: (context) => SachScreen(),
    sachDanhsachchuongScreen: (context) => SachDanhsachchuongScreen(),
    sachChinhsuaoneScreen: (context) => SachChinhsuaoneScreen(),
    sachChinhsuathreeScreen: (context) => SachChinhsuathreeScreen(),
    sachChinhsuatwoScreen: (context) => SachChinhsuatwoScreen(),
    sachDocScreen: (context) => SachDocScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
  };
}
