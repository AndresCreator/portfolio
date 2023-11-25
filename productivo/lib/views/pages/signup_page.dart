import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:productivo/firebase/auth_services.dart';
import 'package:productivo/views/widgets/custom_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _usernameError = '';
  String _passwordError = '';
  String _emailError = '';
  String _confirmPasswordError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
              labelText: 'Username',
              controller: _usernameController,
              isPassword: false,
              isError: _usernameError.isNotEmpty,
              errorMessage: _usernameError,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: 'Email',
              controller: _emailController,
              isPassword: false,
              isError: _emailError.isNotEmpty,
              errorMessage: _emailError,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: 'Password',
              controller: _passwordController,
              isPassword: true,
              isError: _passwordError.isNotEmpty,
              errorMessage: _passwordError,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: 'Confirm Password',
              controller: _confirmPasswordController,
              isPassword: true,
              isError: _confirmPasswordError.isNotEmpty,
              errorMessage: _confirmPasswordError,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Sign Up'),
              onPressed: () {
                setState(() {
                  // Reset errors
                  _usernameError = '';
                  _passwordError = '';
                  _emailError = '';
                  _confirmPasswordError = '';

                  // Add your validation logic here
                  // Example: Validate email, password matching, etc.
                  if (_passwordController.text !=
                      _confirmPasswordController.text) {
                    _confirmPasswordError = 'Passwords do not match';
                  }
                  // Proceed with sign-up if no errors
                });
                if (_usernameError.isEmpty &&
                    _passwordError.isEmpty &&
                    _emailError.isEmpty &&
                    _confirmPasswordError.isEmpty) {
                  _signUp();
                }
              },
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 12),
                children: <TextSpan>[
                  const TextSpan(text: "Already have an account? "),
                  TextSpan(
                    text: 'LOGIN',
                    style: const TextStyle(color: Colors.red),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Handle the tap event
                        context.go('/');
                        // Navigate to sign-up screen or perform any action you want
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signUp() async {
    String name = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      // Handle empty fields (show an error message, etc.)
      log("Please fill all the fields");
      return;
    }

    // Proceed with sign-up if display name is not taken
    User? user = await _auth.signUpWithEmailAndPassword(email, password, name);
    if (user != null) {
      context.go('/initial');
    } else {
      // Handle sign-up error
      log("Error signing up");
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
