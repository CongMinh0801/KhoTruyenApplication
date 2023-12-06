import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../book_data.dart';
import '../../user_data.dart';
import '../tusachdadoc_screen/widgets/tusachdadoc_item_widget.dart';
import '../sach_screen/sach_screen.dart';
import 'package:lang_s_application4/core/app_export.dart';

class TusachdadocScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 14.v),
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Tủ sách đã đọc",
                                  style: theme.textTheme.titleLarge,
                                ),
                              ),
                              SizedBox(height: 11.v),
                              _buildTuSachDaDoc(context),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTuSachDaDoc(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;

    return Align(
      alignment: Alignment.center,
      child: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          Map<String, dynamic>? userData = snapshot.data?.data() as Map<String, dynamic>?;

          if (userData == null || userData['truyen_da_doc'] == null) {
            return Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text('Chưa có lịch sử đọc'),
            );
          }

          List<dynamic>? sachDaDoc = userData['truyen_da_doc'];
          if (sachDaDoc?.isEmpty ?? true) {
            return Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text('Chưa có lịch sử đọc'),
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: sachDaDoc!.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildBook(context, sachDaDoc[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildBook(BuildContext context, dynamic sachData) {
    String bookID = sachData["sach_id"] ?? 'Unknown Book';

    return FutureBuilder<DocumentSnapshot>(
      future: getSachDocument(bookID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        Map<String, dynamic>? sachDocument = snapshot.data?.data() as Map<String, dynamic>?;

        if (sachDocument == null || sachDocument['ten_sach'] == null) {
          return Text('Unknown Book');
        }

        String bookName = sachDocument['ten_sach'];

        return TusachdadocItemWidget(
          onTapBook: () {
            onTapBook(context, bookName);
          },
          sachData: sachData,
        );
      },
    );
  }

  Future<DocumentSnapshot> getSachDocument(String bookID) async {
    return await FirebaseFirestore.instance.collection('sach').doc(bookID).get();
  }


  void onTapBook(BuildContext context, String bookData) {
    Provider.of<BookData>(context, listen: false).setBookId(bookData);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SachScreen(),
      ),
    );
  }
}
