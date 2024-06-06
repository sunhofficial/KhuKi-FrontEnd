import 'package:khukiting/src/config/configuartions.dart';
import 'package:khukiting/src/data/DTO/requests/FirstProfileRequest.dart';
import 'package:khukiting/src/data/DTO/requests/PostMyCookieRequest.dart';
import 'package:khukiting/src/data/DTO/requests/SecondProfileRequest.dart';
import 'package:khukiting/src/data/DTO/response/CookiesResponse.dart';
import 'package:khukiting/src/data/DTO/response/GeneralResponse.dart';
import 'package:khukiting/src/data/DTO/response/LoginResponse.dart';
import 'package:khukiting/src/domain/Model/Cookie.dart';
import '../../data/datasources/remote/RemoteServerDatasources.dart';
import 'package:khukiting/src/data/DTO/response/PickCookieResponse.dart';

class UserRepository {
  final RemoteServerDatasources _remoteServices;
  UserRepository({RemoteServerDatasources? remoteServerDatasources})
      : _remoteServices =
            remoteServerDatasources ?? getIt.get<RemoteServerDatasources>();

  Future<GeneralResponse<LoginResponse>> postLogin(
      String appleIdentityToken) async {
    return await _remoteServices.postLogin(appleIdentityToken);
  }

  Future<GeneralResponse<void>> putFirstProfile(
      String gender, int age, int distance) async {
    return await _remoteServices.putFirstProfile(
        FirstProfileRequest(gender: gender, age: age, distance: distance));
  }

  Future<GeneralResponse<void>> putSecondProfile(
      String openId, String restaruant, String selfInfo) async {
    return await _remoteServices.putSecondProfile(SecondProfileRequest(
        openId: openId, restaruant: restaruant, selfInfo: selfInfo));
  }

  Future<GeneralResponse<void>> postMyCookie(String info, int type) async {
    return await _remoteServices
        .postMyCookie(PostMyCookieRequest(info: info, type: type));
  }

  Future<GeneralResponse<GetCookiesResponse>> getAllCookies(int page) async {
    return await _remoteServices.getAllCookies(page);
  }

  Future<GeneralResponse<PartnerDetail>> pickCookie(String cookieId) async {
    return await _remoteServices.pickCookie(cookieId);
  }

  Future<List<Cookie>> getMyCookie() async {
    return await _remoteServices.getPickedCookies();
  }

  Future<bool> postLogout() async {
    final response = await _remoteServices.postLogout();
    return response.status == 200 ? true : false;
  }

  Future<bool> deleteUser() async {
    final response = await _remoteServices.deleteUser();
    return response.status == 200 ? true : false;
  }
}
