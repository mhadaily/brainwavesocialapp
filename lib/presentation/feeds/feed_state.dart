import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usercases/user_usecase.dart';

final signOutStateProvider = Provider<Future<void>>(
  (ref) {
    return ref.watch(userUseCaseProvider).signOut();
  },
);
