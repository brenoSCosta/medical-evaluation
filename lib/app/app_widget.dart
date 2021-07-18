import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:avaliacao_medica/app/styleguide/colors.dart' as colorsProject;
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Avaliação Médica',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
          primarySwatch: MaterialColor(
              colorsProject.primaryColor.value, colorsProject.color)),
    ).modular();
  }
}
