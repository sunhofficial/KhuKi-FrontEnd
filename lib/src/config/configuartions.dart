import 'package:get_it/get_it.dart';
import 'package:khukiting/src/domain/repository/LoginRepository.dart';
import 'package:injectable/injectable.dart';
import 'configuartions.config.dart';
import '../data/datasources/remote/RemoteServerDatasources.dart'; 
import 'package:dio/dio.dart';
import '../data/services/LoggingIntercepter.dart';
final getIt = GetIt.instance;
final Dio dio = Dio();

@injectableInit
void configureDependencies() {
  dio.interceptors.add(LoggingInterceptor());  
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepository());
  getIt.registerLazySingleton<RemoteServerDatasources>(() => RemoteServerDatasources(dio: dio)); // 만약 Dio의 인스턴스가 필요하다면 적절한 인스턴스를 전달해주세요.
// 다른 의존성도 필요한 경우 여기에 추가해주세요.
  
  // GetIt 초기화
  getIt.init();
}