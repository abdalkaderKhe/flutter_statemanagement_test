
import '../../../core/cache/locale_manager.dart';
import '../../../core/constants/enums/locale_keys_enum.dart';

final class AuthViewModel
{

  Future<void> saveUser(String value) async
  {
    await LocaleManager.instance.setStringValue(PreferencesKeys.USER_NAME, value);
  }

  Future<bool> login(String username) async
  {
    String localUserName = LocaleManager.instance.getStringValue(PreferencesKeys.USER_NAME);
    if (localUserName == username)
    {
      await LocaleManager.instance.setBoolValue(PreferencesKeys.IS_LOGGED, true);
      return true;
    }
    return false;
  }

  Future<void> logOut() async
  {
    await LocaleManager.instance.setBoolValue(PreferencesKeys.IS_LOGGED, false);
  }

}
