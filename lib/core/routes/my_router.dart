import '../../features/profile/presentation/pages/all_users.dart';
import '../../features/profile/presentation/pages/detail_users_page.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  get router => GoRouter(initialLocation: "/", routes: [
        GoRoute(
            path: '/',
            name: 'all_users',
            pageBuilder: (context, state) => const NoTransitionPage(
                  child: AllUserPage(),
                ),
            // SUB ROUTER
            routes: [
              GoRoute(
                path: 'detail-user',
                name: 'detail_user',
                pageBuilder: (context, state) => NoTransitionPage(
                  child: DetailUsersPage(
                    userId: state.extra as int,
                  ),
                ),
              )
            ])
      ]);
}
