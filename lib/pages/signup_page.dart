import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/credential_provider.dart';
import '../models/credential_model.dart';
import '../providers/auth_provider.dart';

// SignupPage widget for user registration
class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    // First name TextFormField
    final firstName = TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter a first name";
        }
        return null;
      },
      controller: firstNameController,
      decoration: const InputDecoration(
        hintText: "First Name",
      ),
    );

    // Last name TextFormField
    final lastName = TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter a last name";
        }
        return null;
      },
      controller: lastNameController,
      decoration: const InputDecoration(
        hintText: "Last Name",
      ),
    );

    // Email TextFormField
    final email = TextFormField(
      validator: (value) {
        if (value == null || !(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value))) {
          return "Please enter a valid email";
        }
        return null;
      },
      controller: emailController,
      decoration: const InputDecoration(
        hintText: "Email",
      ),
    );

    // Password TextFormField
    final password = TextFormField(
      validator: (value) {
        if (value == null || !(value.length > 6)) {
          return "Passwords must have more than 6 characters.";
        }
        return null;
      },
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
    );

    // Signup Button
    final signupButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          if (context.mounted && _formKey.currentState!.validate()) {
            String uid = await context.read<MyAuthProvider>().signUp(
                emailController.text, passwordController.text);

            context.read<CredProvider>().addUser(Credential(
                  userId: uid,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  password: passwordController.text));

            Navigator.pop(context);
          }
        },
        child: const Text('Sign up', style: TextStyle(color: Colors.blue)),
      ),
    );

    // Back Button
    final backButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back', style: TextStyle(color: Colors.blue)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          children: <Widget>[
            const Text(
              "Sign Up",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(child: firstName),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Flexible(child: lastName),
                    ],
                  ),
                  email,
                  password,
                ],
              ),
            ),
            signupButton,
            backButton
          ],
        ),
      ),
    );
  }
}
