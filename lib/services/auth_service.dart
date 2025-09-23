import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skill_swap_platform/models/user_model.dart';
import 'package:skill_swap_platform/services/firestore_service.dart';

// This service handles all Firebase Authentication logic.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  // Stream for authentication state changes.
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password.
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      log('Firebase Auth Exception (Sign In): ${e.message}', error: e);
      return null;
    } catch (e) {
      log('An unexpected error occurred (Sign In)', error: e);
      return null;
    }
  }

  // Register with email and password.
  Future<User?> registerWithEmailAndPassword(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        UserModel newUser = UserModel(uid: user.uid, name: name, email: email);
        await _firestoreService.createUser(newUser);
      }
      return user;
    } on FirebaseAuthException catch (e) {
      log('Firebase Auth Exception (Register): ${e.message}', error: e);
      return null;
    } catch (e) {
      log('An unexpected error occurred (Register)', error: e);
      return null;
    }
  }

  // Sign out.
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log('Error signing out', error: e);
    }
  }
}

