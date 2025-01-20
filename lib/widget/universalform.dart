// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateForm extends StatelessWidget {
  String hintText;
  Icon prefixIcon;
  bool obscuretext;
  void Function(String) onchanged;
  CreateForm({required this.hintText, required this.prefixIcon,required this.onchanged,this.obscuretext = false});
  @override
  Widget build(BuildContext context) {
    return TextField(
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