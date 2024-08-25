import 'features/profile/data/datasources/local_datasource.dart';
import 'features/profile/data/datasources/remote_datasource.dart';
import 'features/profile/data/models/profile_model.dart';
import 'features/profile/data/repositories/profile_repository_implementation.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/domain/usecases/get_all_user.dart';
import 'features/profile/domain/usecases/get_user.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

var myInjection = GetIt.instance; // penampungan dependency injection

// INJECTION ALL DEPEDENCIES
Future<void> init() async {
  // GENERAL DEPEDENCIES

  // HIVE
  Hive.registerAdapter(ProfileModelAdapter());
  var box = await Hive.openBox("profile_box");
  myInjection.registerLazySingleton(
    () => box,
  );

  // HTTP
  myInjection.registerLazySingleton(
    () => http.Client(),
  );

  //
  // FEATURE - PROFILE
  // BLOC
  myInjection.registerFactory(
    () => ProfileBloc(
      getAllUser: myInjection(),
      getUsers: myInjection(),
    ),
  );

  // USECASE
  myInjection.registerLazySingleton(
    () => GetAllUsers(myInjection()),
  );

  myInjection.registerLazySingleton(
    () => GetUser(myInjection()),
  );
  // REPOSITORY
  myInjection.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImplementation(
        profileRemoteDataSourceFileSource: myInjection(),
        profileLocalDataSource: myInjection(),
        box: myInjection()),
  );

  // DATA SOURCE
  myInjection.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImplementation(box: myInjection()),
  );

  myInjection.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImplementation(client: myInjection()),
  );
}
