import 'dart:convert';

// Model class representing a Todo item
class Todo {
  final String userId; // User ID associated with the Todo item
  String? id; // Todo item ID
  String title; // Title of the Todo item
  bool completed; // Completion status of the Todo item

  // Constructor
  Todo({
    required this.userId,
    this.id,
    required this.title,
    required this.completed,
  });

  // Factory method to create a Todo object from JSON data
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  // Static method to convert a JSON array to a list of Todo objects
  static List<Todo> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Todo>((dynamic d) => Todo.fromJson(d)).toList();
  }

  // Method to convert a Todo object to JSON data
  Map<String, dynamic> toJson(Todo todo) {
    return {
      'userId': todo.userId,
      'id': todo.id,
      'title': todo.title,
      'completed': todo.completed,
    };
  }
}
