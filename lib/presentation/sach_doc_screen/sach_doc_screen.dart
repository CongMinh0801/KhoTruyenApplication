import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/user_data.dart';
import 'package:lang_s_application4/widgets/app_bar/appbar_leading_image.dart';
import 'package:lang_s_application4/widgets/app_bar/appbar_title.dart';
import 'package:lang_s_application4/widgets/app_bar/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../../book_data.dart';

class SachDocScreen extends StatelessWidget {
  Map<String, dynamic>? chuongData; // Declare chuongData as an instance variable
  bool hasPrintedCongratulations = false;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    String? chuongID = Provider.of<BookData>(context).chuongID;
    String? bookName = Provider.of<BookData>(context).bookData;
    String? userID = Provider.of<UserData>(context).userId;

    // Lấy documentID của document thuộc collection "sach" có giá trị field "ten_sach" bằng bookName và gán documentID lấy được cho biến bookID.
    String? bookID;
    FirebaseFirestore.instance
        .collection('sach')
        .where('ten_sach', isEqualTo: bookName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        bookID = querySnapshot.docs.first.id;
      }
    });

    // Đặt hạn chế thời gian chờ là 30 giây
    if (!hasPrintedCongratulations) {
      Future.delayed(Duration(seconds: 30), () async {

        // Thực hiện cập nhật field so_luot_doc của document trong collection "sach" với document ID là biến bookID với giá trị toan_bo tăng thêm 1.
        await updateSoLuotDoc(bookID);

        // Kiểm tra xem trong truyen_da_doc của document thuộc collection "users" có document ID là userID đã có object nào có sach_id cùng giá trị bookID hay chưa.
        bool hasBookID = await checkSachIdInTruyenDaDoc(userID, bookID);

        // Nếu đã có, cập nhật last_update là thời gian hiện tại được lấy bằng Datetime rồi toString().
        // Nếu chưa có, thêm một object mới với sach_id là bookID và last_update là thời gian hiện tại được lấy bằng Datetime rồi toString().
        if (hasBookID) {
          await updateLastUpdateInTruyenDaDoc(userID, bookID);
        } else {
          await addNewObjectInTruyenDaDoc(userID, bookID);
        }
        print("Chúc mừng");

        // Đánh dấu là đã in "chúc mừng"
        hasPrintedCongratulations = true;
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context, chuongID),
        body: SingleChildScrollView(
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              double primaryDelta = details.primaryDelta ?? 0;
              if (primaryDelta > 0) {
                handleChuyenTrang(context, chuongID, isNext: true);
              } else if (primaryDelta < 0) {
                handleChuyenTrang(context, chuongID, isNext: false);
              }
            },
            child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('chuong').doc(chuongID).get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                chuongData = snapshot.data!.data() as Map<String, dynamic>; // Update chuongData

                return Column(
                  children: [
                    Container(
                      width: 358.h,
                      margin: EdgeInsets.fromLTRB(16.h, 13.v, 16.h, 6.v),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: chuongData!["noi_dung"],
                              style: CustomTextStyles.titleMediumPoppinsGray50001_2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, String? chuongID) {
    return CustomAppBar(
      height: 53.v,
      leadingWidth: 33.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 15.h, bottom: 38.v),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      centerTitle: true,
      title: Column(
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('chuong').doc(chuongID).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              chuongData = snapshot.data!.data() as Map<String, dynamic>; // Update chuongData

              return AppbarTitle(text: chuongData!["ten_chuong"]);
            },
          ),
        ],
      ),
    );
  }

  void onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  void handleChuyenTrang(BuildContext context, String? chuongID, {required bool isNext}) async {
    // Fetch the list of documents with the same 'id-sach' and order them by 'last_update'
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('chuong')
        .where('id-sach', isEqualTo: chuongData!["id-sach"])
        .orderBy('last_update', descending: true)
        .get();

    List<String> documentIds = querySnapshot.docs.map((doc) => doc.id).toList();
    int currentIndex = documentIds.indexWhere((doc) => doc == chuongID);
    int nextChuongID = currentIndex + 1;
    int prevChuongID = currentIndex - 1;

    if (isNext && currentIndex < documentIds.length - 1) {
      Provider.of<BookData>(context, listen: false).setChuongID(documentIds[nextChuongID]);
    } else if (!isNext && currentIndex > 0) {
      Provider.of<BookData>(context, listen: false).setChuongID(documentIds[prevChuongID]);
    }
  }

  // Thêm phương thức để cập nhật field so_luot_doc của document trong collection "sach"
  Future<void> updateSoLuotDoc(String? bookID) async {
    await FirebaseFirestore.instance.collection('sach').doc(bookID).update({
      'so_luot_doc.toan_bo': FieldValue.increment(1),
    });
  }

  // Thêm phương thức để kiểm tra xem trong truyen_da_doc của document thuộc collection "users" có document ID là userID đã có object nào có sach_id cùng giá trị bookID hay chưa.
  Future<bool> checkSachIdInTruyenDaDoc(String? userID, String? bookID) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userID).get();
    List<dynamic> truyenDaDoc = userDoc['truyen_da_doc'];

    for (var item in truyenDaDoc) {
      if (item['sach_id'] == bookID) {
        return true;
      }
    }

    return false;
  }

  // Thêm phương thức để cập nhật last_update trong truyen_da_doc của document thuộc collection "users"
  Future<void> updateLastUpdateInTruyenDaDoc(String? userID, String? bookID) async {
    // Lấy danh sách hiện tại của truyen_da_doc
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userID).get();
    List<dynamic> truyenDaDoc = userDoc['truyen_da_doc'];

    // Loại bỏ đối tượng có sach_id bằng bookID từ danh sách
    truyenDaDoc.removeWhere((obj) => obj['sach_id'] == bookID);

    // Cập nhật lại trường truyen_da_doc với danh sách đã cập nhật
    await FirebaseFirestore.instance.collection('users').doc(userID).update({
      'truyen_da_doc': truyenDaDoc,
    });

    // Thêm đối tượng mới vào truyen_da_doc
    await FirebaseFirestore.instance.collection('users').doc(userID).update({
      'truyen_da_doc': FieldValue.arrayUnion([
        {'sach_id': bookID, 'last_update': DateTime.now().toString()}
      ]),
    });
  }

  // Thêm phương thức để thêm một object mới vào truyen_da_doc của document thuộc collection "users"
  Future<void> addNewObjectInTruyenDaDoc(String? userID, String? bookID) async {
    await FirebaseFirestore.instance.collection('users').doc(userID).update({
      'truyen_da_doc': FieldValue.arrayUnion([
        {'sach_id': bookID, 'last_update': DateTime.now().toString()}
      ]),
    });
  }
}
