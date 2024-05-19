import 'package:brainwavesocialapp/common/routing/route_names.dart';
import 'package:brainwavesocialapp/presentation/presentation.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static Future<T?> go<T>(
    context,
    RouterNames routerName, {
    Map<String, String> pathParameters = const {},
  }) {
    return GoRouter.of(context).pushNamed<T>(
      routerName.name,
      pathParameters: pathParameters,
    );
  }

  static GoRouter config = GoRouter(
    initialLocation: '/auth',
    routes: [
      GoRoute(
        path: '/auth',
        name: RouterNames.loginPage.name,
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
    ],
  );
}
