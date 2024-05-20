import 'package:brainwavesocialapp/presentation/presentation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'auth_change_provider.dart';
import 'route_names.dart';

final routerConfig = Provider<GoRouter>(
  (ref) => GoRouter(
    redirect: (context, state) {
      final userState = ref.watch(routerAuthStateProvider);

      final isAuthenticated = userState.value != null && userState.value!;

      final isAuthPath = state.fullPath?.startsWith('/auth') ?? false;

      if (!isAuthenticated && !isAuthPath) {
        return '/auth';
      }

      return null;
    },
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/auth',
        name: RouterNames.authPage.name,
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: 'register',
            name: RouterNames.registerPage.name,
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: 'forgot-password',
            name: RouterNames.forgotPasswordPage.name,
            builder: (context, state) => ForgotPasswordPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/',
        name: RouterNames.feedsPage.name,
        builder: (context, state) => FeedsPage(),
        routes: [
          GoRoute(
            path: 'profile/:userId',
            name: RouterNames.userProfilePage.name,
            builder: (context, state) => UserProfilePage(
              userId: state.pathParameters['userId']!,
            ),
            routes: [
              GoRoute(
                path: 'edit',
                name: RouterNames.editProfilePage.name,
                builder: (context, state) => EditProfilePage(),
              ),
            ],
          ),
          GoRoute(
            path: 'post/:postId',
            name: RouterNames.postDetailPage.name,
            builder: (context, state) => PostDetailPage(
              postId: state.pathParameters['postId']!,
            ),
          ),
          GoRoute(
            path: 'settings',
            name: RouterNames.settingsPage.name,
            builder: (context, state) => const SettingsPage(),
          ),
          GoRoute(
            path: 'search',
            name: RouterNames.searchPage.name,
            builder: (context, state) => const SearchPage(),
          ),
          GoRoute(
            path: 'notifications',
            name: RouterNames.notificationsPage.name,
            builder: (context, state) => const NotificationsPage(),
          ),
        ],
      ),
    ],
  ),
);
