part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {}

class ProfileStateEmpty extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileStateLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileStateError extends ProfileState {
  final String message;

  ProfileStateError({required this.message});

  @override
  List<Object?> get props => [
        message,
      ];
}

class ProfileStateLoadedAllUsers extends ProfileState {
  final List<Profile> allUsers;

  ProfileStateLoadedAllUsers({required this.allUsers});
  @override
  List<Object?> get props => [
        allUsers,
      ];
}

class ProfileStateLoadedUser extends ProfileState {
  final Profile detailUser;

  ProfileStateLoadedUser({
    required this.detailUser,
  });

  @override
  List<Object?> get props => [
        detailUser,
      ];
}
