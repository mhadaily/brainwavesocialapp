import 'package:brainwavesocialapp/common/routing/route_names.dart';
import 'package:brainwavesocialapp/common/routing/router_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  static pop(context) => GoRouter.of(context).pop();

  static Provider<GoRouter> config = routerConfig;
}
