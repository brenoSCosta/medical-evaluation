import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class Evaluation {
  String name;
  String email;
  String sms;
  DateTime dateNasc;
  String gender;
  String race;
  double weight;
  int height;
  int circumferenceWaist;
  int circumferenceHip;
  bool highPressure;
  double bloodPressure;
  double cholesterol;
  double triglycerides;
  bool diabetic;
  double glicemia;
  double reactiveProteinC;
  double imc;

  Evaluation({
    required this.name,
    required this.email,
    required this.sms,
    required this.dateNasc,
    required this.gender,
    required this.race,
    required this.weight,
    required this.height,
    required this.circumferenceWaist,
    required this.circumferenceHip,
    required this.highPressure,
    required this.bloodPressure,
    required this.cholesterol,
    required this.triglycerides,
    required this.diabetic,
    required this.glicemia,
    required this.reactiveProteinC,
    this.imc = 0.0,
  });

  double calculateImc() {
    double value = this.weight / pow(this.height / 100, 2);
    this.imc = value;
    return imc;
  }

  factory Evaluation.fromDocument(DocumentSnapshot doc) {
    return Evaluation(
        name: doc['name'],
        email: doc['email'],
        sms: doc['sms'],
        dateNasc: doc['date_nasc'],
        gender: doc['gender'],
        race: doc['race'],
        weight: doc['weight'],
        height: doc['height'],
        circumferenceWaist: doc['circumference_waist'],
        circumferenceHip: doc['circumference_hip'],
        highPressure: doc['high_pressure'],
        bloodPressure: doc['blood_pressure'],
        cholesterol: doc['cholesterol'],
        triglycerides: doc['triglycerides'],
        diabetic: doc['diabetic'],
        glicemia: doc['glicemia'],
        reactiveProteinC: doc['reactive_protein_c'],
        imc: doc['imc']);
  }

  toJson() {
    return {
      "name": this.name,
      "email": this.email,
      "sms": this.sms,
      "date_nasc": this.dateNasc,
      "gender": this.gender,
      "race": this.race,
      "weight": this.weight,
      "height": this.height,
      "circumference_waist": this.circumferenceWaist,
      "circumference_hip": this.circumferenceHip,
      "high_pressure": this.highPressure,
      "blood_pressure": this.bloodPressure,
      "cholesterol": this.cholesterol,
      "triglycerides": this.triglycerides,
      "diabetic": this.diabetic,
      "glicemia": this.glicemia,
      "reactive_protein_c": this.reactiveProteinC,
      "imc": this.imc
    };
  }

  @override
  String toString() {
    return this.name;
  }
}
