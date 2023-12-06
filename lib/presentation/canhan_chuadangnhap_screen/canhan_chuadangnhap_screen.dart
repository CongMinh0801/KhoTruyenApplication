import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/presentation/danhsachtheloaiadmin_page/danhsachtheloaiadmin_page.dart';
import 'package:lang_s_application4/presentation/home_page/home_page.dart';
import 'package:lang_s_application4/presentation/login_screen/login_screen.dart';
import 'package:lang_s_application4/presentation/register_screen/register_screen.dart';
import 'package:lang_s_application4/widgets/custom_bottom_bar.dart';
import 'package:lang_s_application4/widgets/custom_outlined_button.dart';

// ignore_for_file: must_be_immutable
class CanhanChuadangnhapScreen extends StatelessWidget {
  CanhanChuadangnhapScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 1.v),
                child: Column(children: [
                  SizedBox(height: 330.v),
                  _buildScrollView(context)
                ])),
            ));
  }

  /// Section Widget
  Widget _buildScrollView(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(left: 50.h, right: 50.h, bottom: 5.v),
                child: Column(children: [
                  Text("Chưa đăng nhập tài khoản",
                      style: CustomTextStyles.titleMediumBlack900),
                  SizedBox(height: 31.v),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Expanded(
                        child: CustomOutlinedButton(
                            text: "Đăng nhập",
                            margin: EdgeInsets.only(right: 12.h),
                            buttonStyle: CustomButtonStyles.outlineDeepPurple,
                            onPressed: () {
                              onTapDangNhap(context);
                            })),
                    Expanded(
                        child: CustomOutlinedButton(
                            text: "Đăng ký",
                            margin: EdgeInsets.only(left: 12.h),
                            buttonStyle: CustomButtonStyles.outlineDeepPurple,
                            onPressed: () {
                              onTapDangKy(context);
                            }))
                  ])
                ]))));
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapDangNhap(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder:
            (context) => LoginScreen()
        )
    );
  }

  onTapDangKy(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder:
            (context) => RegisterScreen()
        )
    );
  }
}
