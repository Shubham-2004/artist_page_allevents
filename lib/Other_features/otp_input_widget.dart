import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'sample_strategy.dart'; // Separate file for SampleStrategy

class OTPInputWidget extends StatefulWidget {
  const OTPInputWidget({Key? key}) : super(key: key);

  @override
  _OTPInputWidgetState createState() => _OTPInputWidgetState();
}

class _OTPInputWidgetState extends State<OTPInputWidget> {
  late OTPTextEditController controller;
  late OTPInteractor _otpInteractor;
  bool isInteractorInitialized = false; // Track initialization status

  @override
  void initState() {
    super.initState();
    _initInteractor();
  }

  Future<void> _initInteractor() async {
    _otpInteractor = OTPInteractor();
    // Get app signature for debugging
    final appSignature = await _otpInteractor.getAppSignature();

    if (kDebugMode) {
      print('Your app signature: $appSignature');
    }

    controller = OTPTextEditController(
      codeLength: 5,
      onCodeReceive: (code) => print('Received OTP: $code'),
      otpInteractor: _otpInteractor,
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{5})');
          return exp.stringMatch(code ?? '') ?? '';
        },
        strategies: [SampleStrategy()],
      );

    setState(() {
      isInteractorInitialized = true; // Set to true after initialization
    });
  }

  @override
  void dispose() {
    controller.stopListen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: isInteractorInitialized
          ? TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter OTP',
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
