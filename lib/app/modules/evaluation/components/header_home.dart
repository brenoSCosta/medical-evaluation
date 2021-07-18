import 'package:avaliacao_medica/app/modules/evaluation/components/title_text.dart';
import 'package:flutter/material.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 535,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/doctor-home.jpg'),
            fit: BoxFit.fill),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TitleText('Avaliação Médica', Icons.medical_services)
            ],
          ),
        ),
      ),
    );
  }
}
