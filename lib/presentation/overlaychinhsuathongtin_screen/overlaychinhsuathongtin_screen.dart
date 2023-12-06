import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lang_s_application4/book_data.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/presentation/sach_chinhsuaone_screen/sach_chinhsuaone_screen.dart';
import 'package:lang_s_application4/presentation/themsach_screen/themsach_screen.dart';
import 'package:lang_s_application4/presentation/thongtincanhan_screen/thongtincanhan_screen.dart';
import 'package:lang_s_application4/user_data.dart';
import 'package:lang_s_application4/widgets/custom_outlined_button.dart';
import 'package:lang_s_application4/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class OverlaychinhsuathongtinScreen extends StatelessWidget {
  OverlaychinhsuathongtinScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController emoticonoutlineController = TextEditingController();

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
            child: _buildChNhSAThNg(context),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildChNhSAThNg(BuildContext context) {
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
            controller: emoticonoutlineController,
            hintText: "Label",
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
                    onPressed: () => onTapXacNhan(context), // Use onTapXacNhan here
                  ),
                ),
                Expanded(
                  child: CustomOutlinedButton(
                    text: "Hủy",
                    margin: EdgeInsets.only(left: 15.h),
                    buttonStyle: CustomButtonStyles.outlineGray,
                    onPressed: () => onTapHuy(context), // Use onTapHuy here
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
    String? newSachInfo = Provider.of<BookData>(context, listen: false).newSachInfo;
    String? info = Provider.of<UserData>(context, listen: false).info;
    if(info != "" && newSachInfo == "") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ThongtincanhanScreen(),
        ),
      );
    } else {
      Navigator.pop(context);
    }

  }

  void onTapXacNhan(BuildContext context) async {
    String updatedInfo = emoticonoutlineController.text.trim();
    String? userId = Provider.of<UserData>(context, listen: false).userId;
    String? info = Provider.of<UserData>(context, listen: false).info;
    String? newSachInfo = Provider.of<BookData>(context, listen: false).newSachInfo;
    String? oldSachInfo = Provider.of<BookData>(context, listen: false).oldSachInfo;
    String? anh_bia_sach_chinh_sua = Provider.of<BookData>(context, listen: false).sach_chinh_sua;
    print(info);
    print(newSachInfo);
    print(oldSachInfo);
    if(info != "" && newSachInfo == "" && oldSachInfo != "") {
      if(info == "gioi_tinh") {
        if(updatedInfo == "Nam"){
          updatedInfo = "0";
        } else if (updatedInfo == "Nữ"){
          updatedInfo = "1";
        } else {
          updatedInfo = "2";
        }
      }

      try {
        // Update the document using the 'set' method with merge: true option
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          "${info}": updatedInfo,
        }, SetOptions(merge: true));

        // Navigate back to the ThongtincanhanScreen after successful update
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ThongtincanhanScreen(),
          ),
        );
      } catch (error) {
        // Handle error, e.g., show a snackbar or dialog
        print('Error updating info: $error');
      }
    } else if (info == "" && newSachInfo == "" && oldSachInfo != "") {
      try {
        await FirebaseFirestore.instance
            .collection('sach')
            .where('anh_bia', isEqualTo: anh_bia_sach_chinh_sua)
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((doc) async {
            await doc.reference.update({
              "${oldSachInfo}":  oldSachInfo == "the_loai" ? updatedInfo.split(", ") : updatedInfo,
            });
          });
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SachChinhsuaoneScreen(),
          ),
        );
      } catch (error) {
        // Handle error, e.g., show a snackbar or dialog
        print('Error updating sach info: $error');
      }
    } else {
      if(newSachInfo == "ten_sach") {
        Provider.of<BookData>(context, listen: false).setTenSach(updatedInfo);
      } else if(newSachInfo == "tac_gia") {
        Provider.of<BookData>(context, listen: false).setTacGia(updatedInfo);
      } else if(newSachInfo == "the_loai") {
        Provider.of<BookData>(context, listen: false).setTheLoai(updatedInfo);
      } else {
        Provider.of<BookData>(context, listen: false).setMota(updatedInfo);
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ThemsachScreen(),
        ),
      );
    }
  }
}
