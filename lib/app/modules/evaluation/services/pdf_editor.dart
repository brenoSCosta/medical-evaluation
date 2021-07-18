import 'dart:io';
import 'package:avaliacao_medica/app/modules/evaluation/models/evaluation.dart';

import 'package:pdf/widgets.dart' as pdfLib;
import 'package:path_provider/path_provider.dart';

Future<String> creatPdf(Evaluation evaluation) async {
  final pdfLib.Document pdf = pdfLib.Document(deflate: zlib.encode);

  pdf.addPage(pdfLib.MultiPage(
      build: (context) => [
            pdfLib.Header(text: 'Avaliação Médica'),
            _textRowCustom('Nome', evaluation.name),
            _textRowCustom('Email', evaluation.email),
            _textRowCustom('Telefone', evaluation.sms),
            _textRowCustom(
                'Data de nascimento',
                '${evaluation.dateNasc.day}/${evaluation.dateNasc.month}/'
                    '${evaluation.dateNasc.year}'),
            _textRowCustom('Gênero', evaluation.gender),
            _textRowCustom('Raça', evaluation.race),
            _textRowCustom('Peso', evaluation.weight.toString()),
            _textRowCustom('Altura', evaluation.height.toString()),
            _textRowCustom('Circunferência da Cintura',
                evaluation.circumferenceWaist.toString()),
            _textRowCustom('Circunferência do Quadril',
                evaluation.circumferenceHip.toString()),
            _textRowCustom(
                'Pressão Alta', evaluation.highPressure ? 'sim' : 'não'),
            _textRowCustom('Pressão Arterial Sistólica',
                evaluation.bloodPressure.toString()),
            _textRowCustom(
                'Valor do Colesterol HDL', evaluation.cholesterol.toString()),
            _textRowCustom(
                'Valor do Triglicérides', evaluation.triglycerides.toString()),
            _textRowCustom('Diabético', evaluation.diabetic ? 'sim' : 'não'),
            _textRowCustom(
                'Valor da Glicemia em Jejum', evaluation.glicemia.toString()),
            _textRowCustom('Valor da Proteína C Reativa ultrassensível',
                evaluation.reactiveProteinC.toString()),
            _textRowCustom('Imc', evaluation.imc.toString()),
          ]));
/*<h1>Avaliação Médica de ${evalution.name}</h1>"
          "<p>Nome: ${evalution.name}</p> <p>Email: ${evalution.email}</p>"
          "<p>Telefone: ${evalution.sms}</p>"
          "<p>Data de nascimento: ${evalution.dateNasc} </p>"
          "<p>Gênero: ${evalution.gender} </p>"
          "<p>Raça: ${evalution.race} </p>"
          "<p>Peso: ${evalution.weight} </p>"
          "<p>Altura: ${evalution.height} </p>"
          "<p>Circunferência da Cintura: ${evalution.circumferenceWaist} </p>"
          "<p>Circunferência do Quadril: ${evalution.circumferenceHip} </p>"
          "<p>Possui pressão alta: ${evalution.highPressure} </p>"
          "<p>Pressão Arterial Sistólica: ${evalution.bloodPressure} </p>"
          "<p>Valor do Colesterol HDL: ${evalution.cholesterol} </p>"
          "<p>Valor do Triglicérides: ${evalution.triglycerides} </p>"
          "<p>Diabético: ${evalution.diabetic} </p>"
          "<p>Valor da Glicemia em Jejum: ${evalution.glicemia} </p>"
          "<p>Valor da Proteína C Reativa ultrassensível: ${evalution.reactiveProteinC} </p>"; */
  final String dir = (await getApplicationDocumentsDirectory()).path;

  final String path = '$dir/pdfAvaliacaoMedica.pdf';
  final File file = File(path);
  file.writeAsBytesSync(await pdf.save());
  return path;
}

pdfLib.Widget _textRowCustom(String text, String value) {
  return pdfLib.Row(
    children: <pdfLib.Widget>[
      pdfLib.Padding(
        padding: pdfLib.EdgeInsets.all(10),
        child: pdfLib.Text('$text: $value'),
      ),
    ],
  );
}
