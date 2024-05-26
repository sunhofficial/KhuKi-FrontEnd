import 'package:khukiting/src/config/configuartions.dart';
import 'package:khukiting/src/data/DTO/requests/FirstProfileRequest.dart';
import 'package:khukiting/src/data/DTO/response/GeneralResponse.dart';
// import 'package:khukiting/src/domain/Model/User.dart';
import 'package:khukiting/src/data/DTO/response/LoginResponse.dart';
import '../../data/datasources/remote/RemoteServerDatasources.dart';
import 'package:injectable/injectable.dart';

class UserRepository {
  final RemoteServerDatasources _remoteServices;
  UserRepository({RemoteServerDatasources? remoteServerDatasources}) : _remoteServices = remoteServerDatasources ?? getIt.get<RemoteServerDatasources>();


  Future<GeneralResponse<LoginResponse>> postLogin(String appleIdentityToken) async {
    return await _remoteServices.postLogin(appleIdentityToken);
  }

  Future<GeneralResponse<void>> putFirstProfile(String gender, int age, int distance) async {
    return await _remoteServices.putFirstProfile(FirstProfileRequest(gender: gender, age: age, distance: distance));
  }
}