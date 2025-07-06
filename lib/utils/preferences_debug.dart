import '../repositories/shared_preferences_service.dart';

class PreferencesDebug {
  static Future<void> printAllPreferences() async {
    try {
      final prefs = await SharedPreferencesService.getInstance();
      
      print('=== Shared Preferences Debug Info ===');
      print('Onboarding Completed: ${await prefs.isOnboardingCompleted()}');
      print('User Logged In: ${await prefs.isUserLoggedIn()}');
      print('User ID: ${await prefs.getUserId()}');
      print('User Email: ${await prefs.getUserEmail()}');
      print('Username: ${await prefs.getUsername()}');
      print('=====================================');
    } catch (e) {
      print('Error reading preferences: $e');
    }
  }

  static Future<void> clearAllData() async {
    try {
      final prefs = await SharedPreferencesService.getInstance();
      await prefs.clearAllData();
      print('All shared preferences data cleared');
    } catch (e) {
      print('Error clearing preferences: $e');
    }
  }

  static Future<void> resetOnboarding() async {
    try {
      final prefs = await SharedPreferencesService.getInstance();
      // Clear only onboarding status
      await prefs.setOnboardingCompleted();
      await prefs.setOnboardingCompleted(); // This will set it to true
      print('Onboarding status reset');
    } catch (e) {
      print('Error resetting onboarding: $e');
    }
  }
} 