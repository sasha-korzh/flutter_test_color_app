import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:test_color_project/features/color_feature/data/datasources/local_color_data_source.dart';
import 'package:test_color_project/features/color_feature/data/datasources/remote_color_data_source.dart';
import 'package:test_color_project/features/color_feature/data/mapper/color_mapper.dart';
import 'package:test_color_project/features/color_feature/data/repositories/color_entity_repository_impl.dart';
import 'package:test_color_project/features/color_feature/domain/repositories/color_entity_repository.dart';
import 'package:test_color_project/features/color_feature/presentation/cubit/color_feature_cubit.dart';
import 'package:http/http.dart' as http;
import 'core/network/network_info.dart';
import 'core/platform/web/network_info_impl.dart';
import 'features/color_feature/domain/usecases/get_random_color_entity.dart';

final sl = GetIt.instance;

void init() {
  // External
  sl.registerLazySingleton<http.Client>(() => http.Client());
  
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  // Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl.get<Connectivity>()));
  sl.registerLazySingleton<ColorMapper>(() => ColorMapper());
  // DataSources
  sl.registerLazySingleton<RemoteColorDataSource>(
    () => RemoteColorDataSourceImpl(
      client: sl.get<http.Client>(),
      colorMapper: sl.get<ColorMapper>(),
    ),
  );

  sl.registerLazySingleton<LocalColorDataSource>(
    () => LocalColorDataSourceImpl(),
  );
  // Repository
  sl.registerLazySingleton<ColorEntityRepository>(
      () => ColorEntityRepositoryImpl(
            remoteDataSource: sl.get<RemoteColorDataSource>(),
            localDataSource: sl.get<LocalColorDataSource>(),
            networkInfo: sl.get<NetworkInfo>(),
          ));
  // UseCase
  sl.registerLazySingleton<GetRandomColorEntity>(
      () => GetRandomColorEntity(sl.get<ColorEntityRepository>()));
  // BLoC
  sl.registerFactory(
    () => ColorFeatureCubit(
      getRandomColorEntity: sl.get<GetRandomColorEntity>(),
    ),
  );
}
