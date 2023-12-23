import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:store_thing/firebase_options.dart';
import 'package:store_thing/utils/platform_widgets/cupertino_or_material_app.dart';
import 'package:store_thing/utils/platform_widgets/platform_scaffold.dart';
import 'package:store_thing/utils/services/auth_services.dart';
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
      home: MyHomePage(title: 'Stores'),
      title: 'Store Thing',
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  static AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("apple ${snapshot.connectionState}"),
            );
          }
          User? user = snapshot.data;
          if (user == null) {
            return const LoginScreen();
          }
          return Column(
            children: [
              TextButton(
                onPressed: authServices.signOut(),
                child: const Text("Sign Out"),
              ),
              const Text("Logged In"),
            ],
          );
        },
      ),
    );
  }
}
