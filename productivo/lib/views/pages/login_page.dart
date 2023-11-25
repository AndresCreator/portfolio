import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:productivo/firebase/auth_services.dart';
import 'package:productivo/views/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _emailError = '';
  String _passwordError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                setState(() {
                  // Reset errors
                  _emailError = '';
                  _passwordError = '';

                  // Validate username
                  if (_emailController.text.length <= 4) {
                    _emailError = 'Email must be more than 4 characters';
                  }

                  // Validate password
                  if (_passwordController.text.length <= 8) {
                    _passwordError = 'Password must be more than 8 characters';
                  }

                  // Proceed with login if no errors
                  if (_emailError.isEmpty && _passwordError.isEmpty) {
                    _login();
                  }
                });
              },
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 12),
                children: <TextSpan>[
                  const TextSpan(text: "Don't have an account? "),
                  TextSpan(
                    text: 'SIGN UP',
                    style: const TextStyle(color: Colors.red),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Handle the tap event
                        context.go('/signup');
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

  void _login() async {
    try {
      User? user = await _auth.signInWithEmailAndPassword(
          _emailController.text, _passwordController.text);
      if (user != null) {
        context.go('/initial');
      } else {
        log("Error logging in");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
