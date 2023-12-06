import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';
import '../../book_data.dart';
import '../../user_data.dart';
import '../home_page/widgets/seventyfive_item_widget.dart';
import '../home_page/widgets/seventyfour_item_widget.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/widgets/custom_search_view.dart';
import 'package:lang_s_application4/presentation/sach_screen/sach_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> querySnapshotSach = [];
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> querySnapshotTheloai = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshotSach =
      await FirebaseFirestore.instance.collection('sach').get();
      QuerySnapshot<Map<String, dynamic>> querySnapshotTheloai =
      await FirebaseFirestore.instance.collection('the_loai').get();
      setState(() {
        this.querySnapshotSach = querySnapshotSach.docs;
        this.querySnapshotTheloai = querySnapshotTheloai.docs;
      });
    } catch (e) {
      print('Lỗi khi lấy dữ liệu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillPrimary,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 7.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.h),
                    child: CustomSearchView(
                      controller: searchController,
                      hintText: "Search",
                    ),
                  ),
                  SizedBox(height: 21.v),
                  CustomImageView(
                    imagePath: ImageConstant.imgDocSach1,
                    height: 241.v,
                    width: 374.h,
                    radius: BorderRadius.circular(4.h),
                    margin: EdgeInsets.only(left: 2.h),
                  ),
                  SizedBox(height: 8.v),
                  Padding(
                    padding: EdgeInsets.only(left: 11.h),
                    child: Text(
                      "Hệ thống đề xuất",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: 7.v),
                  _buildSeventyFive(context),
                  SizedBox(height: 20.v),
                  Padding(
                    padding: EdgeInsets.only(left: 11.h),
                    child: Row(
                      children: [
                        Text(
                          "Tác phẩm Hot",
                          style: theme.textTheme.titleLarge,
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgHome,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                          margin: EdgeInsets.only(left: 4.h),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 7.v),
                  _buildContainerHorizontal(context),
                  SizedBox(height: 29.v),
                  Padding(
                    padding: EdgeInsets.only(left: 10.h),
                    child: Row(
                      children: [
                        Text(
                          "Lịch sử đọc",
                          style: theme.textTheme.titleLarge,
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgRefresh,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                          margin: EdgeInsets.only(left: 6.h),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 7.v),
                  _buildSeventyFour(context),
                  SizedBox(height: 29.v),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeventyFive(BuildContext context) {
    if (querySnapshotSach.isNotEmpty) {
      // Sort querySnapshotSach based on the "last_update" field
      querySnapshotSach.sort((b, a) {
        String dateA = a['last_update'];
        String dateB = b['last_update'];
        return DateTime.parse(dateA).compareTo(DateTime.parse(dateB));
      });

      List<Widget> itemList = querySnapshotSach.map((snapshot) {
        Map<String, dynamic> sachData = snapshot.data()! as Map<String, dynamic>;
        return SeventyfiveItemWidget(
          onTapSach: () {
            onTapSach(context, sachData["ten_sach"]);
          },
          sachData: sachData,
        );
      }).toList();

      return SizedBox(
        height: 226.v,
        child: ListView.separated(
          padding: EdgeInsets.only(left: 8.h, right: 94.h),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return SizedBox(width: 40.h);
          },
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return itemList[index];
          },
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  Widget _buildContainerHorizontal(BuildContext context) {
    if (querySnapshotSach.isNotEmpty) {
      // Sort querySnapshotSach based on the "luot_doc.toan_bo" field in descending order
      querySnapshotSach.sort((a, b) {
        int luotDocA = a['so_luot_doc']['toan_bo'];
        int luotDocB = b['so_luot_doc']['toan_bo'];
        return luotDocB.compareTo(luotDocA);
      });

      List<Widget> itemList = querySnapshotSach.map((snapshot) {
        Map<String, dynamic> sachData = snapshot.data()! as Map<String, dynamic>;
        return _containerHorizontalItem(
          onTapSach: () {
            onTapSach(context, sachData["ten_sach"]);
          },
          sachData: sachData,
        );
      }).toList();

      return SizedBox(
        height: 246.v,
        child: ListView.separated(
          padding: EdgeInsets.only(left: 8.h, right: 94.h),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return SizedBox(width: 40.h);
          },
          itemCount: 5,
          itemBuilder: (context, index) {
            return itemList[index];
          },
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  Widget _containerHorizontalItem({VoidCallback? onTapSach, required Map<String, dynamic> sachData}) {
    return InkWell(
      onTap: onTapSach,
      child: SizedBox(
        width: 125.h,
        child: Column(
          children: [
            CustomImageView(
              imagePath: sachData["anh_bia"] ?? "", // Replace with the actual field name in your data
              height: 180.v,
              width: 125.h,
            ),
            SizedBox(
              width: 103.h,
              child: Text(
                sachData['ten_sach'], // Replace with the actual field name in your data
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleSmall!.copyWith(
                  height: 1.29,
                ),
              ),
            ),
            SizedBox(height: 9.v),
            Text("${sachData['so_luot_doc']['toan_bo']} lượt đọc", style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildSeventyFour(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    final bool _isUserIdEmpty = userId?.isEmpty ?? true;
    if (userId == null || _isUserIdEmpty) {
      return Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Text('Hãy đăng nhập để xem lịch sử đọc'),
      );
    } else {
      return FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Đã xảy ra lỗi: ${snapshot.error}');
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return Text('Chưa có lịch sử đọc');
          } else {
            DocumentSnapshot<Map<String, dynamic>> userData = snapshot.data!;
            Map<String, dynamic>? userDataMap = userData.data();
            List<dynamic>? sachHistory = userDataMap?['truyen_da_doc'];

            if (sachHistory != null && sachHistory.isNotEmpty) {
              // Lấy danh sách các sách dựa trên sach_id từ querySnapshotSach
              List<Map<String, dynamic>> booksData = sachHistory
                  .map((sachData) {
                String? sachId = sachData['sach_id'];
                // Tìm sách trong querySnapshotSach theo sach_id
                DocumentSnapshot<Map<String, dynamic>>? bookSnapshot = querySnapshotSach.firstWhereOrNull(
                      (snapshot) => snapshot.id == sachId,
                );
                // Trả về dữ liệu sách nếu tìm thấy, ngược lại trả về một giá trị mặc định
                return bookSnapshot?.data() as Map<String, dynamic>? ?? {'default_field': 'default_value'};
              })
                  .toList();

              // Remove null elements from booksData
              booksData.removeWhere((element) => element == null);

              // Sắp xếp danh sách sách dựa trên last_update
              booksData.sort((a, b) {
                DateTime? dateA = DateTime.tryParse(a['last_update'] ?? '');
                DateTime? dateB = DateTime.tryParse(b['last_update'] ?? '');
                if (dateA != null && dateB != null) {
                  return dateA.compareTo(dateB);
                }
                return 0;
              });

              List<Widget> itemList = booksData.map((sachData) {
                return SeventyfourItemWidget(
                  onTapSach: () {
                    onTapSach(context, sachData["ten_sach"]);
                  },
                  sachData: sachData,
                );
              }).toList();

              int itemCount = itemList.length > 5 ? 5 : itemList.length;

              return SizedBox(
                height: 226.v,
                child: ListView.separated(
                  padding: EdgeInsets.only(left: 8.h, right: 94.h),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 30.h);
                  },
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    return itemList[index];
                  },
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text('Chưa có lịch sử đọc'),
              );
            }
          }
        },
      );
    }
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