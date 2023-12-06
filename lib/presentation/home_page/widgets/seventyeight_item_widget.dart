import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';

// ignore: must_be_immutable
class SeventyeightItemWidget extends StatelessWidget {
  SeventyeightItemWidget({
    Key? key,
    this.onTapSach,
  }) : super(
    key: key,
  );

  VoidCallback? onTapSach;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 125.h,
      child: GestureDetector(
        onTap: () {
          onTapSach!.call();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.v),
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgImg21,
                height: 180.v,
                width: 115.h,
              ),
              SizedBox(
                width: 103.h,
                child: Text(
                  "Harry Potter và Hoàng Tử Lai",
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
