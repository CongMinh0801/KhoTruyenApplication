import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgHomeLightBlueA700,
      activeIcon: ImageConstant.imgHomeLightBlueA700,
      type: BottomBarEnum.Homelightbluea700,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgBookmarkLight,
      activeIcon: ImageConstant.imgBookmarkLight,
      type: BottomBarEnum.Bookmarklight,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgDeskAltLight,
      activeIcon: ImageConstant.imgDeskAltLight,
      type: BottomBarEnum.Deskaltlight,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgIcon,
      activeIcon: ImageConstant.imgIcon,
      type: BottomBarEnum.Icon,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.v,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: appTheme.gray9000a,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              -2,
            ),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: Container(
              decoration: AppDecoration.fillPrimary,
              child: CustomImageView(
                imagePath: bottomMenuList[index].icon,
                height: 24.adaptSize,
                width: 24.adaptSize,
                color: theme.colorScheme.onSecondaryContainer,
                margin: EdgeInsets.symmetric(vertical: 16.v),
              ),
            ),
            activeIcon: Container(
              decoration: AppDecoration.fillPrimary,
              child: CustomImageView(
                imagePath: bottomMenuList[index].activeIcon,
                height: 24.v,
                width: 24.h,
                color: appTheme.lightBlueA700,
                margin: EdgeInsets.symmetric(vertical: 18.v),
              ),
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

enum BottomBarEnum {
  Homelightbluea700,
  Bookmarklight,
  Deskaltlight,
  Icon,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.type,
  });

  String icon;

  String activeIcon;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
