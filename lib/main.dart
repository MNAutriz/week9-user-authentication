import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/credential_provider.dart';
import '../providers/todo_provider.dart';
import '../providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/login.dart';
import 'pages/todo_page.dart';
import 'pages/user_details_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => TodoListProvider())),
        ChangeNotifierProvider(create: ((context) => CredProvider())),
        ChangeNotifierProvider(create: ((context) => MyAuthProvider())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Root widget of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo with Authentication',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const TodoPage(),
        '/login': (context) => const LoginPage(),
        '/todo': (context) => const LoginPage(),
        '/user_details': (context) => const UserDetailsPage(),
      },
    );
  }
}
