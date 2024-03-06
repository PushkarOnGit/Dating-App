import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  MyButton({
    super.key,
    this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.pink[400],
          borderRadius: BorderRadius.circular(7),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.signika(letterSpacing: 2, fontSize: 16, color: Colors.white,fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
