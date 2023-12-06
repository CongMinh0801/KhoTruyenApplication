import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lang_s_application4/book_data.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/widgets/custom_outlined_button.dart';

class OverlayxacnhanxoasachDialog extends StatelessWidget {
  const OverlayxacnhanxoasachDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    String? anh_bia_sach_xoa = Provider.of<BookData>(context).sach_xoa;

    return Container(
      width: 370.h,
      padding: EdgeInsets.symmetric(horizontal: 38.h, vertical: 28.v),
      decoration: AppDecoration.fillPrimary
          .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Xác nhận xóa sách đã đăng", style: CustomTextStyles.titleMediumBlack90018),
          SizedBox(height: 23.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  text: "Xác nhận",
                  margin: EdgeInsets.only(right: 15.h),
                  buttonStyle: CustomButtonStyles.outlineDeepPurple,
                  onPressed: () {
                    onTapXcNhn(context);
                  },
                ),
              ),
              Expanded(
                child: CustomOutlinedButton(
                  text: "Hủy",
                  margin: EdgeInsets.only(left: 15.h),
                  buttonStyle: CustomButtonStyles.outlineGray,
                  onPressed: () {
                    onTapHuy(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  onTapHuy(BuildContext context) {
    Navigator.pop(context);
  }

  onTapXcNhn(BuildContext context) async {
    String? anh_bia_sach_xoa =
        Provider.of<BookData>(context, listen: false).sach_xoa;

    CollectionReference sachCollection =
    FirebaseFirestore.instance.collection('sach');

    QuerySnapshot sachQuery = await sachCollection
        .where('anh_bia', isEqualTo: anh_bia_sach_xoa)
        .get();

    if (sachQuery.docs.isNotEmpty) {
      String sachDocumentId = sachQuery.docs[0].id;

      CollectionReference chuongCollection =
      FirebaseFirestore.instance.collection('chuong');

      QuerySnapshot chuongQuery =
      await chuongCollection.where('id-sach', isEqualTo: sachDocumentId).get();

      chuongQuery.docs.forEach((chuongDoc) {
        chuongDoc.reference.delete();
      });

      sachCollection.doc(sachDocumentId).delete();
    }

    Navigator.pop(context);
  }
}
