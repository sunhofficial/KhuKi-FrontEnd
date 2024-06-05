import 'package:flutter/material.dart';
import 'package:khukiting/src/data/DTO/response/CookiesResponse.dart';
import 'package:khukiting/src/data/DTO/response/PickCookieResponse.dart';
import 'package:khukiting/src/domain/repository/UserRepository.dart';
class MainViewModel with ChangeNotifier {
  final UserRepository _repository;
  List<CookiesResponse> _cookies = [];
  bool _isLoading = false;
  int _currentPage = 1;
int _lastLoadedPage = 0; 
  MainViewModel(this._repository);

  List<CookiesResponse> get cookies => _cookies;
  bool get isLoading => _isLoading;

  Future<void> fetchCookies({bool isInitialLoad = true}) async {
    if (_isLoading) return; 
      if (_currentPage == _lastLoadedPage) return;
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
        if (response.data!.metadata.per == response.data!.metadata.total) {
          _currentPage += 1;
        }
        _lastLoadedPage = _currentPage; 
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
  Future<PartnerDetail> selectCookie(String cookieId) async {
    try {
      var res = await _repository.pickCookie(cookieId);
      if (res.status == 200) {
        return PartnerDetail(openID: res.data!.partnerDetail.openID , selfInfo: res.data!.partnerDetail.selfInfo);
 
      } else {
        throw Exception("Failed to pick cookie");
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
