import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store_thing/utils/extensions/on_context.dart';
import 'package:store_thing/utils/extensions/on_string.dart';
import 'package:store_thing/utils/platform_widgets/buttons.dart';
import 'package:store_thing/utils/platform_widgets/platform_scaffold.dart';
import 'package:store_thing/utils/services/auth_services.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    String displayName({required bool forNavBar}) {
      if (user!.displayName == null) {
        return forNavBar ? "Profile" : "No name";
      }
      return user.displayName!.titleCase;
    }

    return PlatformScaffold(
      title: displayName(forNavBar: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: ClipOval(
                  child: user!.photoURL != null
                      ? CachedNetworkImage(
                          imageUrl: user.photoURL!,
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            size: 100,
                          ),
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        )
                      : Container(
                          padding: const EdgeInsets.all(2),
                          color: context.colorScheme.primaryContainer,
                          child: Icon(
                            Icons.person,
                            size: 100,
                            color: context.colorScheme.onPrimaryContainer,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                displayName(forNavBar: false),
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "${user.email}",
                style: context.textTheme.titleMedium!.copyWith(
                  color: context.colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: PlatformButton(
                      isFilled: true,
                      child: const Text("Sign Out"),
                      onPressed: () {
                        AuthServices().signOut();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
