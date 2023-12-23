import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store_thing/utils/custom_widget/with_gap.dart';
import 'package:store_thing/utils/extensions/on_context.dart';
import 'package:store_thing/utils/platform_widgets/platform_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return PlatformScaffold(
      title: "Stores",
      trailing: GestureDetector(
        onTap: () {
          print("Pressed the profile Button");
        },
        child: ClipOval(
          child: Image.network(
            user!.photoURL!,
            fit: BoxFit.cover,
            height: 35,
            width: 35,
            cacheWidth: 35,
            cacheHeight: 35,
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
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9DACF),
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
                              style: context.textTheme.headlineSmall,
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
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 8,
                crossAxisCount: 4,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 59,
                  width: 59,
                  child: Center(
                    child: Text("${index + 1}"),
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
