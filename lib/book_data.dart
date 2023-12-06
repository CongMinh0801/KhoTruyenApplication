import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class BookData with ChangeNotifier {
  String? _bookData;
  String? _sach_xoa;
  String? _anh_bia;
  String? _mo_ta;
  String? _tac_gia;
  String? _the_loai;
  String? _newSachInfo;
  String? _oldSachInfo;
  String? _chuongID;
  String? _ten_sach;
  String? _bookID;
  String? _sach_chinh_sua;
  String? _chuong_chinh_sua;
  String? _chuong_xoa;

  String? get bookData => _bookData;

  void setBookId(String? bookData) {
    _bookData = bookData;
    notifyListeners();
  }



  String? get bookID => _bookID;

  void setBookDocID(String? bookID) {
    _bookID = bookID;
    notifyListeners();
  }



  String? get chuongID => _chuongID;

  void setChuongID(String? chuongID) {
    _chuongID = chuongID;
    notifyListeners();
  }



  String? get newSachInfo => _newSachInfo;

  void setNewSachInfo(String? newSachInfo) {
    _newSachInfo = newSachInfo;
    notifyListeners();
  }

  String? get oldSachInfo => _oldSachInfo;

  void setOldSachInfo(String? oldSachInfo) {
    _oldSachInfo = oldSachInfo;
    notifyListeners();
  }




  String? get ten_sach => _ten_sach;

  void setTenSach(String? ten_sach) {
    _ten_sach = ten_sach;
    notifyListeners();
  }




  String? get the_loai => _the_loai;

  void setTheLoai(String? the_loai) {
    _the_loai = the_loai;
    notifyListeners();
  }



  String? get tac_gia => _tac_gia;

  void setTacGia(String? tac_gia) {
    _tac_gia = tac_gia;
    notifyListeners();
  }



  String? get mo_ta => _mo_ta;

  void setMota(String? mo_ta) {
    _mo_ta = mo_ta;
    notifyListeners();
  }



  String? get anh_bia => _anh_bia;

  void setAnhBia(String? anh_bia) {
    _anh_bia = anh_bia;
    notifyListeners();
  }




  String? get sach_xoa => _sach_xoa;

  void setSachXoa(String? sach_xoa) {
    _sach_xoa = sach_xoa;
    notifyListeners();
  }

  String? get sach_chinh_sua => _sach_chinh_sua;

  void setSachChinhSua(String? sach_chinh_sua) {
    _sach_chinh_sua = sach_chinh_sua;
    notifyListeners();
  }


  String? get chuong_chinh_sua => _chuong_chinh_sua;

  void setChuongChinhSua(String? chuong_chinh_sua) {
    _chuong_chinh_sua = chuong_chinh_sua;
    notifyListeners();
  }

  String? get chuong_xoa => _chuong_xoa;

  void setChuongXoa(String? chuong_xoa) {
    _chuong_xoa = chuong_xoa;
    notifyListeners();
  }
}
