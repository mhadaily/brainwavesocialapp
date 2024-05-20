import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/common.dart';
import 'domain/usecases/notification_usecase.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // if (kDebugMode) {
  //   await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  // }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: "Social App",
      theme: AppTheme.lightThemeData,
      darkTheme: AppTheme.darkThemeData,
      themeMode: ref.watch(themeModeProvider),
      routerConfig: ref.watch(AppRouter.config),
      builder: (context, child) {
        final notification = ref.watch(notificationUseCaseProvider);

        notification.onDeviceTokenRefresh().listen((token) {
          debugPrint('Device Token Refreshed: $token');
          ref
              .read(
                notificationUseCaseProvider,
              )
              .registerCurrentUserDeviceToken();
        });

        notification.onMessageWhenBackground().listen((message) {
          debugPrint('Message Received background: ${message.toString()}');
        });

        notification
            .onReceiveMessageWhenOpened()
            .distinct((prev, next) => prev.hashCode == next.hashCode)
            .listen(
          (message) {
            debugPrint('Message Received: ${message.toString()}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                showCloseIcon: true,
                duration: const Duration(seconds: 15),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(message.title),
                    Text(message.body),
                  ],
                ),
              ),
            );
          },
        );

        return child!;
      },
    );
  }
}
