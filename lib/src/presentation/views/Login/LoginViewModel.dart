import 'package:khukiting/src/data/DTO/response/GeneralResponse.dart';
import 'package:khukiting/src/data/DTO/response/LoginResponse.dart';
import 'package:khukiting/src/data/datasources/local/AccessTokenProvider.dart';
import 'package:khukiting/src/domain/repository/UserRepository.dart';
class LoginViewModel {
  final UserRepository _loginRepository;
  final AccessTokenProvider _accessTokenProvider;
  LoginViewModel(this._loginRepository, this._accessTokenProvider);
  Future<String> signInwithApple(String identityToken) async {
    try {
      GeneralResponse<LoginResponse> response = await _loginRepository.postLogin(identityToken);
      if (response.status == 200) {
       await _accessTokenProvider.setAccessToken(response.data!.accessToken);
        return response.message;
    }   else {
      throw Exception(response.message);
    } 
  } catch(error) {
    throw Exception(error);
  }
  }

}