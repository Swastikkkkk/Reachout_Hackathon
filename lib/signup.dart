

import 'package:myapp/Homepage.dart';
// import 'package:community/widget/Button.dart';
import 'widget/Button.dart';
// import 'package:community/widget/universalform.dart';
import 'widget/universalform.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
// import 'package:community/widget/LoginForm.dart';
import 'widget/LoginForm.dart';
const samePadding = EdgeInsets.symmetric(horizontal: 20.0);
var email;
var password;
dynamic Username;
final _auth = FirebaseAuth.instance;
// User userInstance;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         resizeToAvoidBottomInset:false,
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.arrow_back,
                    size: 10.w,
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                padding: samePadding,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Hi !',
                      textStyle: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 40.0),
                      speed: const Duration(milliseconds: 300),
                      textAlign: TextAlign.start,
                    ),
                  ],
                  repeatForever: true,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                padding: samePadding,
                child: Text(
                  'Create a new account',
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 15.0),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Column(
                children: [
               
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                    child: LoginForm(
                      onchanged: (value) {
                        email = value;
                      },
                      hintText: 'Email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color(0xff3a3380),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: LoginForm(
                      onchanged: (value) {
                        password = value;
                      },
                      obscuretext: true,
                      hintText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xff3a3380),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Button(
                    ontap: () async {
                      print(email);
                      print(password);
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomePage()),
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    buttonText: 'Signup',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}