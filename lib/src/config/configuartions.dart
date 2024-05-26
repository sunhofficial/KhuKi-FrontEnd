import 'package:get_it/get_it.dart';
import 'package:khukiting/src/data/datasources/local/AccessTokenProvider.dart';
import 'package:khukiting/src/domain/repository/UserRepository.dart';
import 'package:injectable/injectable.dart';
import 'configuartions.config.dart';
import '../data/datasources/remote/RemoteServerDatasources.dart'; 
import 'package:dio/dio.dart';
import '../data/services/LoggingIntercepter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  final Dio dio = Dio();
  final storage = FlutterSecureStorage();
  dio.interceptors.add(LoggingInterceptor());  

  getIt.registerSingleton<Dio>(dio);
  getIt.registerSingleton<FlutterSecureStorage>(storage);
  
  getIt.registerLazySingleton<UserRepository>(() => UserRepository());
  
  final accessTokenProvider = AccessTokenProvider(storage);
  getIt.registerSingleton<AccessTokenProvider>(accessTokenProvider);
  
  getIt.registerLazySingleton<RemoteServerDatasources>(() => RemoteServerDatasources(
    dio: getIt<Dio>(),
    accessTokenProvider: getIt<AccessTokenProvider>(),
  ));

  // Initialize GetIt
  getIt.init();
}
