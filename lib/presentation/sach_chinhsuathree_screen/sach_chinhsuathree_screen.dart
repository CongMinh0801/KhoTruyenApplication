import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/presentation/overlayxacnhanxoachuong_dialog/overlayxacnhanxoachuong_dialog.dart';
import 'package:lang_s_application4/presentation/sach_chinhsuaone_screen/sach_chinhsuaone_screen.dart';
import 'package:lang_s_application4/presentation/sach_chinhsuatwo_screen/sach_chinhsuatwo_screen.dart';

import '../../book_data.dart';
import '../sach_danhsachchuong_screen/widgets/sachdanhsachchuonglist_item_widget.dart';
import '../sach_doc_screen/sach_doc_screen.dart';

class SachChinhsuathreeScreen extends StatelessWidget {
  const SachChinhsuathreeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? anh_bia_sach_chinh_sua =
        Provider.of<BookData>(context, listen: false).sach_chinh_sua;

    // Use FutureBuilder to handle the asynchronous operation
    return FutureBuilder<String?>(
      future: getBookID(anh_bia_sach_chinh_sua),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        String? bookID = snapshot.data;

        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 9.v),
                child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection('sach').doc(bookID).get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    var sachData = snapshot.data!.data() as Map<String, dynamic>;

                    return Column(
                      children: [
                        CustomImageView(
                          imagePath: sachData["anh_bia"],
                          height: 338.v,
                          width: 221.h,
                          radius: BorderRadius.circular(20.h),
                        ),
                        SizedBox(height: 16.v),
                        Text(sachData["ten_sach"], style: CustomTextStyles.titleMediumPoppinsGray900),
                        Text(sachData["tac_gia"], style: CustomTextStyles.titleMediumPoppinsGray50001),
                        SizedBox(height: 19.v),
                        Text("Danh sách chương", style: CustomTextStyles.titleMediumPoppinsLightblueA700),
                        SizedBox(height: 11.v),
                        _buildSachDanhSachChuongList(context, bookID),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSachDanhSachChuongList(BuildContext context, String? bookID) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chuong')
          .where('id-sach', isEqualTo: bookID)
          .orderBy('last_update', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        var chuongList = snapshot.data?.docs;
        var itemCount = chuongList?.length ?? 0;

        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 1.h),
              decoration: AppDecoration.outlineBlack900,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  var document = chuongList?[index];
                  var chuongID = document?.id;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15.h, top: 6.v, bottom: 1.v),
                        child: Text(
                          "${document?["ten_chuong"]}",
                          style: CustomTextStyles.titleMediumPoppinsBlack900,
                        ),
                      ),
                      Spacer(),
                      CustomImageView(
                        imagePath: ImageConstant.imgEditlightTeal400,
                        height: 35.adaptSize,
                        width: 35.adaptSize,
                        margin: EdgeInsets.only(bottom: 1.v),
                        onTap: () {
                          onTapImgEditLight(context, chuongID);
                        },
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgTrashlight,
                        height: 35.adaptSize,
                        width: 35.adaptSize,
                        margin: EdgeInsets.only(left: 8.h, bottom: 1.v),
                        onTap: () {
                          onTapImgTrashLight(context, chuongID);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 16.v), // Add some space between the last item and the new button
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  onTapAdd(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(32.0),
                ),
                child: Text(
                  "Thêm chương mới",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  onTapChng(BuildContext context, String? chuongID) {
    Provider.of<BookData>(context, listen: false).setChuongID(chuongID);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SachDocScreen(),
      ),
    );
  }

  onTapAdd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SachChinhsuatwoScreen(),
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapImgArrowLeft(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SachChinhsuaoneScreen(),
      ),
    );
  }

  /// Navigates to the sachChinhsuatwoScreen when the action is triggered.
  onTapImgEditLight(BuildContext context, String? chuongID) {
    Provider.of<BookData>(context, listen: false).setChuongChinhSua(chuongID);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SachChinhsuatwoScreen(),
      ),
    );
  }

  /// Displays a dialog with the [OverlayxacnhanxoachuongDialog] content.
  onTapImgTrashLight(BuildContext context, String? chuongID) {
    Provider.of<BookData>(context, listen: false).setChuongXoa(chuongID);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: OverlayxacnhanxoachuongDialog(chuongID: chuongID),
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.only(left: 0),
      ),
    );
  }

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
}
