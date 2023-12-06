import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';
import 'package:lang_s_application4/presentation/login_screen/login_screen.dart';
import 'package:lang_s_application4/widgets/custom_elevated_button.dart';
import 'package:lang_s_application4/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

import '../../user_data.dart';
import '../canhan_screen/canhan_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}


class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  TextEditingController confirmPasswordFieldController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(height: 73.v),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 5.v),
                        child: Column(
                          children: [
                            Text("Create Account", style: theme.textTheme.headlineLarge),
                            SizedBox(height: 6.v),
                            Container(
                              width: 320.h,
                              margin: EdgeInsets.symmetric(horizontal: 18.h),
                              child: Text(
                                "Create an account so you can explore all the existing jobs",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.titleSmallPoppins,
                              ),
                            ),
                            SizedBox(height: 71.v),
                            _buildUsername(context),
                            SizedBox(height: 26.v),
                            _buildPassword(context),
                            SizedBox(height: 26.v),
                            _buildConFirmPassword(context),
                            SizedBox(height: 53.v),
                            _buildSignUpButton(context),
                            SizedBox(height: 30.v),
                            _buildAlreadyHaveAnAccountButton(context),
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
      controller: usernameFieldController,
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
      controller: passwordFieldController,
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

  Widget _buildConFirmPassword(BuildContext context) {
    return CustomTextFormField(
      controller: confirmPasswordFieldController,
      hintText: "Confirm Password",
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.visiblePassword,
      obscureText: true,
      maxLines: 1,
      borderDecoration: TextFormFieldStyleHelper.fillSecondaryContainer,
      fillColor: theme.colorScheme.secondaryContainer,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your confirm password.';
        }
        return null;
      },
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return CustomElevatedButton(
      height: 60.v,
      text: "Sign up",
      buttonStyle: CustomButtonStyles.outlineBlue,
      buttonTextStyle: CustomTextStyles.titleLargePoppinsPrimary,
      onPressed: () {
        onDangKy(context);
      },
    );
  }

  Widget _buildAlreadyHaveAnAccountButton(BuildContext context) {
    return CustomElevatedButton(
      height: 41.v,
      text: "Already have an account",
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.titleSmallPoppinsPrimaryContainer,
      onPressed: () {
        onHaveAccount(context);
      },
    );
  }

  onHaveAccount(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  Future<void> onDangKy(BuildContext context) async {
    try {
      if (_formKey.currentState?.validate() ?? false) {
        final String username = usernameFieldController.text.trim();
        final String password = passwordFieldController.text.trim();
        final String confirm = confirmPasswordFieldController.text.trim();

        if (password == confirm) {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('username', isEqualTo: username)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            // Tài khoản đã tồn tại
            _showErrorDialog(context, 'Invalid Credentials', 'Tài khoản đã tồn tại');
          } else {
            // Tài khoản chưa tồn tại, thêm mới
            await FirebaseFirestore.instance.collection('users').add({
              'username': username,
              'password': password,
              'quyen_admin': false,
              'truyen_da_doc': [],
              'truyen_yeu_thich': [],// Thêm các trường khác nếu cần
            });

            // Lấy thông tin vừa thêm để hiển thị hoặc thực hiện các hành động khác
            QuerySnapshot newQuerySnapshot = await FirebaseFirestore.instance
                .collection('users')
                .where('username', isEqualTo: username)
                .get();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          }
        } else {
          _showErrorDialog(context, 'Invalid Credentials', 'Xác nhận mật khẩu thất bại');
        }
      }
    } catch (e) {
      print("Error during registration: $e");
    }
  }

  void _showErrorDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
          content: Text(
            content,
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
