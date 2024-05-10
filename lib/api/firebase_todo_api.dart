import 'package:cloud_firestore/cloud_firestore.dart';

// Class responsible for handling CRUD operations with Firebase Firestore for Todo items
class FirebaseTodoAPI {
  // Firebase Firestore instance
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // Add a new Todo item to Firestore
  Future<String> addTodo(Map<String, dynamic> todo) async {
    try {
      // Add new Todo document to 'todos' collection
      final docRef = await db.collection("todos").add(todo);
      // Update the 'id' field of the added Todo document with its document ID
      await docRef.update({'id': docRef.id}); // Update ID with document ID

      return "Successfully added todo!";
    } catch (e) {
      // Return error message if adding Todo fails
      return "Failed to add todo: $e";
    }
  }

  // Retrieve all Todo items from Firestore as a stream
  Stream<QuerySnapshot> getAllTodos() {
    return db.collection("todos").snapshots();
  }

  // Delete a Todo item from Firestore
  Future<String> deleteTodo(String? id) async {
    try {
      // Delete Todo document with given ID from 'todos' collection
      await db.collection("todos").doc(id).delete();

      return "Successfully deleted todo!";
    } catch (e) {
      // Return error message if deleting Todo fails
      return "Failed to delete todo: $e";
    }
  }

  // Toggle the completion status of a Todo item in Firestore
  Future<String> toggleStatus(String? id, bool? status) async {
    try {
      // Update the 'completed' field of the Todo document with given ID
      await db.collection("todos").doc(id).update({'completed': status});

      return "Successfully toggled status!";
    } on FirebaseException catch (e) {
      // Return error message if toggling status fails
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  // Edit the title of a Todo item in Firestore
  Future<String> editTodo(String? id, String newTitle) async {
    try {
      // Update the 'title' field of the Todo document with given ID
      await db.collection("todos").doc(id).update({'title': newTitle});

      return "Successfully edited todo!";
    } on FirebaseException catch (e) {
      // Return error message if editing Todo fails
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
