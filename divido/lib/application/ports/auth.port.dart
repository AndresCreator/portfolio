abstract class AuthPort {
  Future<void> verifyPhoneNumber(
      String phoneNumber,
      Function(String) onCodeSent,
      Function(String) onVerificationFailed,
      Function(String, String) onVerificationCompleted);
}
