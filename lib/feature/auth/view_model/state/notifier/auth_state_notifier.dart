import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_management_test/core/cache/locale_manager.dart';
import 'package:state_management_test/feature/auth/model/user.dart';
import '../../../../../core/constants/enums/locale_keys_enum.dart';
import '../../auth_view_model.dart';

class AuthStateNotifier extends Notifier<bool>
{

  AuthViewModel authViewModel = AuthViewModel();


  Future<void> login(String username) async
  {
    bool isLogin = await authViewModel.login(username);
    state = isLogin;
  }

  Future<void> singUp(String username) async
  {
    await authViewModel.saveUser(username);
  }

  Future<void> logOut() async
  {
    await authViewModel.logOut();
    state = false;
  }

  @override
  bool build()
  {
    return LocaleManager.instance.getBoolValue(PreferencesKeys.IS_LOGGED);
  }

}



class UserNotifier extends Notifier<User>
{

  void updateUserName(String value)
  {
    state = user.copyWith(name: value);
  }

  final User user = User.initial();

  @override
  User build() {
    return User.initial();
  }

}
