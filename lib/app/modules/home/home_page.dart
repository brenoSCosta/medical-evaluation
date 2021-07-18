import 'package:avaliacao_medica/app/modules/evaluation/components/button_rounded_custom.dart';
import 'package:avaliacao_medica/app/modules/evaluation/components/header_home.dart';
import 'package:avaliacao_medica/app/modules/evaluation/models/evaluation.dart';
import 'package:avaliacao_medica/app/modules/evaluation/repositories/evaluation_repository.dart';
import 'package:avaliacao_medica/app/modules/evaluation/services/send_email.dart';
import 'package:avaliacao_medica/app/styleguide/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_store.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperOne(),
              child: HeaderHome(),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      firstGradientBackgroundColor,
                      secondGradientBackgroundColor
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Enviar avaliações médicas através do app',
                        style: TextStyle(
                          color: primaryTextColor,
                          fontSize: 24,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          'Clique abaixo para  começar avaliação',
                          style: TextStyle(
                            color: primaryTextColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: ButtonRoundedCustom(
                          'Iniciar Avaliação',
                          200,
                          60,
                          () {
                            Modular.to.navigate('/evaluation');
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
