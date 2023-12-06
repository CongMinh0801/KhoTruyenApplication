import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/presentation/sach_chinhsuathree_screen/sach_chinhsuathree_screen.dart';
import 'package:lang_s_application4/widgets/custom_elevated_button.dart';
import 'package:lang_s_application4/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../book_data.dart';

class SachChinhsuatwoScreen extends StatelessWidget {
  SachChinhsuatwoScreen({Key? key}) : super(key: key);

  TextEditingController emoticonoutlineController = TextEditingController();
  TextEditingController emoticonoutlineController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 7.h, vertical: 4.v),
            child: Column(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgArrowLeft,
                  height: 15.v,
                  width: 18.h,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 5.h),
                  onTap: () {
                    onTapImgArrowLeft(context);
                  },
                ),
                SizedBox(height: 6.v),
                Text(
                  "Nhập tên chương",
                  style: CustomTextStyles.titleMediumPoppinsBlack900,
                ),
                SizedBox(height: 6.v),
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
                  suffixConstraints: BoxConstraints(maxHeight: 460.v),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 9.v,
                  ),
                ),
                SizedBox(height: 20.v),
                Text(
                  "Nhập Nội dung",
                  style: CustomTextStyles.titleMediumPoppinsBlack900,
                ),
                SizedBox(height: 6.v),
                CustomTextFormField(
                  controller: emoticonoutlineController1,
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
                  suffixConstraints: BoxConstraints(maxHeight: 460.v),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 9.v,
                  ),
                ),
                SizedBox(height: 20.v),
                CustomElevatedButton(
                  height: 55.v,
                  width: 173.h,
                  text: "Xác nhận",
                  buttonStyle: CustomButtonStyles.fillLightBlueATL10,
                  buttonTextStyle: CustomTextStyles.titleSmallPoppinsPrimary,
                  onPressed: () {
                    onTapXacNhan(context);
                  },
                ),
                SizedBox(height: 5.v)
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTapImgArrowLeft(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SachChinhsuathreeScreen(),
      ),
    );
  }

  onTapXacNhan(BuildContext context) async {
    String? anh_bia_sach_chinh_sua = Provider.of<BookData>(context, listen: false).sach_chinh_sua;
    String? chuongChinhSua = Provider.of<BookData>(context, listen: false).chuong_chinh_sua;


    print(chuongChinhSua);
    // Lấy documentID từ collection "sach" có field "anh_bia" bằng với anh_bia_sach_chinh_sua
    if(chuongChinhSua == null) {
      String? bookID = await getBookID(anh_bia_sach_chinh_sua);

      // Lấy giá trị từ các controllers
      String tenChuong = emoticonoutlineController.text;
      String noiDung = emoticonoutlineController1.text;

      // Thêm một document vào collection "chuong"
      await addChuongDocument(bookID, tenChuong, noiDung);
    } else {
      String tenChuong = emoticonoutlineController.text;
      String noiDung = emoticonoutlineController1.text;

      // Thêm một document vào collection "chuong"
      await updateChuongDocument(chuongChinhSua, tenChuong, noiDung);
    }


    // Navigate đến SachChinhsuathreeScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SachChinhsuathreeScreen(),
      ),
    );
  }

  // Lấy documentID từ collection "sach" có field "anh_bia" bằng với anh_bia_sach_chinh_sua
  Future<String?> getBookID(String? anhBia) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('sach')
        .where('anh_bia', isEqualTo: anhBia)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    }

    return null;
  }

  // Thêm một document vào collection "chuong"
  Future<void> addChuongDocument(
      String? bookID, String tenChuong, String noiDung) async {
    await FirebaseFirestore.instance.collection('chuong').add({
      'ten_chuong': tenChuong,
      'noi_dung': noiDung,
      'id-sach': bookID,
      'last_update': DateTime.now().toString(),
    });
  }


  Future<void> updateChuongDocument(String? chuongChinhSua, String tenChuong, String noiDung) async {
    // Kiểm tra xem documentID có giá trị không
    if (chuongChinhSua != null) {
      try {
        // Truy cập collection "chuong" và lấy document theo documentID
        DocumentReference chuongRef = FirebaseFirestore.instance.collection('chuong').doc(chuongChinhSua);

        // Lấy dữ liệu hiện tại của document
        DocumentSnapshot chuongDoc = await chuongRef.get();

        // Kiểm tra xem document có tồn tại không
        if (chuongDoc.exists) {
          // Cập nhật giá trị của field "ten_chuong" và "noi_dung"
          await chuongRef.update({
            'ten_chuong': tenChuong,
            'noi_dung': noiDung,
          });
          print('Document updated successfully!');
        } else {
          print('Document does not exist.');
        }
      } catch (e) {
        print('Error updating document: $e');
      }
    } else {
      print('Invalid documentID');
    }
  }
}
