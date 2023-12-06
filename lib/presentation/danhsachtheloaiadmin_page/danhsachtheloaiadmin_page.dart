import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lang_s_application4/core/app_export.dart';
import '../../widgets/custom_elevated_button2.dart';
import '../overlaythemtheloai_screen/overlaythemtheloai_screen.dart';

class DanhsachtheloaiadminPage extends StatefulWidget {
  const DanhsachtheloaiadminPage({Key? key}) : super(key: key);

  @override
  _DanhsachtheloaiadminPageState createState() => _DanhsachtheloaiadminPageState();
}

class _DanhsachtheloaiadminPageState extends State<DanhsachtheloaiadminPage> {
  late Future<QuerySnapshot> theLoaiListFuture;

  @override
  void initState() {
    super.initState();
    theLoaiListFuture = FirebaseFirestore.instance.collection('the_loai').get();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillWhiteA,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 8.v,
              ),
              decoration: AppDecoration.fillWhiteA.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder8,
              ),
              child: Column(
                children: [
                  FutureBuilder<QuerySnapshot>(
                    future: theLoaiListFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      List<DocumentSnapshot> theLoaiList = snapshot.data!.docs;

                      return Column(
                        children: [
                          for (int index = 0; index < theLoaiList.length; index++)
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: _buildViewsTables(context, theLoaiList[index]),
                            ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 16.v),
                  _buildThemTheLoaiButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewsTables(BuildContext context, DocumentSnapshot theLoaiSnapshot) {
    var theLoaiItem = theLoaiSnapshot.data() as Map<String, dynamic>;
    String tenTheLoai = theLoaiItem["ten_the_loai"];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 6.v,
              bottom: 5.v,
            ),
            child: Text(
              tenTheLoai,
              style: theme.textTheme.bodyLarge,
            ),
          ),
          _buildContentIsHereButton1(context, theLoaiSnapshot),
        ],
      ),
    );
  }

  Widget _buildContentIsHereButton1(BuildContext context, DocumentSnapshot theLoaiSnapshot) {
    return ElevatedButton(
      onPressed: () {
        handleXoa(context, theLoaiSnapshot.reference);
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(80.0, 30.0),
      ),
      child: Text("Xóa"),
    );
  }

  handleXoa(BuildContext context, DocumentReference theLoaiRef) async {
    try {
      await theLoaiRef.delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Thể loại đã được xóa thành công"),
      ));

      // Trigger a rebuild of the widget after successful deletion
      setState(() {
        theLoaiListFuture = FirebaseFirestore.instance.collection('the_loai').get();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Xóa thể loại thất bại: $e"),
      ));
    }
  }

  Widget _buildThemTheLoaiButton(BuildContext context) {
    return CustomElevatedButton2(
      text: "Thêm thể loại",
      onPressed: () => onTapThemTheLoai(context)
    );
  }


  void onTapThemTheLoai(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OverlaythemtheloaiScreen(),
      ),
    );
  }
}
