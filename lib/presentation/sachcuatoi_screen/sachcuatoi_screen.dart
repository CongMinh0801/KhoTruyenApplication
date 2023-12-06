import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../../user_data.dart';
import '../sachcuatoi_screen/widgets/booklist_item_widget.dart';

class SachcuatoiScreen extends StatelessWidget {
  SachcuatoiScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 12.0,
          ),
          child: Column(
            children: [
              Text(
                "Sách của tôi",
                // Replace with your actual text style
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 13.0),
              _buildBookList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookList(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('sach')
          .where('id_nguoi_dang', isEqualTo: userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        List<DocumentSnapshot> documents = snapshot.data!.docs;

        return Expanded(
          child: StaggeredGridView.countBuilder(
            shrinkWrap: true,
            primary: false,
            crossAxisCount: 4,
            crossAxisSpacing: 37.69,
            mainAxisSpacing: 37.69,
            staggeredTileBuilder: (index) {
              return StaggeredTile.fit(2);
            },
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var sachData = documents[index].data() as Map<String, dynamic>;
              return BooklistItemWidget(sachData: sachData);
            },
          ),
        );
      },
    );
  }

}

