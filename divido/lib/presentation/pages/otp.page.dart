import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class OtpInputPage extends StatefulWidget {
  final String verificationId;
  final FirebaseAuth firebaseAuth;

  const OtpInputPage(
      {Key? key, required this.verificationId, required this.firebaseAuth})
      : super(key: key);

  @override
  _OtpInputPageState createState() => _OtpInputPageState();
}

class _OtpInputPageState extends State<OtpInputPage> {
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _verifyOtp() async {
    final smsCode = _otpController.text.trim();
    if (smsCode.isEmpty) {
      return;
    }

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: smsCode,
      );
      await widget.firebaseAuth.signInWithCredential(credential);
      context.go('/friend-list');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verificar Celular')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _otpController,
              decoration: const InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              autofocus: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyOtp,
              child: const Text('Verificar'),
            ),
          ],
        ),
      ),
    );
  }
}
