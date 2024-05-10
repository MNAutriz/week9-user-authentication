import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/user_details_page.dart';
import '../pages/modal_todo.dart';
import '../pages/login.dart';
import '../models/todo_model.dart';
import '../providers/credential_provider.dart';
import '../providers/todo_provider.dart';
import '../providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// TodoPage widget for managing todo items
class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late TextEditingController _newTitleController;

  @override
  void initState() {
    super.initState();
    _newTitleController = TextEditingController();
  }

  @override
  void dispose() {
    _newTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late String userId;
    Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todos;
    Stream<User?> userStream = context.watch<MyAuthProvider>().uStream;

    return StreamBuilder(
        stream: userStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return const LoginPage();
          } else {
            userId = snapshot.data!.uid;
            context.read<CredProvider>().changeId(userId);
            return displayScaffold(context, todosStream, userId);
          }
        });
  }

  Scaffold displayScaffold(
    BuildContext context, Stream<QuerySnapshot<Object?>> todosStream, String userId) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(padding: const EdgeInsets.only(top: 50), children: [
        ListTile(
          title: const Text('Details'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserDetailsPage()));
          },
        ),
        ListTile(
          title: const Text('Logout'),
          onTap: () {
            context.read<MyAuthProvider>().signOut();
            Navigator.pop(context);
          },
        ),
      ])),
      appBar: AppBar(
        title: const Text("Todo"),
      ),
      body: StreamBuilder(
        stream: todosStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("No Todos Found"),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: ((context, index) {
              Todo todo = Todo.fromJson(
                  snapshot.data?.docs[index].data() as Map<String, dynamic>);
              if (todo.userId != userId) {
                return const SizedBox();
              } // cant return null apparently.
              return Dismissible(
                key: Key(todo.id.toString()),
                onDismissed: (direction) {
                  context.read<TodoListProvider>().changeSelectedTodo(todo);
                  context.read<TodoListProvider>().deleteTodo();

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${todo.title} dismissed')));
                },
                background: Container(
                  color: Colors.red,
                  child: const Icon(Icons.delete),
                ),
                child: ListTile(
                  title: Text(todo.title),
                  leading: Checkbox(
                    value: todo.completed,
                    onChanged: (bool? value) {
                      context.read<TodoListProvider>().changeSelectedTodo(todo);
                      context.read<TodoListProvider>().toggleStatus(value!);
                    },
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          context
                              .read<TodoListProvider>()
                              .changeSelectedTodo(todo);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => TodoModal(
                              type: 'Edit',
                            ),
                          );
                        },
                        icon: const Icon(Icons.create_outlined),
                      ),
                      IconButton(
                        onPressed: () {
                          context
                              .read<TodoListProvider>()
                              .changeSelectedTodo(todo);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => TodoModal(
                              type: 'Delete',
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete_outlined),
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => TodoModal(
              type: 'Add',
            ),
          );
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}

