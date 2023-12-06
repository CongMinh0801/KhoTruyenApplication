import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/widgets/custom_outlined_button.dart';

class SachdanhsachchuonglistItemWidget extends StatelessWidget {
  SachdanhsachchuonglistItemWidget({
    Key? key,
    this.onTapChng,
    this.chuongData, // Define chuongData as a field
  }) : super(key: key);

  final VoidCallback? onTapChng;
  final QueryDocumentSnapshot<Object?>? chuongData;

  @override
  Widget build(BuildContext context) {

    return CustomOutlinedButton(
      height: 50.v,
      width: 356.h,
      text: chuongData?["ten_chuong"],
      buttonStyle: CustomButtonStyles.outlineBlack,
      buttonTextStyle: CustomTextStyles.titleMediumPoppinsBlack900,
      onPressed: () {
        onTapChng?.call();
      },
    );
  }
}