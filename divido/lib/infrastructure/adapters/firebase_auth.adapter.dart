import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../../application/ports/auth.port.dart';

class FirebaseAuthAdapter implements AuthPort {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthAdapter(this._firebaseAuth);

  @override
  Future<void> verifyPhoneNumber(
      String phoneNumber,
      Function(String) onCodeSent,
      Function(String) onVerificationFailed,
      Function(String, String) onVerificationCompleted) async {
    log("BEING CALLED $phoneNumber");
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        log("verificationCompleted");
        await _firebaseAuth.signInWithCredential(credential);
        onVerificationCompleted(
            credential.smsCode!, credential.verificationId!);
      },
      verificationFailed: (FirebaseAuthException e) {
        log("verificationFailed: ${e.message}");
        onVerificationFailed(e.message ?? 'Verification failed');
      },
      codeSent: (String verificationId, int? resendToken) {
        log("codeSent");
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log("codeAutoRetrievalTimeout");
      },
    );
  }
}
