import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:provider/provider.dart';

import '../../book_data.dart';
import '../../user_data.dart';
import '../overlaychinhsuathongtin_screen/overlaychinhsuathongtin_screen.dart';

class ThongtincanhanScreen extends StatelessWidget {
  ThongtincanhanScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  Map<String, dynamic> userData = {};

  Future<void> fetchData(String userId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference usersCollection = firestore.collection('users');
      DocumentSnapshot userDocument = await usersCollection.doc(userId).get();

      if (userDocument.exists) {
        userData = userDocument.data() as Map<String, dynamic>;
        print(userData);
      } else {
        print('Document with ID $userId does not exist');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;

    return FutureBuilder(
      future: fetchData(userId!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (userData.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return buildUI(context);
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildUI(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgVector211x211,
                  height: 211.adaptSize,
                  width: 211.adaptSize,
                ),
                SizedBox(height: 25.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 24.h),
                    child: Text(
                      "Account",
                      style: CustomTextStyles.titleMediumOnPrimaryContainer,
                    ),
                  ),
                ),
                SizedBox(height: 20.v),
                _buildViewsTables(
                  context,
                  userEmail: "Họ tên: ${userData["ho_ten"]}",
                  onTapEditLight: () {
                    onTapEditLight(context, "ho_ten");
                  },
                ),
                SizedBox(height: 16.v),
                _buildViewsTables(
                  context,
                  userEmail: "Email: ${userData["email"]}",
                  onTapEditLight: () {
                    onTapEditLight(context, "email");
                  },
                ),
                SizedBox(height: 16.v),
                _buildViewsTables(
                  context,
                  userEmail: "Giới tính: ${userData["gioi_tinh"] == "0" ? "Nam" : userData["gioi_tinh"] == "1" ? "Nữ" : "Khác"}",
                  onTapEditLight: () {
                    onTapEditLight(context, "gioi_tinh");
                  },
                ),
                SizedBox(height: 16.v),
                _buildViewsTables(
                  context,
                  userEmail: "Ngày sinh: ${userData["ngay_sinh"]}",
                  onTapEditLight: () {
                    onTapEditLight(context, "ngay_sinh");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewsTables(
      BuildContext context, {
        required String userEmail,
        Function? onTapEditLight,
      }) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 5.v),
      decoration: AppDecoration.fillPrimary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 3.v),
            child: Text(
              userEmail,
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgEditLight,
            height: 24.adaptSize,
            width: 24.adaptSize,
            onTap: () {
              onTapEditLight!.call();
            },
          ),
        ],
      ),
    );
  }

  void onTapEditLight(BuildContext context, String? info) {
    Provider.of<UserData>(context, listen: false).setInfo(info);
    Provider.of<BookData>(context, listen: false).setNewSachInfo("");
    Provider.of<BookData>(context, listen: false).setOldSachInfo("");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OverlaychinhsuathongtinScreen(),
      ),
    );
  }
}
