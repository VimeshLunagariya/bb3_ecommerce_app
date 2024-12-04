/// we are using "shared_preference" for storing data locally.
/// we also have to specify the key with the preference object.
/// this is the class which will manage all the key.
library;
// ignore_for_file: lines_longer_than_80_chars, public_member_api_docs

class LocalCacheKey {
  static const String applicationLoginState = 'bb3_app_app_is_login';
  static const String applicationThemeMode = 'bb3_app_app_theme_mode';
  static const String applicationUserJwtToken = 'bb3_app_user_jwt_token';
}
