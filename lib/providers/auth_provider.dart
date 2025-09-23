import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skill_swap_platform/services/auth_service.dart';
import 'package:skill_swap_platform/models/user_model.dart';
import 'package:skill_swap_platform/services/firestore_service.dart';
import 'package:skill_swap_platform/services/storage_service.dart';

// This provider manages the authentication state of the application.
class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  final StorageService _storageService = StorageService();

  User? _user;
  UserModel? _userModel;
  bool _isLoading = false;

  User? get user => _user;
  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _authService.authStateChanges.listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? user) async {
    _user = user;
    if (user != null) {
      await _fetchUserModel(user.uid);
    } else {
      _userModel = null;
    }
    notifyListeners();
  }
  
  // A helper function to fetch and set the user model.
  Future<void> _fetchUserModel(String uid) async {
     _userModel = await _firestoreService.getUser(uid);
     notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    await _authService.signInWithEmailAndPassword(email, password);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();
    await _authService.registerWithEmailAndPassword(name, email, password);
    _isLoading = false;
    notifyListeners();
  }
  
  // Update the user's profile information.
  Future<void> updateUserProfile({required String name, required String bio, File? image}) async {
    _isLoading = true;
    notifyListeners();

    String? imageUrl;
    if (image != null) {
      // Upload the image to Firebase Storage if a new one is provided.
      imageUrl = await _storageService.uploadProfilePicture(user!.uid, image);
    }

    // Prepare the data to be updated.
    Map<String, dynamic> updatedData = {
      'name': name,
      'bio': bio,
      // Only update the profile picture URL if a new one was uploaded.
      if (imageUrl != null) 'profilePictureUrl': imageUrl,
    };
    
    // Update the user document in Firestore.
    await _firestoreService.updateUser(user!.uid, updatedData);
    // Refresh the local user model.
    await _fetchUserModel(user!.uid);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}

