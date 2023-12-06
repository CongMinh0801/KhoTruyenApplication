import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:provider/provider.dart';

import '../../../book_data.dart';
import '../../sach_screen/sach_screen.dart';

class TheloaiItemWidget extends StatelessWidget {
  const TheloaiItemWidget({
    Key? key,
    required this.index,
    required this.sachData,// Thêm khởi tạo cho sortValue
  }) : super(key: key);

  final int index;
  final Map<String, dynamic>? sachData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapSach(context, sachData?["ten_sach"]);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center, // Đặt CrossAxisAlignment.center để căn giữa theo chiều dọc
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  (index + 1).toString(),
                  style: index == 0
                      ? CustomTextStyles.titleLargeRed500
                      : index == 1
                      ? CustomTextStyles.titleLargeOrangeA700
                      : index == 2
                      ? CustomTextStyles.titleLargeAmber400
                      : CustomTextStyles.titleLargeBlack900,
                ),
              ),
            ),
            CustomImageView(
              imagePath: sachData?["anh_bia"],
              height: 204.v,
              width: 142.h,
              margin: EdgeInsets.only(top: 2.v, left: 6.h),
            ),
            SizedBox(width: 10.h),
            Expanded(
              flex: 10,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 2.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 180.h,
                      child: Text(
                        sachData?["ten_sach"]?.toString() ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.titleMediumBlack900.copyWith(
                          height: 1.13,
                        ),
                      ),
                    ),
                    SizedBox(height: 9.v),
                    Text(
                      "Tác giả: ${sachData?["tac_gia"]?.toString() ?? ""}",
                      style: theme.textTheme.bodyMedium,
                    ),
                    SizedBox(height: 8.v),
                    Text(
                      "Thể loại: ${sachData?["the_loai"]?.join(', ') ?? ""}",
                      style: theme.textTheme.bodyMedium,
                    ),
                    SizedBox(height: 9.v),
                    SizedBox(
                      width: 185.h,
                      child: Text(
                        "${sachData?["gioi_thieu"]?.toString() ?? ""}",
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall!.copyWith(
                          height: 1.45,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.v),
                    Text(
                      "Số lượt đọc: ${sachData?["so_luot_doc"]?["toan_bo"] ?? ""}",
                      style: CustomTextStyles.bodyMediumLightblueA700,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapSach(BuildContext context, String bookData) {
    Provider.of<BookData>(context, listen: false).setBookId(bookData);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SachScreen(),
      ),
    );
  }
}
