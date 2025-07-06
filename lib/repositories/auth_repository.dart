import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import 'shared_preferences_service.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  late SharedPreferencesService _prefsService;

  AuthRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance {
    _initializePrefsService();
  }

  Future<void> _initializePrefsService() async {
    try {
      _prefsService = await SharedPreferencesService.getInstance();
    } catch (e) {
      print('Failed to initialize SharedPreferencesService: $e');
    }
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      // Check if username already exists
      final usernameQuery = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (usernameQuery.docs.isNotEmpty) {
        throw 'Username already exists';
      }

      // Create user with Firebase Auth
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user document in Firestore
      final user = UserModel(
        id: userCredential.user!.uid,
        email: email,
        username: username,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _firestore.collection('users').doc(user.id).set(user.toMap());

      // Save user data to shared preferences
      await _prefsService.setUserLoggedIn(true);
      await _prefsService.setUserId(user.id);
      await _prefsService.setUserEmail(email);
      await _prefsService.setUsername(username);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An unknown error occurred';
    }
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get user data from Firestore
      final userData = await getCurrentUserData();
      if (userData != null) {
        // Save user data to shared preferences
        await _prefsService.setUserLoggedIn(true);
        await _prefsService.setUserId(userData.id);
        await _prefsService.setUserEmail(userData.email);
        await _prefsService.setUsername(userData.username);
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An unknown error occurred';
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    // Clear user data from shared preferences
    await _prefsService.clearUserData();
  }

  // Get current user data from Firestore
  Future<UserModel?> getCurrentUserData() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) return null;

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      throw 'Failed to get user data: $e';
    }
  }

  // Update current user data
  Future<void> updateCurrentUserData(Map<String, dynamic> data) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) throw 'No user logged in';

      data['updatedAt'] = DateTime.now().toIso8601String();
      await _firestore.collection('users').doc(user.uid).update(data);
    } catch (e) {
      throw 'Failed to update user data: $e';
    }
  }
}
