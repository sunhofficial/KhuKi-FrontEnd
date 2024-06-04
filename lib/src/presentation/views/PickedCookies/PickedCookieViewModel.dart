import 'package:flutter/cupertino.dart';
import 'package:khukiting/src/domain/Model/Cookie.dart';
import 'package:khukiting/src/domain/repository/UserRepository.dart';

class PickedCookieViewModel extends ChangeNotifier {
  final UserRepository _repository;
  bool isLoading = false;
  List<Cookie> cookies = [];

  PickedCookieViewModel(this._repository);

  Future<void> fetchPickedCookies() async {
    isLoading = true;
    notifyListeners();

    try {
      cookies = await _repository.getMyCookie();
    } catch (e) {
      // Handle error
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }
}
