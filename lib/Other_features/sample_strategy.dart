import 'package:otp_autofill/otp_autofill.dart';

class SampleStrategy extends OTPStrategy {
  @override
  String? extractOTP(String message) {
    final otp = RegExp(r'(\d{5})').stringMatch(message);
    return otp;
  }

  @override
  Future<String> listenForCode() {
    throw UnimplementedError();
  }
}
