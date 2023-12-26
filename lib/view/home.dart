import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store_thing/utils/custom_widget/alert_dialog.dart';
import 'package:store_thing/utils/custom_widget/with_gap.dart';
import 'package:store_thing/utils/extensions/on_context.dart';
import 'package:store_thing/utils/platform_widgets/buttons.dart';
import 'package:store_thing/utils/platform_widgets/platform_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool hasProfilePic = user!.photoURL != null;

    return PlatformScaffold(
      title: "Stores",
      trailing: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/profile");
        },
        child: ClipOval(
          child: hasProfilePic
              ? CachedNetworkImage(
                  imageUrl: user.photoURL!,
                  fit: BoxFit.cover,
                  height: 35,
                  width: 35,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator.adaptive(
                    value: downloadProgress.progress,
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(2),
                  color: context.colorScheme.primaryContainer,
                  child: Icon(
                    Icons.person,
                    size: 35,
                    color: context.colorScheme.onPrimaryContainer,
                  ),
                ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: WithGap(
                height: 10,
                children: [
                  const VerifyEmailBanner(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF99867f)
                          : const Color(0xFFF9DACF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: WithGap(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/logo.png",
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Store Thing",
                              style: context.textTheme.headlineSmall!.copyWith(
                                color: context.colorScheme.onBackground,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Stores",
                          style: context.textTheme.labelLarge!.copyWith(
                            color: context.colorScheme.onPrimaryContainer,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // More Stores
                          },
                          icon: const Icon(Icons.chevron_right),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.all(10),
            ),
            SliverGrid.builder(
              itemCount: 8,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 8,
                crossAxisCount: 4,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                bool isLast = index == 7;
                return Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer
                        .withOpacity(isLast ? 0.2 : 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 59,
                  width: 59,
                  child: Center(
                    child: isLast
                        ? PlatformButton(
                            onPressed: () {
                              // More Stores
                            },
                            child: const Icon(Icons.chevron_right),
                          )
                        : Text("${index + 1}"),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class VerifyEmailBanner extends StatefulWidget {
  const VerifyEmailBanner({
    super.key,
  });

  @override
  State<VerifyEmailBanner> createState() => _VerifyEmailBannerState();
}

class _VerifyEmailBannerState extends State<VerifyEmailBanner> {
  static User? user = FirebaseAuth.instance.currentUser;
  static bool emailVerified = user!.emailVerified;
  bool _ignored = false;

  void _handleIgnored() {
    setState(() {
      _ignored = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (emailVerified) {
      return const SizedBox();
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: _ignored
          ? const SizedBox()
          : Container(
              key: UniqueKey(),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    "looks like your email is unverified, would you like send verification email? $emailVerified",
                    style: context.textTheme.labelMedium!.copyWith(
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Row(
                    children: [
                      PlatformButton(
                        onPressed: _handleIgnored,
                        child: Text(
                          "Ignore",
                          style: context.textTheme.labelSmall,
                        ),
                      ),
                      PlatformButton(
                        child: Text(
                          "Yes",
                          style: context.textTheme.labelMedium!.copyWith(
                            color: context.colorScheme.primary,
                          ),
                        ),
                        onPressed: () {
                          showAlertDialog(
                            context,
                            title: "Send verification Email",
                            actionText: "Send",
                            content:
                                "Send verification email to ${user!.email}?",
                            onPressed: () async {
                              if (!user!.emailVerified) {
                                try {
                                  await user!.sendEmailVerification();
                                } catch (e) {
                                  //
                                }
                                debugPrint("okay THIS IS WORKING");
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
