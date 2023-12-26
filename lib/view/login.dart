import 'package:flutter/material.dart';
import 'package:store_thing/utils/custom_widget/alert_dialog.dart';
import 'package:store_thing/utils/custom_widget/with_gap.dart';
import 'package:store_thing/utils/extensions/on_context.dart';
import 'package:store_thing/utils/platform_widgets/buttons.dart';
import 'package:store_thing/utils/platform_widgets/platform_scaffold.dart';
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
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      title: "Login",
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: WithGap(
            height: 10,
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
                controller: _emailController,
                enableSuggestions: true,
                autocorrect: true,
                placeholder: "Email",
              ),
              PlatformTextField(
                obsureText: true,
                controller: _passwordController,
                enableSuggestions: false,
                autocorrect: false,
                placeholder: "Password",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: context.textTheme.bodySmall!.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                  PlatformButton(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign_up');
                    },
                    child: Text(
                      "Create Account",
                      style: context.textTheme.bodySmall!.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PlatformButton(
                    onPressed: () => authServices.signInWithGoogle(),
                    child: const Text("Sign in with Google"),
                  ),
                ],
              ),
              const Divider(
                indent: 40,
                endIndent: 40,
              ),
              PlatformButton(
                onPressed: () async {
                  String email = _emailController.text.trim();
                  String password = _passwordController.text.trim();
                  bool result = await authServices.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                    context: context,
                  );
                  if (result) {
                    debugPrint("Login successful $result");
                  } else {
                    // ignore: use_build_context_synchronously
                    showAlertDialog(
                      context,
                      title: "Error",
                      content: "Wrong password or email provided.",
                    );
                  }
                },
                isFilled: true,
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo.png',
      height: 50,
      width: 50,
      cacheWidth: 50,
      cacheHeight: 50,
    );
  }
}
