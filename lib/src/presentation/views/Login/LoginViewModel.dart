import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:khukiting/src/domain/repository/LoginRepository.dart';
import 'package:khukiting/src/domain/Model/response/LoginResponse.dart';
import 'package:khukiting/src/domain/Model/response/GeneralResponse.dart';

class LoginViewModel {
  final LoginRepository _loginRepository;
  final FlutterSecureStorage _secureStorage;

  LoginViewModel(this._loginRepository, this._secureStorage);

  Future<String> signInwithApple(String identityToken) async {
    try {
      GeneralResponse<LoginResponse> response = await _loginRepository.postLogin(identityToken);
      if (response.status == 200) {
        await _secureStorage.write(key: 'accessToken', value: response.data!.accessToken);
        return response.message;
    }   else {
      throw Exception(response.message);
    } 
  } catch(error) {
    throw Exception(error);
  }
  }

}