import 'package:firebase_auth/firebase_auth.dart';

// Class responsible for handling authentication operations with Firebase Authentication
class FirebaseAuthAPI {
  // Firebase Authentication instance
  static final FirebaseAuth auth = FirebaseAuth.instance;
  late String currentId; // Variable to store current user ID

  // Retrieve the current user as a stream
  Stream<User?> getUser() {
    // If a current user exists, assign its UID to currentId
    if (auth.currentUser != null) { currentId = auth.currentUser!.uid; }
    // Return a stream of authentication state changes
    return auth.authStateChanges();
  }

  // Getter method to retrieve current user ID
  String get current => currentId;

  // Sign in with email and password
  Future<void> signIn(String email, String password) async {
    try {
      // Sign in with provided email and password
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      // Print user credential
      print(credential);
      // Update currentId with user's UID
      currentId = credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      // Handle different authentication exceptions
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        print('Invalid email :((');
      }
    }
  }

  // Sign up with email and password
  Future<String> signUp(String email, String password) async {
    try {
      // Create user with provided email and password
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Update currentId with new user's UID
      currentId = credential.user!.uid;
      // Return new user's UID
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      // Handle different authentication exceptions
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      // Print any other errors
      print(e);
    }
    // Return a generic error message if sign up fails
    return "e";
  }

  // Sign out the current user
  Future<void> signOut() async {
    await auth.signOut();
  }
}
