  import 'package:flutter/material.dart';
  import 'package:google_fonts/google_fonts.dart';

  class LoginForm extends StatelessWidget {
    String hintText;
    Icon prefixIcon;
    bool obscuretext;
   void Function(String) onchanged;
    LoginForm({required this.hintText, required this.prefixIcon,required this.onchanged,this.obscuretext = false});
    @override
    Widget build(BuildContext context) {
      return TextField(
      obscureText: obscuretext,
        onChanged: onchanged,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.lato(),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff3a3380), width: 3.0),
            ),
            prefixIcon: prefixIcon,
            ),
      );
    }
  }