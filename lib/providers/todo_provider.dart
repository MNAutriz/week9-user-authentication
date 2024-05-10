import 'package:flutter/material.dart';
import '../api/firebase_todo_api.dart';
import '../models/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// TodoListProvider class manages todo-related functionality
class TodoListProvider with ChangeNotifier {
  late FirebaseTodoAPI firebaseService;
  late Stream<QuerySnapshot> _todosStream;
  Todo? _selectedTodo;

  // Constructor initializes FirebaseTodoAPI instance and fetches todos
  TodoListProvider() {
    firebaseService = FirebaseTodoAPI();
    fetchTodos();
  }

  // Getter for todos stream
  Stream<QuerySnapshot> get todos => _todosStream;

  // Getter for selected todo
  Todo get selected => _selectedTodo!;

  // Method to change selected todo
  void changeSelectedTodo(Todo item) {
    _selectedTodo = item;
  }

  // Method to fetch todos
  void fetchTodos() {
    _todosStream = firebaseService.getAllTodos();
    notifyListeners();
  }

  // Method to add a todo
  void addTodo(Todo item) async {
    String message = await firebaseService.addTodo(item.toJson(item));
    print(message);
    notifyListeners();
  }

  // Method to edit a todo
  void editTodo(String newTitle) async {
    String message =
        await firebaseService.editTodo(_selectedTodo!.id, newTitle);
    print(message);
    notifyListeners();
  }

  // Method to toggle todo status
  void toggleStatus(bool? status) async {
    String message =
        await firebaseService.toggleStatus(_selectedTodo!.id, status);
    print(message);
    notifyListeners();
  }

  // Method to delete a todo
  void deleteTodo() async {
    String message = await firebaseService.deleteTodo(_selectedTodo!.id);
    print(message);
    notifyListeners();
  }
}
