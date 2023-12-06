import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lang_s_application4/core/app_export.dart';
import '../bangxephang_page/widgets/bangxephang_item_widget.dart';

class BangxephangPage extends StatefulWidget {
  const BangxephangPage({Key? key, required this.sortValue, required this.tenTheLoai})
      : super(key: key);

  final int sortValue;
  final String tenTheLoai;

  @override
  _BangxephangPageState createState() => _BangxephangPageState();
}

class _BangxephangPageState extends State<BangxephangPage>
    with AutomaticKeepAliveClientMixin<BangxephangPage> {
  @override
  bool get wantKeepAlive => true;

  late List<Map<String, dynamic>> sachData = [];

  @override
  void initState() {
    super.initState();
    _fetchSachData();
  }

  Future<void> _fetchSachData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('sach').get();

      sachData = querySnapshot.docs
          .where((doc) => (doc['the_loai'] as List<dynamic>).contains(widget.tenTheLoai))
          .map((doc) => doc.data()! as Map<String, dynamic>)
          .toList();

      // Sắp xếp dữ liệu theo giá trị của sortValue
      switch (widget.sortValue) {
        case 0:
          sachData.sort((a, b) =>
          ((b['so_luot_doc']['theo_thang']).compareTo(a['so_luot_doc']['theo_thang']) ?? 0)!);
          break;
        case 1:
          sachData.sort((a, b) =>
          ((b['so_luot_doc']['theo_tuan']).compareTo(a['so_luot_doc']['theo_tuan']) ?? 0)!);
          break;
        case 2:
          sachData.sort((a, b) =>
          ((b['so_luot_doc']['theo_ngay']).compareTo(a['so_luot_doc']['theo_ngay']) ?? 0)!);
          break;
      }

      setState(() {});
    } catch (e) {
      print('Lỗi khi lấy dữ liệu: $e');
    }
  }

  @override
  void didUpdateWidget(covariant BangxephangPage oldWidget) {
    if (widget.sortValue != oldWidget.sortValue) {
      // Gọi lại hàm _fetchSachData khi sortValue thay đổi
      _fetchSachData();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: Scaffold(
        body: _buildScrollView(context),
      ),
    );
  }

  Widget _buildScrollView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 8.v),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (sachData.length > 0)
                ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12.v);
                  },
                  itemCount: sachData.length > 10 ? 10 : sachData.length,
                  itemBuilder: (context, index) {
                    return BangxephangItemWidget(
                      sortValue: widget.sortValue,
                      index: index,
                      sachData: sachData[index],
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
}
