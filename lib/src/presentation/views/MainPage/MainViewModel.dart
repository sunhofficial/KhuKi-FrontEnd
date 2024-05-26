import 'package:flutter/material.dart';
import 'package:khukiting/src/data/DTO/response/CookiesResponse.dart';
import 'package:khukiting/src/domain/repository/UserRepository.dart';

class MainViewModel with ChangeNotifier {
  final UserRepository _repository;
  List<CookiesResponse> _cookies = [];
  bool _isLoading = false;
  int _currentPage = 1;

  MainViewModel(this._repository);

  List<CookiesResponse> get cookies => _cookies;
  bool get isLoading => _isLoading;

  Future<void> fetchCookies({bool isInitialLoad = true}) async {
    if (_isLoading) return; 
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _repository.getAllCookies( _currentPage);
      if (response.status == 200) {
        if (isInitialLoad) {
          _cookies = response.data!.cookies;
        } else {
          _cookies.addAll(response.data!.cookies);
        }
        _currentPage++;
      } else if (response.status == 401) {
        print("no cookiess yet. please wait");
      } 
    } catch(err) {
      print(err);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
