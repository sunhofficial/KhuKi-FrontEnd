import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khukiting/src/domain/repository/UserRepository.dart';

class SecondViewModel extends ChangeNotifier {
   final TextEditingController idController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController restaurantController = TextEditingController();
  final UserRepository _userRepository;
  bool _isButtonDisabled = true;
  SecondViewModel(this._userRepository) {
    idController.addListener(_validateFields);
    messageController.addListener(_validateFields);
    restaurantController.addListener(_validateFields);
  }
  bool get isButtonDisabled => _isButtonDisabled;
   void _validateFields() {
    if (idController.text.isNotEmpty &&
        messageController.text.isNotEmpty &&
        restaurantController.text.isNotEmpty) {
      _isButtonDisabled = false;
    } else {
      _isButtonDisabled = true;
    }
    notifyListeners();
  }
   @override
  void dispose() {
    idController.dispose();
    messageController.dispose();
    restaurantController.dispose();
    super.dispose();
  }
  Future<bool> submitProfile() async {
    if (isButtonDisabled) return false;
    final response = await _userRepository.putSecondProfile( idController.text, messageController.text, restaurantController.text);
      if (response.status == 200) {
        print("성공");
        return true;
      } else {
        print("실패");
        return false;
      }
  }
}