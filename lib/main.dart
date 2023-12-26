import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:store_thing/firebase_options.dart';
import 'package:store_thing/utils/platform_widgets/cupertino_or_material_app.dart';
import 'package:store_thing/view/home.dart';
import 'package:store_thing/view/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlatformDependentWidget(
      home: AuthObserver(),
      title: 'Store Thing',
    );
  }
}

class AuthObserver extends StatelessWidget {
  const AuthObserver({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while checking the authentication state
          return const CircularProgressIndicator.adaptive();
        } else if (snapshot.hasData && snapshot.data != null) {
          // User is authenticated, navigate to HomeScreen
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
