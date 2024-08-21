import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final int id;
  final String fullName;
  final String email;
  final String profileImageUrl;

  const Profile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.profileImageUrl,
  });

  @override
  List<Object> get props => [
        id,
        fullName,
        email,
        profileImageUrl,
      ];
}
