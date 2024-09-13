import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_tracker/models/app_user.dart';
import 'package:inventory_tracker/providers/auth_provider.dart';
import 'package:inventory_tracker/screens/profile/profile.dart';
import 'package:inventory_tracker/screens/welcome/welcome.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vemco IT Asset Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: Consumer(builder: (context, ref, child) {
        final AsyncValue<AppUser?> user = ref.watch(authProvider);

        return user.when(
          data: (value) {
            if (value == null) {
              return const WelcomeScreen();
            } else {
              return ProfileScreen(user: value);
            }
          },
          error: (error, _) => const Text('Error loading auth status...'),
          loading: () => const Text('Loading...'),
        );
      }),
    );
  }
}