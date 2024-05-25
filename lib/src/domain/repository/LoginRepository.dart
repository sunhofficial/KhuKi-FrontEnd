import 'package:khukiting/src/config/configuartions.dart';
import 'package:khukiting/src/domain/Model/response/GeneralResponse.dart';
// import 'package:khukiting/src/domain/Model/User.dart';
import 'package:khukiting/src/domain/Model/response/LoginResponse.dart';
import '../../data/datasources/remote/RemoteServerDatasources.dart';
import 'package:injectable/injectable.dart';

class LoginRepository {
  final RemoteServerDatasources _remoteServices;
  LoginRepository({RemoteServerDatasources? remoteServerDatasources}) : _remoteServices = remoteServerDatasources ?? getIt.get<RemoteServerDatasources>();


  Future<GeneralResponse<LoginResponse>> postLogin(String appleIdentityToken) async {
    return await _remoteServices.postLogin(appleIdentityToken);
  }
}