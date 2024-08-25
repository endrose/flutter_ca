import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ca_1/injection.dart';
import '../../domain/entities/profile.dart';
import '../bloc/profile_bloc.dart';

class DetailUsersPage extends StatelessWidget {
  final int userId;
  const DetailUsersPage({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Users'),
      ),
      body: BlocBuilder(
          builder: (context, state) {
            if (state is ProfileStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileStateError) {
              return Center(
                child: Text(
                  state.message,
                ),
              );
            } else if (state is ProfileStateLoadedUser) {
              Profile profile = state.detailUser;
              return Card(
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(profile.profileImageUrl),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("ID : ${profile.id}"),
                      Text("Fullname : ${profile.fullName}"),
                      Text("Email : ${profile.email}"),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text('Empty detail users'),
              );
            }
          },
          bloc: myInjection<ProfileBloc>()
            ..add(ProfileEventGetDetailUsers(userId: userId))),
    );
  }
}
