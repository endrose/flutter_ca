import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class GetAllUsers {
  //

  final ProfileRepository profileRepository;

  const GetAllUsers(this.profileRepository);

  Future<Either<Failure, List<Profile>>> execute(int page) async {
    return await profileRepository.getAllUser(page);
  }
}
