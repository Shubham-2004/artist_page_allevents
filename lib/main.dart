import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _otpCode = "";

  @override
  void initState() {
    super.initState();
    // Start listening for the SMS automatically when the page loads
    SmsAutoFill().listenForCode();
  }

  @override
  void dispose() {
    // Unregister the listener when the widget is disposed
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMS OTP Autofill'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('Enter the OTP sent to your phone:'),
            const SizedBox(height: 16.0),
            // This widget automatically fills the code
            PinFieldAutoFill(
              decoration: UnderlineDecoration(
                textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
              ),
              currentCode: _otpCode,
              onCodeSubmitted: (code) {
                setState(() {
                  _otpCode = code; // Update the OTP when submitted
                });
              },
              onCodeChanged: (code) {
                if (code != null && code.length == 6) {
                  setState(() {
                    _otpCode = code; // Automatically fill the OTP
                  });
                  FocusScope.of(context).unfocus(); // Hide keyboard
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
