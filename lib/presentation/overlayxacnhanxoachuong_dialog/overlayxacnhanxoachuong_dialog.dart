import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/widgets/custom_outlined_button.dart';
import 'package:provider/provider.dart';

import '../../book_data.dart';
import '../sach_chinhsuathree_screen/sach_chinhsuathree_screen.dart';

class OverlayxacnhanxoachuongDialog extends StatelessWidget {
  final String? chuongID;

  const OverlayxacnhanxoachuongDialog({Key? key, this.chuongID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Container(
      width: 370.h,
      padding: EdgeInsets.symmetric(
        horizontal: 38.h,
        vertical: 28.v,
      ),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 32.v),
          Text(
            "Xác nhận xóa Chương",
            style: CustomTextStyles.titleMediumBlack90018,
          ),
          SizedBox(height: 22.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  text: "Xác nhận",
                  margin: EdgeInsets.only(right: 15.h),
                  buttonStyle: CustomButtonStyles.outlineDeepPurple,
                  onPressed: () => onTapXacNhan(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> onTapXacNhan(BuildContext context) async {
    try {
      String? chuongID = Provider.of<BookData>(context, listen: false).chuong_xoa;

      // Delete the document from the "chuong" collection
      await FirebaseFirestore.instance.collection('chuong').doc(chuongID).delete();

      // Close the overlay dialog
      Navigator.pop(context);

      // You can also navigate to SachChinhsuathreeScreen if needed
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => SachChinhsuathreeScreen(),
      //   ),
      // );
    } catch (error) {
      print('Error deleting chuong document: $error');
      // Handle error as needed
    }
  }

}
