import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'profile.g.dart';

@HiveType(typeId: 0)
class Profile extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String fullName;
  @HiveField(2)
  final String email;
  @HiveField(3)
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
