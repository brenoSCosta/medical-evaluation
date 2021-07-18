import 'package:avaliacao_medica/app/styleguide/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {
  final String text;
  final IconData icon;
  const TitleText(this.text, this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.medical_services_rounded,
                size: 28,
                color: primaryColor,
              ),
            ),
          ),
          TextSpan(
            text: text,
            style: GoogleFonts.alegreya(
              color: primaryTextColor,
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}
