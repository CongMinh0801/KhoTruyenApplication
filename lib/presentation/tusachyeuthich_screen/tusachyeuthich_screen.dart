import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lang_s_application4/presentation/sach_screen/sach_screen.dart';
import 'package:lang_s_application4/presentation/tusachyeuthich_screen/widgets/favoritebooksgrid_item_widget.dart';

import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:provider/provider.dart';

import '../../book_data.dart';
import '../../user_data.dart';

class TusachyeuthichScreen extends StatelessWidget {
  const TusachyeuthichScreen({Key? key}) : super(key: key);

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
                                  "Tủ sách yêu thích",
                                  style: theme.textTheme.titleLarge,
                                ),
                              ),
                              SizedBox(height: 11.v),
                              _buildTuSachYeuThich(context),
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

  Widget _buildTuSachYeuThich(BuildContext context) {
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

          if (userData == null || userData['truyen_yeu_thich'] == null) {
            return Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text('Chưa có sách yêu thích'),
            );
          }

          List<dynamic>? sachYeuThich = userData['truyen_yeu_thich'];
          if (sachYeuThich?.isEmpty ?? true) {
            return Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text('Chưa có sách yêu thích'),
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
            itemCount: sachYeuThich!.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildBook(context, sachYeuThich[index]);
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

        return FavoritebooksgridItemWidget(
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

  void onTapBook(BuildContext context, String bookName) {
    Provider.of<BookData>(context, listen: false).setBookId(bookName);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SachScreen(),
      ),
    );
  }
}