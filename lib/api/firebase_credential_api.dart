import 'package:cloud_firestore/cloud_firestore.dart';

// Class responsible for handling user credential operations with Firebase Firestore
class FirebaseCredAPI {
  // Firebase Firestore instance
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // Add a new user credential to Firestore
  Future<String> addUser(Map<String, dynamic> user) async {
    try {
      // Add new user document to 'CredentialInfo' collection
      final docRef = await db.collection("CredentialInfo").add(user);
      // Update the 'id' field of the added user document with its document ID
      await db.collection("CredentialInfo").doc(docRef.id).update({'id': docRef.id});

      return "Successfully added user!";
    } on FirebaseException catch (e) {
      // Return error message if adding user fails
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  // Retrieve all user credentials from Firestore as a stream
  Stream<QuerySnapshot> getAllUsers() {
    return db.collection("CredentialInfo").snapshots();
  }
}
