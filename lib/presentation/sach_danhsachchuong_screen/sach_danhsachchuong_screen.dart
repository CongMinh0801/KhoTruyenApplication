import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../book_data.dart';
import '../sach_danhsachchuong_screen/widgets/sachdanhsachchuonglist_item_widget.dart';
import '../sach_doc_screen/sach_doc_screen.dart';
import 'package:lang_s_application4/core/app_export.dart';

class SachDanhsachchuongScreen extends StatelessWidget {
  const SachDanhsachchuongScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? bookID = Provider.of<BookData>(context).bookID;

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

        return Container(
          margin: EdgeInsets.only(left: 1.h),
          decoration: AppDecoration.outlineBlack900,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              var document = snapshot.data?.docs[index];
              return SachdanhsachchuonglistItemWidget(
                chuongData: document,
                onTapChng: () {
                  onTapChng(context, document?.id);
                },
              );
            },
          ),
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
}
