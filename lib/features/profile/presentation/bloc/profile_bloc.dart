import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_all_user.dart';
import '../../domain/usecases/get_user.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetAllUsers getAllUser;
  final GetUser getUsers;

  ProfileBloc({
    required this.getAllUser,
    required this.getUsers,
  }) : super(ProfileStateEmpty()) {
    on<ProfileEventGetAllUsers>((event, emit) async {
      // LOADING
      emit(ProfileStateLoading());

      Either<Failure, List<Profile>> hasilGetAllUsers =
          await getAllUser.execute(event.page);

      hasilGetAllUsers.fold(
        (leftHasilGetAllUser) {
          // ERROR

          emit(ProfileStateError(message: "Cannot get all users"));
        },
        (rightHasilGetAllUsers) {
          // LOADED
          emit(ProfileStateLoadedAllUsers(allUsers: rightHasilGetAllUsers));
        },
      );
    });

    on<ProfileEventGetDetailUsers>((event, emit) async {
      //
      emit(ProfileStateLoading());
      //
      Either<Failure, Profile> hasilGetUser =
          await getUsers.execute(event.userId);

      hasilGetUser.fold(
        (leftHasilGetUser) {
          emit(ProfileStateError(message: "Cannot find user ${event.userId}"));
        },
        (rightHasilGetUser) {
          emit(ProfileStateLoadedUser(detailUser: rightHasilGetUser));
        },
      );
    });
  }
}
