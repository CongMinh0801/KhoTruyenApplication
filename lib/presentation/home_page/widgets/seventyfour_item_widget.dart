import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';

// ignore: must_be_immutable
class SeventyfourItemWidget extends StatelessWidget {
  SeventyfourItemWidget({
    Key? key,
    this.onTapSach,
    required this.sachData,
  }) : super(key: key);

  VoidCallback? onTapSach;
  final Map<String, dynamic> sachData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 125.h,
      child: GestureDetector(
        onTap: () {
          onTapSach?.call();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.v),
          child: Column(
            children: [
              CustomImageView(
                imagePath: sachData["anh_bia"],
                height: 180.v,
                width: 115.h,
              ),
              SizedBox(
                width: 103.h,
                child: Text(
                  sachData["ten_sach"] ?? "Default Title", // Use a default value if "ten_sach" is null
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleSmall!.copyWith(
                    height: 1.29,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
