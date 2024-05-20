import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/auth_state_change_usecase.dart';

final routerAuthStateProvider = StreamProvider(
  (ref) => ref.watch(authStateUseCaseProvider).isAuthenticated(),
);
