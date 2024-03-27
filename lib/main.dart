import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_management_test/core/cache/locale_manager.dart';
import 'core/router/router.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleManager.prefrencesInit();
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget
{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    {
      final router = ref.read(routerProvider);
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'State Management Test',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router,
      );
    }
  }
}
