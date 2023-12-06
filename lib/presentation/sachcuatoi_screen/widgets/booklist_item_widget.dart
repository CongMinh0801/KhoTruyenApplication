import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/presentation/overlayxacnhanxoasach_dialog/overlayxacnhanxoasach_dialog.dart';
import 'package:lang_s_application4/presentation/sach_chinhsuaone_screen/sach_chinhsuaone_screen.dart';
import 'package:lang_s_application4/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

import '../../../book_data.dart';
import '../../sach_screen/sach_screen.dart';

class BooklistItemWidget extends StatelessWidget {
  BooklistItemWidget({Key? key, this.sachData}) : super(key: key);

  final Map<String, dynamic>? sachData;
  TextEditingController buttonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapSach(context, sachData?["ten_sach"] ?? "");
      },
      child: Column(
        children: [
          CustomImageView(
            imagePath: sachData?["anh_bia"],
            height: 225.v,
            width: 157.h,
          ),
          SizedBox(
            width: 129.h,
            child: Text(
              sachData?["ten_sach"],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: CustomTextStyles.titleMediumBlack900Bold.copyWith(
                height: 1.29,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 9.h),
            child: CustomTextFormField(
              width: 129.h,
              controller: buttonController,
              alignment: Alignment.centerLeft,
              prefix: GestureDetector(
                onTap: () {
                  // Handle when Prefix Container is pressed
                  handleEdit(context);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 30.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgEditlightTeal400,
                    height: 35.adaptSize,
                    width: 35.adaptSize,
                  ),
                ),
              ),
              prefixConstraints: BoxConstraints(
                maxHeight: 35.v,
              ),
              suffix: GestureDetector(
                onTap: () {
                  // Handle when Suffix Container is pressed
                  handleDelete(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 30.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgTrashlight,
                    height: 35.adaptSize,
                    width: 35.adaptSize,
                  ),
                ),
              ),
              suffixConstraints: BoxConstraints(
                maxHeight: 35.v,
              ),
            ),
          ),
        ],
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

  void handleEdit(BuildContext context) {
    Provider.of<BookData>(context, listen: false).setSachChinhSua(sachData?["anh_bia"]);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SachChinhsuaoneScreen()),
    );
  }

  void handleDelete(BuildContext context) {
    Provider.of<BookData>(context, listen: false).setSachXoa(sachData?["anh_bia"]);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OverlayxacnhanxoasachDialog(),
      ),
    );
  }
}
