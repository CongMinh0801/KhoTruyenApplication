import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:lang_s_application4/widgets/custom_elevated_button.dart';
import 'package:lang_s_application4/widgets/custom_text_form_field.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/presentation/canhan_screen/canhan_screen.dart';
import 'package:lang_s_application4/presentation/register_screen/register_screen.dart';

import '../../user_data.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Form(
            key: _formKey,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(vertical: 1.v),
              child: Column(
                children: [
                  SizedBox(height: 112.v),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 5.v),
                        child: Column(
                          children: [
                            Text("Login here", style: theme.textTheme.headlineLarge),
                            SizedBox(height: 22.v),
                            SizedBox(
                              width: 228.h,
                              child: Text(
                                "Welcome back you’ve\nbeen missed!",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.titleLargePoppinsBlack900,
                              ),
                            ),
                            SizedBox(height: 74.v),
                            _buildUsername(context),
                            SizedBox(height: 29.v),
                            _buildPassword(context),
                            SizedBox(height: 30.v),
                            _buildSignIn(context),
                            SizedBox(height: 30.v),
                            _buildCreateNewAccount(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUsername(BuildContext context) {
    return CustomTextFormField(
      controller: usernameController,
      hintText: "Username",
      textInputType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username.';
        }
        return null;
      },
    );
  }

  Widget _buildPassword(BuildContext context) {
    return CustomTextFormField(
      controller: passwordController,
      hintText: "Password",
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.visiblePassword,
      obscureText: true,
      maxLines: 1,
      borderDecoration: TextFormFieldStyleHelper.fillSecondaryContainer,
      fillColor: theme.colorScheme.secondaryContainer,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password.';
        }
        return null;
      },
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return CustomElevatedButton(
      height: 60.v,
      text: "Sign in",
      buttonStyle: CustomButtonStyles.outlineBlue,
      buttonTextStyle: CustomTextStyles.titleLargePoppinsPrimary,
      onPressed: () {
        _onDangNhap(context);
      },
    );
  }

  Widget _buildCreateNewAccount(BuildContext context) {
    return CustomElevatedButton(
      height: 41.v,
      text: "Create new account",
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.titleSmallPoppinsPrimaryContainer,
      onPressed: () {
        _onCreateNewAccount(context);
      },
    );
  }

  Future<void> _onDangNhap(BuildContext context) async {
    try {
      if (_formKey.currentState?.validate() ?? false) {
        final String username = usernameController.text.trim();
        final String password = passwordController.text.trim();

        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: username)
            .where('password', isEqualTo: password)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          String userId = querySnapshot.docs.first.id;
          String adminCheck = querySnapshot.docs.first["quyen_admin"].toString();

          // Sử dụng Provider để lưu trữ userID
          Provider.of<UserData>(context, listen: false).setUserId(userId);
          Provider.of<UserData>(context, listen: false).setAdminCheck(adminCheck);
          print(adminCheck);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CanhanScreen(),
            ),
          );
        } else {
          _showErrorDialog('Invalid Credentials', 'The username or password is incorrect.');
        }
      }
    } catch (e) {
      print("Error during login: $e");
    }
  }

  void _onCreateNewAccount(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  void _showErrorDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: Colors.black), // Thiết lập màu đen cho tiêu đề
          ),
          content: Text(
            content,
            style: TextStyle(color: Colors.black), // Thiết lập màu đen cho nội dung
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black)
              ),
            ),
          ],
        );
      },
    );
  }
}

