import 'package:dio/dio.dart';
import 'package:khukiting/src/data/datasources/remote/apiEndPoint.dart';
import '../../../domain/Model/response/LoginResponse.dart';
import '../../../domain/Model/response/GeneralResponse.dart';

class RemoteServerDatasources {
  final Dio _dio;
  
  // RemoteServerDatasources({required Dio dio}) : _dio = dio ;
    RemoteServerDatasources({required Dio dio}) : _dio = dio {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print("REQUEST[${options.method}] => PATH: ${options.path} => DATA: ${options.data}");
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
}