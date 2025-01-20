  // import 'package:community/constants/buttonStyle.dart';
// import 'package:community/constants/textStyle.dart';
import 'constants/buttonStyle.dart';
import 'constants/textStyle.dart';
import 'Login.dart';
import 'signup.dart';
// import 'package:community/widget/Button.dart';
import 'widget/Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StartingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: 
      [
        Expanded(child: SvgPicture.asset('assets/city.svg')),

        SizedBox(
          height: 3.h,
        ),

        Expanded(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [

    Container(
      alignment: Alignment.center,
      child: Text(
      'Hello !',
      style:GoogleFonts.lato(
       textStyle: homePageTextStyle.copyWith(fontSize: 25.0,color: Colors.black),
      ),
      ),
    ),    

      SizedBox(
        height: 2.h,
      ),

      Text('Help your community \n make a better future',
      style:GoogleFonts.lato(
        textStyle: homePageTextStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 15.0,letterSpacing:0.5 ),
      ),
      textAlign: TextAlign.center,
      ),

      SizedBox(
        height: 5.h,
      ),

      GestureDetector(
        onTap: (){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
        },
        child: Container(
          width: 55.w,
          alignment: Alignment.center,
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
          border: Border.all(color: Color(0xff3a3380),width:2.0),
          borderRadius: BorderRadius.circular(5.0),
          ),
          child:Text(
            'Login',
            style:homePageTextStyle.copyWith(
              color: Color(0xff3a3380),
            fontWeight: FontWeight.w400,
          ),
        ),
        ),
      ),

      SizedBox(height: 3.h,),

  GestureDetector(
    onTap: (){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignupPage()),
);
    },
        child: Container(
          width: 55.w,
          alignment: Alignment.center,
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
          border: Border.all(color: Color(0xff3a3380),width:2.0),
          borderRadius: BorderRadius.circular(5.0),
          ),
          child:Text(
            'Signup',
            style:homePageTextStyle.copyWith(
              color: Color(0xff3a3380),
            fontWeight: FontWeight.w400,
          ),
        ),
        ),
      ),
       ],
        )
        ),
  
]
      ),
    );
  }
}