import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/widgets/custom_outlined_button.dart';

// ignore_for_file: must_be_immutable
class OverlayxacnhanthemtheloaiDialog extends StatelessWidget {
  const OverlayxacnhanthemtheloaiDialog({Key? key})
      : super(
          key: key,
        );

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
          SizedBox(height: 31.v),
          Text(
            "Xác nhận xóa  thể loại sách",
            style: CustomTextStyles.titleMediumBlack90018,
          ),
          SizedBox(height: 23.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  text: "Xác nhận",
                  margin: EdgeInsets.only(right: 15.h),
                ),
              ),
              Expanded(
                child: CustomOutlinedButton(
                  text: "Hủy",
                  margin: EdgeInsets.only(left: 15.h),
                  buttonStyle: CustomButtonStyles.outlineGray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
