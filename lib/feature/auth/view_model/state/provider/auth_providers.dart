import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_management_test/feature/auth/model/user.dart';
import '../notifier/auth_state_notifier.dart';


final authProvider = NotifierProvider<AuthStateNotifier, bool>(() {
  return AuthStateNotifier();
});

final userProvider = NotifierProvider<UserNotifier, User>(() {
  return UserNotifier();
});

