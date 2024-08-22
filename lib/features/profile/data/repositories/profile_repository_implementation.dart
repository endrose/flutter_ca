import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/local_datasource.dart';
import '../datasources/remote_datasource.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImplementation extends ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSourceFileSource;
  final ProfileLocalDataSource profileLocalDataSource;
  final HiveInterface hive;

  ProfileRepositoryImplementation({
    required this.profileRemoteDataSourceFileSource,
    required this.profileLocalDataSource,
    required this.hive,
  });

  @override
  Future<Either<Failure, List<Profile>>> getAllUser(int page) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    // Cek error
    try {
      // cek internet

      if (connectivityResult.contains(ConnectivityResult.none)) {
        List<ProfileModel> hasil =
            await profileLocalDataSource.getAllUser(page);
        return Right(hasil);
      } else {
        //
        List<ProfileModel> hasil =
            await profileRemoteDataSourceFileSource.getAllUser(page);

        // save to local data
        var box = hive.box("profile_box");
        box.put("getAllUser", hasil);

        return Right(hasil);
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Profile>> getUser(int id) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    try {
      if (connectivityResult.contains(ConnectivityResult.none)) {
        ProfileModel hasil = await profileLocalDataSource.getUser(id);

        return Right(hasil);
      } else {
        ProfileModel hasil =
            await profileRemoteDataSourceFileSource.getUser(id);

        // save to local data
        var box = hive.box("profile_box");
        box.put("getUser", hasil);

        return Right(hasil);
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
