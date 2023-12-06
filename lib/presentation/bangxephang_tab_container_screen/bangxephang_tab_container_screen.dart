import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/presentation/bangxephang_page/bangxephang_page.dart';
import 'package:lang_s_application4/widgets/custom_elevated_button.dart';

class BangxephangTabContainerScreen extends StatefulWidget {
  const BangxephangTabContainerScreen({Key? key}) : super(key: key);

  @override
  BangxephangTabContainerScreenState createState() => BangxephangTabContainerScreenState();
}

class BangxephangTabContainerScreenState extends State<BangxephangTabContainerScreen> with TickerProviderStateMixin {
  late TabController tabviewController;
  late int sortValue; // 0: Tháng, 1: Tuần, 2: Ngày
  late List<Map<String, dynamic>> theLoaiData;

  @override
  void initState() {
    super.initState();
    sortValue = 0; // Mặc định chọn theo tháng
    tabviewController = TabController(length: 0, vsync: this);
    theLoaiData = [];
    _fetchTheLoaiData();
  }

  Future<void> _fetchTheLoaiData() async {
    theLoaiData = await fetchData('the_loai');
    tabviewController = TabController(length: theLoaiData.length, vsync: this);
    setState(() {});
  }

  Future<void> updateSortValue(int value) async {
    setState(() {
      sortValue = value;
    });
  }

  Future<List<Map<String, dynamic>>> fetchData(String collectionName) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection(collectionName).get();
      return querySnapshot.docs.map((doc) => doc.data()! as Map<String, dynamic>).toList();
    } catch (e) {
      print('Lỗi khi lấy dữ liệu: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 8.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 17.h, bottom: 20.0),
                  child: Text(
                    "Bảng xếp hạng",
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              ),
              SizedBox(height: 2.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomElevatedButton(
                      height: 30.v,
                      width: 93.h,
                      text: "Theo tháng",
                      buttonStyle: sortValue == 0
                          ? CustomButtonStyles.fillLightBlueTL4
                          : CustomButtonStyles.fillGrayTL4,
                      buttonTextStyle: CustomTextStyles.titleSmallPrimary,
                      onPressed: () => updateSortValue(0),
                    ),
                    CustomElevatedButton(
                      height: 30.v,
                      width: 93.h,
                      text: "Theo tuần",
                      buttonStyle: sortValue == 1
                          ? CustomButtonStyles.fillLightBlueTL4
                          : CustomButtonStyles.fillGrayTL4,
                      buttonTextStyle: CustomTextStyles.titleSmallPrimary,
                      onPressed: () => updateSortValue(1),
                    ),
                    CustomElevatedButton(
                      height: 30.v,
                      width: 93.h,
                      text: "Theo ngày",
                      buttonStyle: sortValue == 2
                          ? CustomButtonStyles.fillLightBlueTL4
                          : CustomButtonStyles.fillGrayTL4,
                      buttonTextStyle: CustomTextStyles.titleSmallPrimary,
                      onPressed: () => updateSortValue(2),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 9.v),
              Divider(
                indent: 16.h,
                endIndent: 16.h,
              ),
              SizedBox(height: 4.v),
              Container(
                height: 34,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 14.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: TabBar(
                    controller: tabviewController,
                    isScrollable: true,
                    labelPadding: EdgeInsets.zero,
                    tabs: [
                      for (int i = 0; i < theLoaiData.length; i++)
                        Tab(
                          child: Container(
                            height: 24.v,
                            width: 93.h,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(15.h),
                            ),
                            child: Center(
                              child: Text(
                                theLoaiData[i]["ten_the_loai"],
                                style: TextStyle(
                                  color: appTheme.lightBlueA700,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 635.v,
                  child: TabBarView(
                    controller: tabviewController,
                    children: [
                      for (int i = 0; i < theLoaiData.length; i++)
                        BangxephangPage(sortValue: sortValue,
                          tenTheLoai: theLoaiData[i]["ten_the_loai"])
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.v),
            ],
          ),
        ),
      ),
    );
  }
}
