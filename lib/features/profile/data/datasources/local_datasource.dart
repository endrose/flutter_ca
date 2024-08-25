import 'package:hive/hive.dart';

import '../models/profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
}

class ProfileLocalDataSourceImplementation extends ProfileLocalDataSource {
  final Box box;

  ProfileLocalDataSourceImplementation({required this.box});

  @override
  Future<List<ProfileModel>> getAllUser(int page) {
    //
    return box.get("getAllUser");
  }

  @override
  Future<ProfileModel> getUser(int id) {
    //
    return box.get("getUser");
  }
}
