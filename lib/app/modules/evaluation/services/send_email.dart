import 'dart:convert';

import 'package:avaliacao_medica/app/modules/evaluation/models/evaluation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future sendEmail({required Evaluation evaluation}) async {
  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  final response = await http.post(url, headers: {
    'origin': 'http://localhost',
    'Content-type': 'application/json',
  }, body: json.encode({
    'service_id': 'service_oje00s9',
    'template_id': 'template_rj8xacb',
    'user_id': 'eT0iZP3HgAHErjc7P',
    'template_params': {
      'name': evaluation.name,
      'email': evaluation.email,
      'sms': evaluation.sms,
      'day': evaluation.dateNasc.day,
      'month': evaluation.dateNasc.month,
      'year': evaluation.dateNasc.year,
      'gender': evaluation.gender,
      'race': evaluation.race,
      'weight': evaluation.weight,
      'height': evaluation.height,
      'circumferenceWaist': evaluation.circumferenceWaist,
      'circumferenceHip': evaluation.circumferenceHip,
      'highPressure': evaluation.highPressure ? 'sim' : 'não',
      'bloodPressure': evaluation.bloodPressure,
      'cholesterol': evaluation.cholesterol,
      'triglycerides':evaluation.triglycerides,
      'diabetic': evaluation.diabetic ? 'sim' : 'não',
      'glicemia': evaluation.glicemia,
      'reactiveProteinC': evaluation.reactiveProteinC,
      'imc': evaluation.imc

    }
  }));
  print(response.body);
}
