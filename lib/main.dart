// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:myapp/Homepage.dart';
import 'package:myapp/firebase_options.dart';
// Suggested code may be subject to a license. Learn more: ~LicenseLog:395411585.
import 'startingScreen.dart';
import 'chatbot.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

const GEMINI_API_KEY = 'AIzaSyCrzqhFxN24WIoVg_T8gkf9kI6xv2dog1k';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Gemini.init(apiKey: GEMINI_API_KEY);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        home: StartingPage(),
      );
    });
  }
}

