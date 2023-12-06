import 'package:lang_s_application4/presentation/theloai_screen/widgets/theloai_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';
import '../sach_screen/sach_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TheloaiScreen extends StatefulWidget {
  const TheloaiScreen({Key? key}) : super(key: key);

  @override
  TheloaiState createState() => TheloaiState();
}

class TheloaiState extends State<TheloaiScreen>
    with TickerProviderStateMixin {
  late TabController tabviewController;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  late List<Map<String, dynamic>> sachData = [];
  late List<Map<String, dynamic>> theLoaiData = [];

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 0, vsync: this);
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // Fetch data from the "sach" collection
      QuerySnapshot<Map<String, dynamic>> sachQuerySnapshot =
      await FirebaseFirestore.instance.collection('sach').get();
      sachData = sachQuerySnapshot.docs
          .map((doc) => doc.data()! as Map<String, dynamic>)
          .toList();

      // Fetch data from the "the_loai" collection
      QuerySnapshot<Map<String, dynamic>> theLoaiQuerySnapshot =
      await FirebaseFirestore.instance.collection('the_loai').get();
      theLoaiData = theLoaiQuerySnapshot.docs
          .map((doc) => doc.data()! as Map<String, dynamic>)
          .toList();
      tabviewController =
          TabController(length: theLoaiData.length, vsync: this);
      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
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
                    "Phân loại",
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              ),
              SizedBox(height: 2.v),
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
                              color: appTheme.lightBlueA700,
                              borderRadius: BorderRadius.circular(15.h),
                            ),
                            child: Center(
                              child: Text(
                                theLoaiData[i]["ten_the_loai"],
                                style: TextStyle(
                                  color: Colors.white,
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
                        TheloaiPage(
                          theLoaiData: theLoaiData[i],
                          sachData: filterSachData(theLoaiData[i]["ten_the_loai"]),
                        ),
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

  List<Map<String, dynamic>> filterSachData(String theLoai) {
    return sachData
        .where((sach) => (sach["the_loai"] as List<dynamic>)
        .contains(theLoai))
        .toList();
  }
}

class TheloaiPage extends StatefulWidget {
  final Map<String, dynamic> theLoaiData;
  final List<Map<String, dynamic>> sachData;

  const TheloaiPage({
    Key? key,
    required this.theLoaiData,
    required this.sachData,
  }) : super(key: key);

  @override
  TheloaiPageState createState() => TheloaiPageState();
}

class TheloaiPageState extends State<TheloaiPage>
    with AutomaticKeepAliveClientMixin<TheloaiPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: _buildScrollView(context),
      ),
    );
  }

  Widget _buildScrollView(BuildContext context) {
    // Sort the sachData by the "last_update" field in descending order
    widget.sachData.sort((b, a) {
      DateTime? dateA = DateTime.tryParse(a['last_update'] ?? '');
      DateTime? dateB = DateTime.tryParse(b['last_update'] ?? '');
      if (dateA != null && dateB != null) {
        return dateA.compareTo(dateB);
      }
      return 0;
    });

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 8.v),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.sachData.length > 0)
                ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12.v);
                  },
                  itemCount: widget.sachData.length > 10
                      ? 10
                      : widget.sachData.length,
                  itemBuilder: (context, index) {
                    return TheloaiItemWidget(
                      index: index,
                      sachData: widget.sachData[index],
                    );
                  },
                )
              else
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Hiện chưa có sách thể loại này"),
                ),
            ],
          ),
        ],
      ),
    );
  }

  onTapSach(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SachScreen()),
    );
  }
}

