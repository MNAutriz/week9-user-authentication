import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api/firebase_auth_api.dart';

// MyAuthProvider class manages authentication related functionality
class MyAuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> uStream;
  User? userObj;

  // Constructor initializes FirebaseAuthAPI instance and fetches authentication
  MyAuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  // Getter for userStream
  Stream<User?> get userStream => uStream;

  // Method to fetch authentication
  void fetchAuthentication() {
    uStream = authService.getUser();
    notifyListeners();
  }

  // Method to get current user ID
  String getCurrentUserID() {
    return authService.current;
  }

  // Method to sign up a new user
  Future<String> signUp(String email, String password) async {
    String id = await authService.signUp(email, password);
    notifyListeners();
    return id;
  }

  // Method to sign in an existing user
  Future<void> signIn(String email, String password) async {
    await authService.signIn(email, password);
    notifyListeners();
  }

  // Method to sign out the current user
  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}
