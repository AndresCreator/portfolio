import '../ports/auth.port.dart';

class VerifyPhoneNumberUseCase {
  final AuthPort authPort;

  VerifyPhoneNumberUseCase(this.authPort);

  Future<void> execute(
      String phoneNumber,
      Function(String) onCodeSent,
      Function(String) onVerificationFailed,
      Function(String, String) onVerificationCompleted) async {
    await authPort.verifyPhoneNumber(
        phoneNumber, onCodeSent, onVerificationFailed, onVerificationCompleted);
  }
}
