import 'package:attendance/core/utils/local_data_store.dart';
import 'package:attendance/features/home/data/dataSource/home_remote_data_source_impl.dart';
import 'package:attendance/features/home/data/respositories/home_repository_impl.dart';
import 'package:attendance/features/home/domain/usecase/home_usecase.dart';
import 'package:attendance/features/home/presentation/provider/home_provider.dart';
import 'package:attendance/features/login/data/dataSource/login_remote_data_source_impl.dart';
import 'package:attendance/features/login/data/repositories/login_repositories_impl.dart';
import 'package:attendance/features/login/domain/usecase/login_usecase.dart';
import 'package:attendance/features/login/presentation/provider/login_provider.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setLocator() {
  //Login
  locator.registerLazySingleton<LoginRemoteDataSourceImpl>(
    () => LoginRemoteDataSourceImpl(),
  );

  locator.registerLazySingleton<LoginRepositoriesImpl>(
    () => LoginRepositoriesImpl(
      loginRemoteDataSourceImpl: locator<LoginRemoteDataSourceImpl>(),
    ),
  );

  locator.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(loginRepository: locator<LoginRepositoriesImpl>()),
  );

  locator.registerFactory(
    () => LoginProvider(loginUsecasel: locator<LoginUsecase>()),
  );

  //Home
  locator.registerLazySingleton<HomeRemoteDataSourceImpl>(
    () => HomeRemoteDataSourceImpl(),
  );
  locator.registerLazySingleton<HomeRepositoryImpl>(
    () => HomeRepositoryImpl(
      homeRemoteDataSourceImpl: locator<HomeRemoteDataSourceImpl>(),
    ),
  );
  locator.registerLazySingleton<HomeUsecase>(
    () => HomeUsecase(homeRepository: locator<HomeRepositoryImpl>()),
  );
  locator.registerFactory<HomeProvider>(
    () => HomeProvider(
      homeUsecase: locator<HomeUsecase>(),
      userId: HiveService.instance.getUserId(),
    ),
  );
}
