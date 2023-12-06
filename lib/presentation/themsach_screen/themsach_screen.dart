import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/presentation/sachcuatoi_screen/sachcuatoi_screen.dart';
import 'package:lang_s_application4/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';

import '../../book_data.dart';
import '../../user_data.dart';
import '../overlaychinhsuathongtin_screen/overlaychinhsuathongtin_screen.dart';

class ThemsachScreen extends StatefulWidget {
  const ThemsachScreen({Key? key}) : super(key: key);

  @override
  _ThemsachScreenState createState() => _ThemsachScreenState();
}

class _ThemsachScreenState extends State<ThemsachScreen> {
  String? _downloadURL;
  Map<String, dynamic>? sach;

  @override
  Widget build(BuildContext context) {
    String? anhBia = Provider.of<BookData>(context, listen: false).anh_bia;
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 17.h, right: 90.h, bottom: 5.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.v),
                  CustomImageView(
                    imagePath: ImageConstant.imgArrowLeft,
                    height: 15.v,
                    width: 18.h,
                    onTap: () {
                      onTapImgArrowLeft(context);
                    },
                  ),
                  SizedBox(height: 8.v),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        onTapImage(context);
                      },
                      child: anhBia != null
                          ? Container(
                        height: 320.v,
                        width: 215.h,
                        decoration: AppDecoration.fillErrorContainer.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder8,
                        ),
                        child: Image.network(anhBia!, fit: BoxFit.cover),
                      )
                          : Container(
                        height: 320.v,
                        width: 215.h,
                        padding: EdgeInsets.symmetric(vertical: 127.v),
                        decoration: AppDecoration.fillErrorContainer.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder8,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: CustomImageView(
                            imagePath: ImageConstant.imgAddRoundLight,
                            height: 64.adaptSize,
                            width: 64.adaptSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 29.v),
                  _buildBookDetailsButton(context),
                  SizedBox(height: 18.v),
                  _buildAuthorButton(context),
                  SizedBox(height: 18.v),
                  _buildGenreButton(context),
                  SizedBox(height: 16.v),
                  _buildDescriptionButton(context),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildUploadButton(context),
      ),
    );
  }

  Widget _buildBookDetailsButton(BuildContext context) {
    String? tenSach = Provider.of<BookData>(context, listen: false).ten_sach;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          Flexible( // Wrap with Flexible
            child: Text(
              "Tên sách: ${tenSach}",
              style: CustomTextStyles.titleLargePoppinsGray900SemiBold,
            ),
          ),
          GestureDetector(
            onTap: () {
              onTapChinhSua(context, "ten_sach");
            },
            child: Container(
              margin: EdgeInsets.only(left: 18.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgEditlightTeal400,
                height: 35.adaptSize,
                width: 35.adaptSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthorButton(BuildContext context) {
    String? tacGia = Provider.of<BookData>(context, listen: false).tac_gia;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          Flexible(
            child: Text(
              "Tác giả: ${tacGia}",
              style: CustomTextStyles.titleLargePoppinsGray900SemiBold,
            ),
          ),
          GestureDetector(
            onTap: () {
              onTapChinhSua(context, "tac_gia");
            },
            child: Container(
              margin: EdgeInsets.only(left: 18.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgEditlightTeal400,
                height: 35.adaptSize,
                width: 35.adaptSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenreButton(BuildContext context) {
    String? theLoai = Provider.of<BookData>(context, listen: false).the_loai;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          Flexible(
            child: Text(
              "Thể loại: ${theLoai}",
              style: CustomTextStyles.titleLargePoppinsGray900SemiBold,
            ),
          ),
          GestureDetector(
            onTap: () {
              onTapChinhSua(context, "the_loai");
            },
            child: Container(
              margin: EdgeInsets.only(left: 18.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgEditlightTeal400,
                height: 35.adaptSize,
                width: 35.adaptSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionButton(BuildContext context) {
    String? moTa = Provider.of<BookData>(context, listen: false).mo_ta;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          Flexible(
            child: Text(
              "Mô tả: ${moTa}",
              style: CustomTextStyles.titleLargePoppinsGray900SemiBold,
            ),
          ),
          GestureDetector(
            onTap: () {
              onTapChinhSua(context, "gioi_thieu");
            },
            child: Container(
              margin: EdgeInsets.only(left: 18.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgEditlightTeal400,
                height: 35.adaptSize,
                width: 35.adaptSize,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildUploadButton(BuildContext context) {
    return CustomElevatedButton(
      height: 55.v,
      width: 173.h,
      text: "Upload",
      margin: EdgeInsets.only(left: 109.h, right: 108.h, bottom: 13.v),
      buttonStyle: CustomButtonStyles.fillLightBlueATL10,
      buttonTextStyle: CustomTextStyles.titleSmallPoppinsPrimary,
      onPressed: () {
        onTapUploadButton(context);
      },
    );
  }

  onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  onTapChinhSua(BuildContext context, String newSachInfo) {
    Provider.of<UserData>(context, listen: false).setInfo("");
    Provider.of<BookData>(context, listen: false).setOldSachInfo("");
    Provider.of<BookData>(context, listen: false).setNewSachInfo(newSachInfo);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OverlaychinhsuathongtinScreen(),
      ),
    );
  }

  onTapImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      await uploadImageToFirebase(pickedFile);
      setState(() {}); // Cập nhật giao diện
    } else {
      print('Người dùng chưa chọn ảnh.');
    }
  }

  Future<void> uploadImageToFirebase(XFile pickedFile) async {
    try {
      await Firebase.initializeApp();

      firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref().child(
        '${DateTime.now().millisecondsSinceEpoch}.png',
      );

      firebase_storage.SettableMetadata metadata =
      firebase_storage.SettableMetadata(
        contentType: 'image/png',
      );

      await storageReference.putFile(
        File(pickedFile.path),
        metadata,
      );

      _downloadURL = await storageReference.getDownloadURL();
      Provider.of<BookData>(context, listen: false).setAnhBia(_downloadURL);
    } catch (error) {
      print('Lỗi khi tải ảnh lên Firebase Storage: $error');
    }
  }

  onTapUploadButton(BuildContext context) async {
    String? tenSach = Provider.of<BookData>(context, listen: false).ten_sach;
    String? tacGia = Provider.of<BookData>(context, listen: false).tac_gia;
    String? theLoai = Provider.of<BookData>(context, listen: false).the_loai;
    String? moTa = Provider.of<BookData>(context, listen: false).mo_ta;
    String? userID = Provider.of<UserData>(context, listen: false).userId;
    String? anhBia = Provider.of<BookData>(context, listen: false).anh_bia;

    if (anhBia != null &&
        tenSach != null &&
        tacGia != null &&
        theLoai != null &&
        moTa != null) {
      sach = {
        "ten_sach": tenSach,
        "tac_gia": tacGia,
        "the_loai": theLoai.split(", "),
        "gioi_thieu": moTa,
        "anh_bia": anhBia,
        "id_nguoi_dang": userID,
        "last_update": DateTime.now().toString(),
        "so_luot_doc": {
          "toan_bo": 0,
          "theo_thang": 0,
          "theo_tuan": 0,
          "theo_ngay": 0
        }
      };
    }
    if (sach != null) {
      try {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference booksCollection = firestore.collection('sach');

        // Add the book data to the "sach" collection
        await booksCollection.add(sach!);

        Provider.of<BookData>(context, listen: false).setTenSach(null);
        Provider.of<BookData>(context, listen: false).setTacGia(null);
        Provider.of<BookData>(context, listen: false).setTheLoai(null);
        Provider.of<BookData>(context, listen: false).setMota(null);
        Provider.of<BookData>(context, listen: false).setAnhBia(null);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SachcuatoiScreen(),
          ),
        );
        // Optionally, you can navigate to another screen or perform other actions here
      } catch (error) {
        print('Lỗi khi thêm sách vào Firestore: $error');
      }
    }
  }
}
