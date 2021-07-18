import 'dart:io';

import 'package:avaliacao_medica/app/modules/evaluation/models/evaluation.dart';
import 'package:avaliacao_medica/app/modules/evaluation/services/pdf_editor.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

String username = 'avaliacoesmedicas@gmail.com';
String password = 'rtssap2K@@';
// ignore: deprecated_member_use
final smtpServer = gmail(username, password);

sendMail(
    Evaluation evaluation, String emailToSend, BuildContext context) async {
  String response = '';
  creatPdf(evaluation).then((value) async {
    final message = Message()
      ..from = Address(username, 'Avaliações Médicas App')
      ..recipients.add(emailToSend)
      ..subject = 'Avaliação Médica'
      ..attachments.add(FileAttachment(File(value)))
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Avaliação Médica de ${evaluation.name}</h1>"
          "<p>Nome: ${evaluation.name}</p> <p>Email: ${evaluation.email}</p>"
          "<p>Telefone: ${evaluation.sms}</p>"
          "<p>Data de nascimento: ${evaluation.dateNasc.day}/${evaluation.dateNasc.month}/${evaluation.dateNasc.year} </p>"
          "<p>Gênero: ${evaluation.gender} </p>"
          "<p>Raça: ${evaluation.race} </p>"
          "<p>Peso: ${evaluation.weight} </p>"
          "<p>Altura: ${evaluation.height} </p>"
          "<p>Circunferência da Cintura: ${evaluation.circumferenceWaist} </p>"
          "<p>Circunferência do Quadril: ${evaluation.circumferenceHip} </p>"
          "<p>Possui pressão alta: ${evaluation.highPressure ? 'sim' : 'não'} </p>"
          "<p>Pressão Arterial Sistólica: ${evaluation.bloodPressure} </p>"
          "<p>Valor do Colesterol HDL: ${evaluation.cholesterol} </p>"
          "<p>Valor do Triglicérides: ${evaluation.triglycerides} </p>"
          "<p>Diabético: ${evaluation.diabetic ? 'sim' : 'não'} </p>"
          "<p>Valor da Glicemia em Jejum: ${evaluation.glicemia} </p>"
          "<p>Valor da Proteína C Reativa ultrassensível: ${evaluation.reactiveProteinC} </p>"
          "<p>Imc: ${evaluation.imc} </p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      sendEmailConfirmation(evaluation);
      response = 'sucess';
    } on MailerException catch (e) {
      print('Message not sent.');
      response = 'error';
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

    var connection = PersistentConnection(smtpServer);

    // await connection.send(message);

    await connection.close();
    return response;
  });
}

sendEmailConfirmation(Evaluation evaluation) async {
  final message = Message()
    ..from = Address(username, 'Avaliações Médicas App')
    ..recipients.add(evaluation.email)
    ..subject = 'Avaliação Médica'
    ..html = "<h1>${evaluation.name} sua avaliação foi enviada com sucesso</h1>"
        "<p>Sua avaliação foi enviada com sucesso para o médico em questão.</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }

  var connection = PersistentConnection(smtpServer);

  // await connection.send(message);

  await connection.close();
}
