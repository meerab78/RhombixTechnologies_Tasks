import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});
  final String username = "Meerab";
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, $username',
          style: GoogleFonts.poppins(
            fontSize: 24,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3E2C1C),
          ),
        ),
        SizedBox(height: 14),
        Text(
          'Stay updated with upcoming campus events and activities.',
          style: GoogleFonts.poppins(fontSize: 14, color: Color(0xFF5A4632)),
        ),
      ],
    );
  }
}
