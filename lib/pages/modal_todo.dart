import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/todo_model.dart';
import '../providers/todo_provider.dart';

// TodoModal widget for adding, editing, or deleting a todo item
class TodoModal extends StatelessWidget {
  String type; // Type of operation: Add, Edit, or Delete
  final TextEditingController _formFieldController = TextEditingController();

  // Constructor
  TodoModal({
    Key? key,
    required this.type,
  });

  // Build the title of the modal based on the type
  Text _buildTitle() {
    switch (type) {
      case 'Add':
        return const Text("Add new todo");
      case 'Edit':
        return const Text("Edit todo");
      case 'Delete':
        return const Text("Delete todo");
      default:
        return const Text("");
    }
  }

  // Build the content of the modal based on the type
  Widget _buildContent(BuildContext context) {
    switch (type) {
      case 'Delete':
        {
          return Text(
            "Are you sure you want to delete '${context.read<TodoListProvider>().selected.title}'?",
          );
        }
      default:
        return TextField(
          controller: _formFieldController,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        );
    }
  }

  // Define the action of the dialog based on the type
  TextButton _dialogAction(BuildContext context) {
    return TextButton(
      onPressed: () {
        switch (type) {
          case 'Add':
            {
              context.read<MyAuthProvider>().fetchAuthentication();
              Todo temp = Todo(
                  userId: context.read<MyAuthProvider>().getCurrentUserID(),
                  completed: false,
                  title: _formFieldController.text);

              context.read<TodoListProvider>().addTodo(temp);
              Navigator.of(context).pop();
              break;
            }
          case 'Edit':
            {
              String newTitle = _formFieldController.text;
              context.read<TodoListProvider>().editTodo(newTitle);
              Navigator.of(context).pop();
              break;
            }
          case 'Delete':
            {
              context.read<TodoListProvider>().deleteTodo();
              Navigator.of(context).pop();
              break;
            }
        }
      },
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.labelLarge,
      ),
      child: Text(type),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _buildTitle(),
      content: _buildContent(context),
      actions: <Widget>[
        _dialogAction(context),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
