import 'dart:convert';

// Model class representing user credentials
class Credential {
  String userId; // User ID
  String firstName; // First name
  String lastName; // Last name
  String password; // Password

  // Constructor
  Credential({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.password,
  });

  // Factory method to create a Credential object from JSON data
  factory Credential.fromJson(Map<String, dynamic> json) {
    return Credential(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['password'],
    );
  }

  // Static method to convert a JSON array to a list of Credential objects
  static List<Credential> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Credential>((dynamic d) => Credential.fromJson(d)).toList();
  }

  // Method to convert a Credential object to JSON data
  Map<String, dynamic> toJson(Credential c) {
    return {
      'userId': c.userId,
      'firstName': c.firstName,
      'lastName': c.lastName,
      'password': c.password,
    };
  }
}
