import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:store_thing/utils/cupertino_or_material_app.dart';
import 'package:store_thing/utils/platform_widgets/buttons.dart';
import 'package:store_thing/utils/platform_widgets/platform_scaffold.dart';
import 'package:store_thing/firebase_options.dart';
import 'package:store_thing/utils/platform_widgets/platform_text_field.dart';
import 'package:store_thing/utils/services/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

const Color turquoise = Color(0xFF40E0D0);

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
      title: "Stores",
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
            return LoginScreen(authServices: authServices);
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.authServices,
  });

  final AuthServices authServices;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController email_controller;
  late final TextEditingController password_controller;

  @override
  void initState() {
    super.initState();
    email_controller = TextEditingController();
    password_controller = TextEditingController();
  }

  @override
  void dispose() {
    email_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlatformTextField(
              obsureText: false,
              controller: email_controller,
              enableSuggestions: true,
              autocorrect: true,
              placeholder: "Email",
            ),
            const SizedBox(height: 10),
            PlatformTextField(
              obsureText: true,
              controller: email_controller,
              enableSuggestions: false,
              autocorrect: false,
              placeholder: "Password",
            ),
            const SizedBox(height: 10),
            PlatformButton(
              onPressed: () => widget.authServices.signInWithGoogle(),
              isFilled: true,
              child: const Text("Sign In With google"),
            ),
          ],
        ),
      ),
    );
  }
}
