import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../application/ports/auth.port.dart';
import '../../infrastructure/adapters/firebase_auth.adapter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late AuthPort _authPort;

  late bool _isSigningIn;

  @override
  void initState() {
    super.initState();
    _authPort = FirebaseAuthAdapter(_auth);
    _isSigningIn = false;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _signInWithPhoneNumber() async {
    setState(() {
      _isSigningIn = true;
      log("SIGNING IN");
    });
    final String phoneNumber = _phoneController.text.trim();
    await _authPort.verifyPhoneNumber(
      '+$phoneNumber',
      (String verificationId) {
        context.go('/otp?verificationId=$verificationId');
      },
      (String error) {
        // Show the error message using SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $error'),
            backgroundColor: Colors.red,
          ),
        );
      },
      (String smsCode, String verificationId) async {
        final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        );
        await _auth.signInWithCredential(credential);
      },
    );
    setState(() {
      _isSigningIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                prefixText: '+',
              ),
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
              onPressed: _isSigningIn ? null : _signInWithPhoneNumber,
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
