import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_management_test/feature/auth/view/widget/main_button.dart';
import '../../../core/router/router.dart';
import '../view_model/state/provider/auth_providers.dart';

final class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                  'Login',
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
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child)
                        {
                          final userStateNotifier = ref.read(userProvider.notifier);
                          return Expanded(
                            flex: 3,
                            child: TextFormField(
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
                            ),
                          );
                        },
                      ),
                      // ref.read(routerNotifierProvider).isLoggedIn = true;
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child)
                        {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox.shrink(),
                              InkWell(
                                onTap: () {
                                  //ref.read(routerNotifierProvider).pushSingUp = true;
                                  context.pushReplacementNamed(AppRoute.signup.name);
                                },
                                child: Text(
                                  'If you do not have an account-->',
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

                      const Expanded(flex: 2, child: SizedBox.shrink(),),

                      Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child)
                        {
                          final userState = ref.watch(userProvider);

                          return Expanded(
                            flex: 2,
                            child: MainButton(
                              title: 'LOGIN',
                              onTap: () async
                              {
                                await ref.read(authProvider.notifier).login(userState.name);

                                if (context.mounted && !ref.read(authProvider))
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Username does not match'),));
                                }
                                else if(context.mounted && ref.read(authProvider))
                                {
                                    context.pushReplacementNamed(AppRoute.home.name);
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox.shrink(),),
              ],
            ),
          ),
          const Expanded(flex: 12, child: SizedBox.shrink()),
        ],
      ),
    );
  }
}
