import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/presentation/canhan_screen/canhan_screen.dart';
import 'package:lang_s_application4/presentation/danhsachtheloaiadmin_page/danhsachtheloaiadmin_page.dart';
import 'package:lang_s_application4/widgets/custom_outlined_button.dart';
import 'package:lang_s_application4/widgets/custom_text_form_field.dart';

class OverlaythemtheloaiScreen extends StatelessWidget {
  OverlaythemtheloaiScreen({Key? key}) : super(key: key);

  TextEditingController tenTheLoaiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray4004c,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: _buildThemeLoi(context),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeLoi(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 35.h,
        vertical: 13.v,
      ),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFormField(
            controller: tenTheLoaiController,
            hintText: "Tên thể loại",
            textInputAction: TextInputAction.done,
            suffix: Container(
              margin: EdgeInsets.fromLTRB(30.h, 30.v, 2.h, 1.v),
              child: CustomImageView(
                imagePath: ImageConstant.imgEmoticonoutline,
                height: 15.v,
                width: 10.h,
              ),
            ),
            suffixConstraints: BoxConstraints(
              maxHeight: 80.v,
            ),
            contentPadding: EdgeInsets.only(
              left: 16.h,
              top: 30.v,
              bottom: 30.v,
            ),
          ),
          SizedBox(height: 11.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    text: "Xác nhận",
                    margin: EdgeInsets.only(right: 15.h),
                    buttonStyle: CustomButtonStyles.outlineDeepPurple,
                    onPressed: () => onTapXacNhan(context),
                  ),
                ),
                Expanded(
                  child: CustomOutlinedButton(
                    text: "Hủy",
                    margin: EdgeInsets.only(left: 15.h),
                    buttonStyle: CustomButtonStyles.outlineGray,
                    onPressed: () => onTapHuy(context),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.v),
        ],
      ),
    );
  }

  void onTapHuy(BuildContext context) {
    Navigator.pop(context);
  }

  void onTapXacNhan(BuildContext context) async {
    String tenTheLoai = tenTheLoaiController.text.trim();

    if (tenTheLoai.isNotEmpty) {
      try {
        // Add the new the_loai document to Firestore
        await FirebaseFirestore.instance.collection('the_loai').add({
          'ten_the_loai': tenTheLoai,
        });

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Thể loại đã được thêm thành công"),
        ));

        // Close the overlay
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DanhsachtheloaiadminPage(),
          ),
        );
      } catch (error) {
        // Handle error, e.g., show an error message
        print('Error adding thể loại: $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Thêm thể loại thất bại: $error"),
        ));
      }
    } else {
      // Show an error message if the text field is empty
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Vui lòng nhập tên thể loại"),
      ));
    }
  }
}
