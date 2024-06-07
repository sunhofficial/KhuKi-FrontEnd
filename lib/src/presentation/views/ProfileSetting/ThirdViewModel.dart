import 'package:flutter/material.dart';
import 'package:khukiting/src/domain/repository/UserRepository.dart';

class ThirdViewModel extends ChangeNotifier {
  final TextEditingController infoController = TextEditingController();
  final UserRepository _userRepository;
  bool isValidText = false;
  int selectedCookie = 1;
  final List<String> cookieList = ["normal.png", "khu.png", "white.png"];
  ThirdViewModel(this._userRepository) {
    infoController.addListener(_validateFields);
  }
  void _validateFields() {
    if (infoController.text.length > 10 || infoController.text.isEmpty) {
      isValidText = false;
    } else {
      isValidText = true;
    }
    notifyListeners();
  }

  void selectCookie(int index) {
    selectedCookie = index;
    notifyListeners();
  }

  @override
  void dispose() {
    infoController.dispose();
    super.dispose();
  }

  Future<bool> postCookie() async {
    if (!isValidText) return false;
    final response =
        await _userRepository.postMyCookie(infoController.text, selectedCookie);
    if (response.status == 200) {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> putCookie() async {
    if (!isValidText) return false;
    final response =
        await _userRepository.putMyCookie(infoController.text, selectedCookie);
    if (response.status == 200) {
      return true;
    } else {
      return false;
    }
  }
}
