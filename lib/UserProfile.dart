import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/chatbot.dart';
// import 'package:community/screenspost.dart';
import 'post.dart';
import 'signup.dart';
import 'widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3918930754.
import 'dart:math';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';















class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Text("This is User Profile"),
        ),
      ),
    );
  }
}
