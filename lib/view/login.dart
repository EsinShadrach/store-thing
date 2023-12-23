import 'package:flutter/material.dart';
import 'package:store_thing/utils/custom_widget/with_gap.dart';
import 'package:store_thing/utils/extensions/on_context.dart';
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

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _animationController.dispose();
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
            FadeTransition(
              opacity: _animationController,
              child: WithGap(
                height: 10,
                children: [
                  const Logo(),
                  Text(
                    "Login to your account",
                    style: context.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
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

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "S",
        style: context.textTheme.displayLarge!.copyWith(
          color: context.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
