import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:khukiting/src/data/DTO/requests/FirstProfileRequest.dart';
import 'package:khukiting/src/data/DTO/requests/PostMyCookieRequest.dart';
import 'package:khukiting/src/data/DTO/response/CookiesResponse.dart';
import 'package:khukiting/src/data/DTO/response/GeneralResponse.dart';
import 'package:khukiting/src/data/DTO/response/LoginResponse.dart';
import 'package:khukiting/src/data/DTO/response/PickCookieResponse.dart';
import 'package:khukiting/src/data/DTO/response/PickedCookieResponse.dart';
import 'package:khukiting/src/data/datasources/local/AccessTokenProvider.dart';
import 'package:khukiting/src/data/datasources/remote/apiEndPoint.dart';
import 'package:khukiting/src/domain/Model/Cookie.dart';
class RemoteServerDatasources {
  final Dio _dio;
 final AccessTokenProvider _accessTokenProvider;
    RemoteServerDatasources({required Dio dio, required AccessTokenProvider accessTokenProvider}) : _dio = dio, _accessTokenProvider = accessTokenProvider {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
     final accessToken = await _accessTokenProvider.accessToken;
        if (accessToken != null && options.path != apiEndPoint.auth) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
       
        return handler.next(options); // continue
      },
      onResponse: (response, handler) {
        print("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
        return handler.next(response); // continue
      },
      onError: (DioError e, handler) {
        print("ERROR[${e.response?.statusCode}] => MESSAGE: ${e.message}");
        return handler.next(e); // continue
      },
    ));
  }
  Future<GeneralResponse<LoginResponse>> postLogin(String appleIdentityToken) async {
    try {
      final response = await _dio.post(apiEndPoint.baseUrl + apiEndPoint.auth, data: {
        "appleIdentityToken": appleIdentityToken
      });
      
      if (response.statusCode == 200) {
        print(response.data);
        return GeneralResponse<LoginResponse>.fromJson(response.data, (json) => LoginResponse.fromJson((json as Map<String, dynamic>?) ?? {}),);
      } else { // 200 안뜨면 에러 
        throw Exception("Failed to authorize with SIWA ${response.statusCode}");
      }
    } catch (e) {
      print("죄송합니다, 오류가 발생했습니다: $e");
      throw e;
    }
  }
  Future<GeneralResponse<void>> putFirstProfile(FirstProfileRequest profile) async {
    try {
      final response = await _dio.put(apiEndPoint.baseUrl + apiEndPoint.user + "/profile/first", data: profile.toJson());
      if ( response.statusCode == 200 ){
        return GeneralResponse<void>.fromJson(response.data, (json) => null);
      } else {
        throw Exception("Failed to put first profile ${response.statusCode}");  
      }
    } catch(e) {
      print("죄송합니다, 오류가 발생했습니다: $e");
      throw e;

    }

  }

  Future<GeneralResponse<void>> putSecondProfile(SecondProfileRequest profile) async {
    try {
      final response = await _dio.put(apiEndPoint.baseUrl + apiEndPoint.user + "/profile/second", data: profile.toJson());
      if ( response.statusCode == 200 ){
        return GeneralResponse<void>.fromJson(response.data, (json) => null);
      } else {
        throw Exception("Failed to put second profile ${response.statusCode}");  
      }
    } catch(e) {
      print("죄송합니다, 오류가 발생했습니다: $e");
      throw e;

    }
  }

  Future<GeneralResponse<void>> postMyCookie(PostMyCookieRequest cookie) async {
       try {
      final response = await _dio.post(apiEndPoint.baseUrl + apiEndPoint.user + "/myCookie", data: cookie.toJson());
      if ( response.statusCode == 200 ){
        return GeneralResponse<void>.fromJson(response.data, (json) => null);
      } else {
        throw Exception("Failed to put second profile ${response.statusCode}");  
      }
    } catch(e) {
      print("죄송합니다, 오류가 발생했습니다: $e");
      throw e;

    }
  }

  Future<GeneralResponse<GetCookiesResponse>> getAllCookies(int page) async {
    try {
      final response = await _dio.get(apiEndPoint.baseUrl + apiEndPoint.cookie + "?page=$page");
      if ( response.statusCode == 200 ){
        return GeneralResponse<GetCookiesResponse>.fromJson(response.data, (json) => GetCookiesResponse.fromJson((json as Map<String, dynamic>?) ?? {}));
      } else {
        throw Exception("Failed to get all cookies ${response.statusCode}");  
      }
    } catch(e) {
      print("죄송합니다, 오류가 발생했습니다: $e");
      throw e;

    }
  }
  Future<List<Cookie>> getPickedCookies() async {
    try {
      final response = await _dio.get(apiEndPoint.baseUrl + apiEndPoint.user + "/cookie/picked");
      if ( response.statusCode == 200 ){
        List<dynamic> responseData = response.data['data'];
         List<Cookie> cookies = responseData.map((json) => PickedCookieDetail.fromJson(json).toCookie()).toList();
        //  GeneralResponse<PickedCookieResponse> generalResponse = GeneralResponse<PickedCookieResponse>.fromJson(response.data, (json) => PickedCookieResponse.fromJson((json as Map<String, dynamic>?) ?? {}));
        //   List<Cookie> cookies = generalResponse.data!.cookies.map((detail) => detail.toCookie()).toList();
          return cookies;

      } else {
        throw Exception("Failed to get picked cookies ${response.statusCode}");  
      }
    } catch(e) {
      print("선호야, 오류발생했다 고쳐라: $e");
      throw e;
    }

  }
  Future<GeneralResponse<PickCookieResponse>> pickCookie(String cookieId) async {
    try {
      final response = await _dio.post(apiEndPoint.baseUrl + apiEndPoint.cookie + "/pick", data: {
        "id": cookieId
      });
      if ( response.statusCode == 200 ){
        return GeneralResponse<PickCookieResponse>.fromJson(response.data, (json) => PickCookieResponse.fromJson((json as Map<String, dynamic>?) ?? {}));
      } else {
        throw Exception("Failed to pick cookie ${response.statusCode}");  
      }
    } catch(e) {
      print("죄송합니다, 오류가 발생했습니다: $e");
      throw e;

    }
  }
  Future<GeneralResponse<void>> postLogout() async {
    try {
      final response = await _dio.post(apiEndPoint.user + "/logout");
      if ( response.statusCode == 200 ){
        return GeneralResponse<void>.fromJson(response.data, (json) => null);
      } else {
        throw Exception("Failed to logout ${response.statusCode}");  
      }
    } catch(e) {
      print("죄송합니다, 오류가 발생했습니다: $e");
      throw e;

    }
  }
  Future<GeneralResponse<void>> deleteUser() async {
    try {
      final response = await _dio.delete(apiEndPoint.user + "/delete");
      if (response.statusCode == 200) {
        return GeneralResponse<void>.fromJson(response.data, (json) => null);
      } else {
        throw Exception("Failed to delete user ${response.statusCode}");
      }
    } catch (e) {
      print("죄송합니다, 오류가 발생했습니다: $e");
      throw e;
    }
  }
}