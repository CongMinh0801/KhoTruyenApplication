import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lang_s_application4/book_data.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/presentation/sach_danhsachchuong_screen/sach_danhsachchuong_screen.dart';
import 'package:lang_s_application4/widgets/app_bar/appbar_leading_image.dart';
import 'package:lang_s_application4/widgets/app_bar/appbar_trailing_image.dart';
import 'package:lang_s_application4/widgets/app_bar/custom_app_bar.dart';
import 'package:lang_s_application4/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

import '../../user_data.dart';

class SachScreen extends StatelessWidget {
  const SachScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? bookData = Provider.of<BookData>(context).bookData;
    String? userID = Provider.of<UserData>(context).userId;
    print(bookData);
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getSachDocument(bookData), // Replace with the desired book name
          builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Đã xảy ra lỗi: ${snapshot.error}');
            } else if (!snapshot.hasData || !snapshot.data!.exists) {
              return Text('Không tìm thấy sách');
            } else {
              Map<String, dynamic> sachData = snapshot.data!.data()!;
              return _buildSachScreen(context, sachData, snapshot.data!.id);
            }
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 35.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 17.h, top: 4.v, bottom: 4.v),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgVectorRed400,
          margin: EdgeInsets.symmetric(horizontal: 14.h),
          onTap: () {
            onTapArrowRight(context);
          },
        ),
      ],
    );
  }

  Widget _buildSachScreen(BuildContext context, Map<String, dynamic> sachData, String? sachID) {
    String tenSach = sachData['ten_sach'] ?? '';
    String tacGia = sachData['tac_gia'] ?? '';
    List<dynamic> theLoaiList = sachData['the_loai'] ?? [];
    String theLoai = theLoaiList.join(', ');
    String moTa = sachData['gioi_thieu'] ?? '';

    return SingleChildScrollView(
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 17.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              imagePath: sachData["anh_bia"],
              height: 338.v,
              width: 221.h,
              radius: BorderRadius.circular(20.h),
              alignment: Alignment.center,
            ),
            SizedBox(height: 16.v),
            Align(
              alignment: Alignment.center,
              child: Text(
                tenSach,
                style: CustomTextStyles.titleMediumPoppinsGray900,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                tacGia,
                style: CustomTextStyles.titleMediumPoppinsGray50001,
              ),
            ),

            SizedBox(height: 16.v),
            Text(
              "Thể loại: ${theLoai}",
              style: CustomTextStyles.titleMediumPoppinsGray900,
            ),
            SizedBox(height: 6.v),
            Text(
              theLoai,
              style: CustomTextStyles.bodyMediumPoppinsGray50001,
            ),
            SizedBox(height: 16.v),
            SizedBox(
              width: 354.h,
              child: Text(
                moTa,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.bodyMediumPoppinsGray50001,
              ),
            ),
            SizedBox(height: 20.v),
            _buildDanhSachChuong(context, sachID),
          ],
        ),
      ),
    );
  }

  Widget _buildDanhSachChuong(BuildContext context, String? sachID) {
    return CustomElevatedButton(
      height: 55.v,
      width: 173.h,
      text: "Danh sách chương",
      margin: EdgeInsets.only(left: 109.h, right: 108.h, bottom: 12.v),
      buttonStyle: CustomButtonStyles.fillLightBlueATL10,
      buttonTextStyle: CustomTextStyles.titleSmallPoppinsPrimary,
      onPressed: () {
        onTapDanhSachChuong(context, sachID);
      },
    );
  }

  void onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  void onTapArrowRight(BuildContext context) async {
    String? bookData = Provider.of<BookData>(context, listen: false).bookData;
    String? userID = Provider.of<UserData>(context, listen: false).userId;

    // Get the document ID of the book with the given name
    String? bookID = await getBookID(bookData);

    if (bookID != null && userID != null) {
      // Get the user document
      DocumentReference<Map<String, dynamic>> userDocRef =
      FirebaseFirestore.instance.collection('users').doc(userID);

      // Get the user data
      DocumentSnapshot<Map<String, dynamic>> userSnapshot = await userDocRef.get();

      if (userSnapshot.exists) {
        List<dynamic> truyenYeuThich = userSnapshot['truyen_yeu_thich'] ?? [];

        // Check if the book is already in favorites
        bool isFavorite = truyenYeuThich.any((item) => item['sach_id'] == bookID);

        if (isFavorite) {
          // Remove the book from favorites
          truyenYeuThich.removeWhere((item) => item['sach_id'] == bookID);
          await userDocRef.update({'truyen_yeu_thich': truyenYeuThich});

          // Print and show a message
          print('Đã bỏ yêu thích');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Đã bỏ yêu thích'),
          ));
        } else {
          // Add the book to favorites
          truyenYeuThich.add({'sach_id': bookID, 'last_update': DateTime.now().toString()});
          await userDocRef.update({'truyen_yeu_thich': truyenYeuThich});

          // Print and show a message
          print('Đã thêm vào yêu thích');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Đã thêm vào yêu thích'),
          ));
        }
      }
    }
  }

// Function to get the document ID of the book with the given name
  Future<String?> getBookID(String? bookName) async {
    if (bookName != null) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('sach')
          .where('ten_sach', isEqualTo: bookName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        print('Không tìm thấy sách');
        return null;
      }
    } else {
      print('Tên sách không được để trống');
      return null;
    }
  }


  void onTapDanhSachChuong(BuildContext context, String? sachID) {
    Provider.of<BookData>(context, listen: false).setBookDocID(sachID);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SachDanhsachchuongScreen(),
      ),
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getSachDocument(String? bookName) async {
    if (bookName != null) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('sach').where('ten_sach', isEqualTo: bookName).get();
      return querySnapshot.docs.isNotEmpty ? querySnapshot.docs.first : throw Exception('Document not found');
    } else {
      throw Exception('Book name is null');
    }
  }
}
