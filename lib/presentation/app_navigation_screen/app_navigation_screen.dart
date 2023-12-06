import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        body: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              _buildAppNavigation(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          context,
                          screenTitle: "Home - Container",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.homeContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "BangXepHang - Tab Container",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.bangxephangTabContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "TheLoai",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.theloaiScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "OverlayThemTheLoai",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.overlaythemtheloaiScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "OverlayChinhSuaThongTin",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.overlaychinhsuathongtinScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Login",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.loginScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "CaNhan",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.canhanScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "ThongTinCaNhan",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.thongtincanhanScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "CaNhan_ChuaDangNhap",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.canhanChuadangnhapScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Register",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.registerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "TuSachDaDoc",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.tusachdadocScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "TuSachYeuThich",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.tusachyeuthichScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "SachCuaToi",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.sachcuatoiScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "ThemSach",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.themsachScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sach",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.sachScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sach_DanhSachChuong",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.sachDanhsachchuongScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sach_ChinhSuaOne",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.sachChinhsuaoneScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sach_ChinhSuaThree",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.sachChinhsuathreeScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sach_ChinhSuaTwo",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.sachChinhsuatwoScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sach_Doc",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.sachDocScreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                "App Navigation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                "Check your app's UI from the below demo screens of your app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF888888),
                  fontSize: 16.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: Color(0XFF000000),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle!.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.v),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Text(
                  screenTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 20.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.v),
            SizedBox(height: 5.v),
            Divider(
              height: 1.v,
              thickness: 1.v,
              color: Color(0XFF888888),
            ),
          ],
        ),
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }
}
