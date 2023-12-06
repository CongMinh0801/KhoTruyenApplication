import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';

class TusachdadocItemWidget extends StatelessWidget {
  TusachdadocItemWidget({
    Key? key,
    this.onTapBook,
    required this.sachData,
  }) : super(key: key);

  final VoidCallback? onTapBook;
  final dynamic sachData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapBook,
      child: Container(
        width: 157.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: FutureBuilder<DocumentSnapshot>(
                future: _getSachData(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return Text('Error: Unable to fetch data');
                  } else {
                    String anhBia = snapshot.data!["anh_bia"] ?? 'default_image_path';
                    return CustomImageView(
                      imagePath: anhBia,
                      height: 225.v,
                      width: double.infinity,
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 10.v),
            SizedBox(
              width: double.infinity,
              child: FutureBuilder<DocumentSnapshot>(
                future: _getSachData(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return Text('Error: Unable to fetch data');
                  } else {
                    String title = snapshot.data!["ten_sach"] ?? 'Unknown Title';
                    return Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.titleMediumBlack900Bold.copyWith(
                        height: 1.29,
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 12.v),
          ],
        ),
      ),
    );
  }

  Future<DocumentSnapshot> _getSachData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection('sach');
    String documentId = sachData['sach_id'];
    DocumentSnapshot snapshot = await collection.doc(documentId).get();
    return snapshot;
  }
}
