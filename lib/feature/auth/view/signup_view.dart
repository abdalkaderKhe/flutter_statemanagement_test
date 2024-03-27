
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_management_test/core/router/router.dart';
import 'package:state_management_test/feature/auth/view/widget/main_button.dart';
import '../view_model/state/provider/auth_providers.dart';

final class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          const Expanded(flex: 1, child: SizedBox.shrink()),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                Text(
                  'Sing up',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox.shrink(),
              ],
            ),
          ),
          const Expanded(flex: 8, child: SizedBox.shrink()),
          Expanded(
            flex: 12,
            child: Row(
              children: [
                const Expanded(
                  child: SizedBox.shrink(),
                ),
                Expanded(
                  flex: 15,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child)
                          {
                            final userStateNotifier = ref.read(userProvider.notifier);
                            return TextField(
                              onChanged: userStateNotifier.updateUserName,
                              decoration: InputDecoration(
                                hintText: 'Enter your Name!',
                                prefixIcon: Icon(
                                  Icons.supervisor_account_sharp,
                                  color: Colors.grey.shade700,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      width: 2.0, color: Colors.grey.shade300),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref,
                            Widget? child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox.shrink(),
                              InkWell(
                                onTap: ()
                                {
                                  context.pushReplacementNamed(AppRoute.login.name);
                                },
                                child: Text(
                                  'If you have an account-->',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                      ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const Expanded(
                        flex: 2,
                        child: SizedBox.shrink(),
                      ),
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref,
                            Widget? child) {
                          final userState = ref.watch(userProvider);
                          final authState = ref.watch(authProvider.notifier);
                          return Expanded(
                            flex: 2,
                            child: MainButton(
                              title: 'SIGN UP',
                              onTap: () async
                              {
                                await authState.singUp(userState.name);
                                if (context.mounted)
                                {
                                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User has been registered successfully'),));
                                   context.pushReplacementNamed(AppRoute.login.name);
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox.shrink(),
                ),
              ],
            ),
          ),
          const Expanded(flex: 12, child: SizedBox.shrink()),
        ],
      ),
    );
  }
}
