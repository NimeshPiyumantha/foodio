import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _onboardingCompletedKey = 'onboarding_completed';
  static const String _userLoggedInKey = 'user_logged_in';
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';
  static const String _usernameKey = 'username';

  static SharedPreferencesService? _instance;
  static SharedPreferences? _preferences;

  SharedPreferencesService._();

  static Future<SharedPreferencesService> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesService._();
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  // Onboarding methods
  Future<bool> isOnboardingCompleted() async {
    return _preferences?.getBool(_onboardingCompletedKey) ?? false;
  }

  Future<void> setOnboardingCompleted() async {
    await _preferences?.setBool(_onboardingCompletedKey, true);
  }

  // User login methods
  Future<bool> isUserLoggedIn() async {
    return _preferences?.getBool(_userLoggedInKey) ?? false;
  }

  Future<void> setUserLoggedIn(bool value) async {
    await _preferences?.setBool(_userLoggedInKey, value);
  }

  Future<String?> getUserId() async {
    return _preferences?.getString(_userIdKey);
  }

  Future<void> setUserId(String userId) async {
    await _preferences?.setString(_userIdKey, userId);
  }

  Future<String?> getUserEmail() async {
    return _preferences?.getString(_userEmailKey);
  }

  Future<void> setUserEmail(String email) async {
    await _preferences?.setString(_userEmailKey, email);
  }

  Future<String?> getUsername() async {
    return _preferences?.getString(_usernameKey);
  }

  Future<void> setUsername(String username) async {
    await _preferences?.setString(_usernameKey, username);
  }

  // Clear all user data (for logout)
  Future<void> clearUserData() async {
    await _preferences?.remove(_userLoggedInKey);
    await _preferences?.remove(_userIdKey);
    await _preferences?.remove(_userEmailKey);
    await _preferences?.remove(_usernameKey);
  }

  // Clear all data (for complete reset)
  Future<void> clearAllData() async {
    await _preferences?.clear();
  }
} 