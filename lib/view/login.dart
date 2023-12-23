import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_thing/utils/custom_widget/with_gap.dart';
import 'package:store_thing/utils/platform_widgets/buttons.dart';
import 'package:store_thing/utils/platform_widgets/platform_text_field.dart';
import 'package:store_thing/utils/services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: WithGap(
          height: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlatformTextField(
              obsureText: false,
              controller: emailController,
              enableSuggestions: true,
              autocorrect: true,
              placeholder: "Email",
            ),
            PlatformTextField(
              obsureText: true,
              controller: passwordController,
              enableSuggestions: false,
              autocorrect: false,
              placeholder: "Password",
            ),
            PlatformButton(
              onPressed: () => authServices.signInWithGoogle(),
              isFilled: true,
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
