import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/presentation/overlaychinhsuathongtin_screen/overlaychinhsuathongtin_screen.dart';
import 'package:lang_s_application4/presentation/sach_chinhsuathree_screen/sach_chinhsuathree_screen.dart';
import 'package:lang_s_application4/presentation/sachcuatoi_screen/sachcuatoi_screen.dart';
import 'package:lang_s_application4/user_data.dart';
import 'package:lang_s_application4/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

import '../../book_data.dart';

class SachChinhsuaoneScreen extends StatelessWidget {
  const SachChinhsuaoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? anh_bia_sach_chinh_sua = Provider.of<BookData>(context).sach_chinh_sua;
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('sach').where('anh_bia', isEqualTo: anh_bia_sach_chinh_sua).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            var sachData = snapshot.data?.docs.first.data() as Map<String, dynamic>?;


            return SizedBox(
              width: mediaQueryData.size.width,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 17.h, right: 17.h, bottom: 5.v),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgArrowLeft,
                        height: 15.v,
                        width: 18.h,
                        onTap: () {
                          onTapImgArrowLeft(context);
                        },
                      ),
                      SizedBox(height: 8.v),
                      SizedBox(
                        height: 655.v,
                        width: 354.h,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            _buildBookDetailsSection(context, anh_bia_sach_chinh_sua, sachData),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 66.h),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomImageView(
                                      imagePath: sachData?["anh_bia"],
                                      height: 338.v,
                                      width: 221.h,
                                      radius: BorderRadius.circular(20.h),
                                    ),
                                    Text(
                                      sachData?["ten_sach"] ?? "N/A",
                                      style: CustomTextStyles.titleMediumPoppinsGray900,
                                    ),
                                    Text(
                                      sachData?["tac_gia"] ?? "N/A",
                                      style: CustomTextStyles.titleMediumPoppinsGray50001,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgEditlightTeal400,
                              height: 35.adaptSize,
                              width: 35.adaptSize,
                              alignment: Alignment.bottomRight,
                              margin: EdgeInsets.only(right: 32.h, bottom: 259.v),
                              onTap: () {
                                onTapImgEditLight(context, "tac_gia");
                              },
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgEditlightTeal400,
                              height: 35.adaptSize,
                              width: 35.adaptSize,
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(top: 330.v, right: 32.h),
                              onTap: () {
                                onTapImgEditLight(context, "ten_sach");
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: _buildChapterListSection(context),
      ),
    );
  }

  Widget _buildBookDetailsSection(BuildContext context, String? anh_bia_sach_chinh_sua, Map<String, dynamic>? sachData) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 31.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Thể loại",
                      style: CustomTextStyles.titleMediumPoppinsGray900,
                    ),
                    SizedBox(height: 6.v),
                    Text(
                      sachData?["the_loai"]?.join(",  ") ?? "N/A",
                      style: CustomTextStyles.bodyMediumPoppinsGray50001,
                    )
                  ],
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgEditlightTeal400,
                  height: 35.adaptSize,
                  width: 35.adaptSize,
                  margin: EdgeInsets.only(top: 19.v),
                  onTap: () {
                    onTapImgEditLight(context, "the_loai");
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16.v),
          Text(
            "Mô tả",
            style: CustomTextStyles.titleMediumPoppinsGray900,
          ),
          SizedBox(height: 7.v),
          SizedBox(
            width: 354.h,
            child: Text(
              sachData?["gioi_thieu"] ?? "N/A",
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.bodyMediumPoppinsGray50001,
            ),
          ),
          SizedBox(height: 4.v),
          CustomImageView(
            imagePath: ImageConstant.imgEditlightTeal400,
            height: 35.adaptSize,
            width: 35.adaptSize,
            onTap: () {
              onTapImgEditLight(context, "gioi_thieu");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChapterListSection(BuildContext context) {
    return CustomElevatedButton(
      height: 55.v,
      width: 173.h,
      text: "Danh sách chương",
      margin: EdgeInsets.only(left: 109.h, right: 108.h, bottom: 13.v),
      buttonStyle: CustomButtonStyles.fillLightBlueATL10,
      buttonTextStyle: CustomTextStyles.titleSmallPoppinsPrimary,
      onPressed: () {
        onTapChapterListSection(context);
      },
    );
  }

  onTapImgArrowLeft(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SachcuatoiScreen(),
      ),
    );
  }

  onTapImgEditLight(BuildContext context, String field) {
    Provider.of<BookData>(context, listen: false).setOldSachInfo(field);
    Provider.of<BookData>(context, listen: false).setNewSachInfo("");
    Provider.of<UserData>(context, listen: false).setInfo("");
    print(field);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OverlaychinhsuathongtinScreen(),
      ),
    );
  }

  onTapChapterListSection(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SachChinhsuathreeScreen(),
      ),
    );
  }
}
