import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/presentation/canhan_chuadangnhap_screen/canhan_chuadangnhap_screen.dart';
import 'package:lang_s_application4/presentation/thongtincanhan_screen/thongtincanhan_screen.dart';
import 'package:lang_s_application4/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

import '../../user_data.dart';
import '../danhsachtheloaiadmin_page/danhsachtheloaiadmin_page.dart';
import '../sachcuatoi_screen/sachcuatoi_screen.dart';
import '../themsach_screen/themsach_screen.dart';
import '../tusachdadoc_screen/tusachdadoc_screen.dart';
import '../tusachyeuthich_screen/tusachyeuthich_screen.dart';

class CanhanScreen extends StatelessWidget {
  final String? userId;

  CanhanScreen({this.userId});
  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    String? adminCheck = Provider.of<UserData>(context).adminCheck;
    final bool _isUserIdEmpty = userId?.isEmpty ?? true;
    if (userId == null || _isUserIdEmpty) {
      return CanhanChuadangnhapScreen();
    }

    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(children: [
                    CustomImageView(
                        imagePath: ImageConstant.imgVector211x211,
                        height: 211.adaptSize,
                        width: 211.adaptSize),
                    SizedBox(height: 25.v),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 24.h),
                            child: Text("Account",
                                style: CustomTextStyles
                                    .titleMediumOnPrimaryContainer))),
                    SizedBox(height: 12.v),
                    _buildThongTinTaiKhoanButton(context),
                    SizedBox(height: 12.v),
                    _buildTuSachDaDocButton(context),
                    SizedBox(height: 12.v),
                    _buildTuSachYeuThichButton(context),
                    SizedBox(height: 12.v),
                    _buildSachCuaToiButton(context),
                    SizedBox(height: 12.v),
                    _buildThemSachMoiButton(context),
                    SizedBox(height: 16.v),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 24.h),
                            child: Text("Quyền Admin",
                                style: CustomTextStyles
                                    .titleMediumOnPrimaryContainer))),
                    SizedBox(height: 7.v),
                    adminCheck == "true" ? _buildThemTheLoaiButton(context) : Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text('Chưa có quyền Admin'),
                    ),

                    SizedBox(height: 100.v),
                    GestureDetector(
                        onTap: () {
                          onTapTxtLogOut(context);
                        },
                        child: Text("Log out",
                            style: CustomTextStyles.bodyLargeGray500))
                  ]),
                ))));
  }

  Widget _buildThongTinTaiKhoanButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Thông tin tài khoản",
      onPressed: (){
        onTapThongTinCaNhanButton(context);
      },
    );
  }

  Widget _buildTuSachDaDocButton(BuildContext context) {
    return CustomElevatedButton(
        text: "Tủ sách đã đọc",
        onPressed: () {
          onTapTuSachDaDocButton(context);
        });
  }

  Widget _buildTuSachYeuThichButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Tủ sách yêu thích",
      onPressed: (){
        onTapTusachyeuthichButton(context);
      },
    );
  }

  Widget _buildSachCuaToiButton(BuildContext context) {
    return CustomElevatedButton(
        text: "Sách của tôi",
        onPressed: () {
          onTapSachCuaToiButton(context);
        });
  }

  Widget _buildThemSachMoiButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Thêm sách mới",
      onPressed: (){
        onTapThemSachMoiButton(context);
      },
    );
  }

  Widget _buildThemTheLoaiButton(BuildContext context) {
    return CustomElevatedButton(
        text: "Quản lý thể loại",
        onPressed: () {
          onTapThemTheLoaiButton(context);
        });
  }

  onTapTuSachDaDocButton(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder:
            (context) => TusachdadocScreen()
        )
    );
  }

  onTapThongTinCaNhanButton(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder:
            (context) => ThongtincanhanScreen()
        )
    );
  }

  onTapSachCuaToiButton(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder:
            (context) => SachcuatoiScreen()
        )
    );
  }

  onTapTusachyeuthichButton(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder:
            (context) => TusachyeuthichScreen()
        )
    );
  }

  onTapTxtLogOut(BuildContext context) {
    Provider.of<UserData>(context, listen: false).setUserId(null);
    Provider.of<UserData>(context, listen: false).setAdminCheck(null);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CanhanChuadangnhapScreen(),
      ),
    );
  }

  onTapThemSachMoiButton(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder:
            (context) => ThemsachScreen()
        )
    );
  }

  onTapThemTheLoaiButton(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder:
            (context) => DanhsachtheloaiadminPage()
        )
    );
  }
}
