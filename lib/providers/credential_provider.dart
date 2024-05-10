import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/credential_model.dart';
import '../api/firebase_credential_api.dart';

// CredProvider class manages user credential related functionality
class CredProvider with ChangeNotifier {
  late FirebaseCredAPI firebaseService;
  late Stream<QuerySnapshot> _userStream;
  late String firstName;
  late String lastName;
  late String _currentId;
  late String password;

  // Getters for first name, last name, current ID, and password
  String get getFirst => firstName; 
  String get getLast => lastName; 
  String get currentID => _currentId;
  String get getPassword => password;

  // Constructor initializes FirebaseCredAPI instance and fetches users
  CredProvider() {
    firebaseService = FirebaseCredAPI();
    fetchUsers();
  }
  
  // Method to change current ID
  void changeId(String a) {
    _currentId = a;
  }

  // Getter for users stream
  Stream<QuerySnapshot> get users => _userStream;

  // Method to fetch users
  void fetchUsers() {
    _userStream = firebaseService.getAllUsers();
    notifyListeners();
  }

  // Method to add a user
  void addUser(Credential c) async {
    firstName = c.firstName;
    lastName = c.lastName;
    
    String message = await firebaseService.addUser(c.toJson(c));
    print(message);
    notifyListeners();
  }
}
