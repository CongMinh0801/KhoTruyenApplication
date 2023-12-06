import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  String? _userId;

  String? get userId => _userId;

  void setUserId(String? userId) {
    _userId = userId;
    notifyListeners();
  }


  String? _adminCheck;

  String? get adminCheck => _adminCheck;

  void setAdminCheck(String? adminCheck) {
    _adminCheck = adminCheck;
    notifyListeners();
  }


  String? _info;

  String? get info => _info;

  void setInfo(String? info) {
    _info = info;
    notifyListeners();
  }
}
