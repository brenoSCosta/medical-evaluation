import 'package:avaliacao_medica/app/modules/evaluation/components/text_field_form.dart';
import 'package:avaliacao_medica/app/modules/evaluation/models/evaluation.dart';
import 'package:avaliacao_medica/app/modules/evaluation/services/decimalTextFormatter.dart';
import 'package:avaliacao_medica/app/modules/evaluation/services/send_email.dart';
import 'package:avaliacao_medica/app/styleguide/colors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:avaliacao_medica/app/modules/evaluation/evaluation_store.dart';
import 'package:flutter/material.dart';
import 'package:avaliacao_medica/app/styleguide/colors.dart' as colorsProject;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'components/button_rounded_custom.dart';

class EvaluationPage extends StatefulWidget {
  final String title;
  const EvaluationPage({Key? key, this.title = 'EvaluationPage'})
      : super(key: key);
  @override
  EvaluationPageState createState() => EvaluationPageState();
}

class EvaluationPageState extends State<EvaluationPage> {
  final EvaluationStore store = Modular.get();
  final _formKey = GlobalKey<FormState>();
  final _controllerDateNasc = TextEditingController();
  String _name = '';
  String _email = '';
  String? _tel = '';
  String? _selectedGender;

  String? _selectedRace;
  double _weight = 0.0;
  int _height = 0;
  int _circumferenceWaist = 0;
  int _circumferenceHip = 0;
  String? _selectedPressure;
  bool _boolPressure = true; //adianda arrumar
  double _bloodPressure = 0.0;
  double _cholesterol = 0;
  double _triglycerides = 0.0;
  String? _selectedDiabetic;
  bool _boolDiabetic = true; //adianda arrumar
  double _glicemia = 0.0;
  double _protein = 0.0;
  DateTime _dateNasc = DateTime(2000);

  final TextEditingController controllerTelefone = TextEditingController();
  String initialCountry = 'BR';
  PhoneNumber number = PhoneNumber(isoCode: 'BR');

  List listGenders = ['Masculino', 'Feminino'];
  List listRaces = ['Branco', 'Preto', 'Pardo', 'Amarelo', 'Ind??gena'];
  List _listYesNo = ['Sim', 'N??o'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro da Avalia????o', style: GoogleFonts.alegreya()),
        centerTitle: true,
        backgroundColor: colorsProject.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: backgroundColor),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  // Nome completo da pessoa
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: TextFieldForm(
                      hintText: 'Nome completo',
                      icone:
                          Icon(Icons.person, color: colorsProject.primaryColor),
                      onChange: (value) {
                        _name = value;
                      },
                      validador: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nome est?? vazio';
                        }
                        return null;
                      },
                      inputType: TextInputType.name,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.help),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO_REVERSED,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Nome',
                            desc: 'Insira seu nome completo',
                            btnOkColor: colorsProject.primaryColor,
                            btnOkOnPress: () {},
                          )..show();
                        },
                      ),
                    ),
                  ),
                  // Email
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: TextFieldForm(
                      hintText: 'Email',
                      icone: Icon(Icons.email_outlined,
                          color: colorsProject.primaryColor),
                      onChange: (value) {
                        _email = value;
                      },
                      validador: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email est?? vazio';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Email incorreto';
                        }
                        return null;
                      },
                      inputType: TextInputType.emailAddress,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.help),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO_REVERSED,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Email',
                            desc: 'Insira seu email',
                            btnOkColor: colorsProject.primaryColor,
                            btnOkOnPress: () {},
                          )..show();
                        },
                      ),
                    ),
                  ),
                  // Telefone
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        _tel = number.phoneNumber;
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'N??mero de telefone inv??lido';
                        }
                        return null;
                      },
                      ignoreBlank: true,
                      hintText: "Telefone",
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: controllerTelefone,
                      formatInput: true,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputBorder: OutlineInputBorder(),
                    ),
                  ),

                  // Data de nascimento utlizando do showDatePicker
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: TextFieldForm(
                      hintText: 'Data de nascimento',
                      icone: Icon(Icons.date_range,
                          color: colorsProject.primaryColor),
                      validador: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Data de nascimento est?? vazia';
                        }
                        return null;
                      },
                      inputType: TextInputType.datetime,
                      onTap: () {
                        showDatePicker(
                                //locale: const Locale('pt-br'),
                                context: context,
                                initialDate: DateTime(2000),
                                firstDate: DateTime(1890),
                                lastDate: DateTime(2222))
                            .then((value) {
                          if (value != null) {
                            _controllerDateNasc.text = value.day.toString() +
                                "/" +
                                value.month.toString() +
                                "/" +
                                value.year.toString();
                            _dateNasc = value;
                          }
                        });
                      },
                      controller: _controllerDateNasc,
                      readOnly: true,
                    ),
                  ),
                  // G??nero utlizando de DropdownButton para selecionar o desejado
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 30, 30),
                        child: Text(
                          'G??nero: ',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        width: 210,
                        child: DropdownButtonFormField<String>(
                          hint: Text('G??nero'),
                          isExpanded: true,
                          value: _selectedGender,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Selecione seu g??nero';
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              _selectedGender = newValue;
                            });
                          },
                          items: listGenders.map((valueItem) {
                            return DropdownMenuItem<String>(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  // Ra??a utlizando de DropdownButton para selecionar o desejado
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 45, 30),
                        child: Text(
                          'Ra??a: ',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        width: 210,
                        child: DropdownButtonFormField<String>(
                          hint: Text('Ra??a'),
                          value: _selectedRace,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Selecione sua ra??a';
                            }
                            return null;
                          },
                          isExpanded: true,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedRace = newValue;
                            });
                          },
                          items: listRaces.map((valueItem) {
                            return DropdownMenuItem<String>(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Peso em kg
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: TextFieldForm(
                      hintText: 'Peso (em kg)',
                      icone: Icon(Icons.accessibility,
                          color: colorsProject.primaryColor),
                      onChange: (value) {
                        if (value != '') {
                          _weight = double.parse(value);
                        }
                      },
                      inputFormatters: [DecimalTextInputFormatter()],
                      validador: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Peso est?? vazio, adicione seu peso em kg';
                        }
                        return null;
                      },
                      inputType: TextInputType.number,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.help),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO_REVERSED,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Peso',
                            desc: 'Insira seu peso (em kg)',
                            btnOkColor: colorsProject.primaryColor,
                            btnOkOnPress: () {},
                          )..show();
                        },
                      ),
                    ),
                  ),
                  // Altura em cm
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: TextFieldForm(
                      hintText: 'Altura (em cm)',
                      icone:
                          Icon(Icons.height, color: colorsProject.primaryColor),
                      onChange: (value) {
                        if (value != '') {
                          _height = int.parse(value);
                        }
                      },
                      validador: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Altura est?? vazio, adicione sua altura em cm';
                        } else if (int.parse(value) < 20) {
                          return 'Altura incorreta, adicione a altura em cm';
                        }
                        return null;
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      inputType: TextInputType.number,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.help),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO_REVERSED,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Altura',
                            desc: 'Insira sua altura (em cm)',
                            btnOkColor: colorsProject.primaryColor,
                            btnOkOnPress: () {},
                          )..show();
                        },
                      ),
                    ),
                  ),
                  // Circunfer??ncia da Cintura em cm
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: TextFieldForm(
                      hintText: 'Circunfer??ncia da Cintura',
                      icone: Icon(Icons.change_circle_rounded,
                          color: colorsProject.primaryColor),
                      onChange: (value) {
                        if (value != '') {
                          _circumferenceWaist = int.parse(value);
                        }
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validador: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Adicione circunfer??ncia da sua '
                              'cintura em cm';
                        }
                        return null;
                      },
                      inputType: TextInputType.number,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.help),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO_REVERSED,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Circunfer??ncia da Cintura (em cm)',
                            desc: 'A circunfer??ncia da cintura (em cm) ?? medida'
                                ' com fita m??trica no ponto mais estreito do meio do'
                                ' tronco na inspira????o m??xima',
                            btnOkOnPress: () {},
                            btnOkColor: colorsProject.primaryColor,
                          )..show();
                        },
                      ),
                    ),
                  ),
                  // Circunfer??ncia do Quadril
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: TextFieldForm(
                      hintText: 'Circunfer??ncia do Quadril',
                      icone: Icon(Icons.change_circle_outlined,
                          color: colorsProject.primaryColor),
                      onChange: (value) {
                        if (value != '') {
                          _circumferenceHip = int.parse(value);
                        }
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validador: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Adicione circunfer??ncia do quadril em cm';
                        }
                        return null;
                      },
                      inputType: TextInputType.number,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.help),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO_REVERSED,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Circunfer??ncia da Quadril (em cm)',
                            desc: 'A circunfer??ncia da Quadril (em cm) ??'
                                ' medida 25cm abaixo da cintura',
                            btnOkOnPress: () {},
                            btnOkColor: colorsProject.primaryColor,
                          )..show();
                        },
                      ),
                    ),
                  ),
                  // Press??o alta ( Sim / N??o)
                  Container(
                    margin: const EdgeInsets.all(30.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: colorsProject.primaryColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                            child: Text(
                              'Possui press??o alta (em uso ou n??o de medicamento)?',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: DropdownButtonFormField<String>(
                            hint: Text('Selecione'),
                            isExpanded: true,
                            value: _selectedPressure,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Selecione uma das op????es';
                              }
                              return null;
                            },
                            onChanged: (newValue) {
                              setState(() {
                                if (newValue == 'Sim') {
                                  _boolPressure = true;
                                } else {
                                  _boolPressure = false;
                                }
                                _selectedPressure = newValue;
                              });
                            },
                            items: _listYesNo.map((valueItem) {
                              return DropdownMenuItem<String>(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Press??o Arterial Sist??lica
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: TextFieldForm(
                      hintText: 'Press??o Arterial Sist??lica',
                      onChange: (value) {
                        if (value != '') {
                          _bloodPressure = double.parse(value);
                        }
                      },
                      inputFormatters: [DecimalTextInputFormatter()],
                      validador: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Adicione a press??o Arterial Sist??lica';
                        }
                        return null;
                      },
                      inputType: TextInputType.number,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.help),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO_REVERSED,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Press??o Arterial Sist??lica',
                            desc:
                                '?? o valor em mmHg mais alto da press??o arterial.'
                                ' Ex: se medir 145x100 mmHg o valor da PAS ?? 145.',
                            btnOkOnPress: () {},
                            btnOkColor: colorsProject.primaryColor,
                          )..show();
                        },
                      ),
                    ),
                  ),
                  // Valor do Colesterol HDL
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: TextFieldForm(
                      hintText: 'Valor do Colesterol HDL',
                      onChange: (value) {
                        if (value != '') {
                          _cholesterol = double.parse(value);
                        }
                      },
                      inputFormatters: [DecimalTextInputFormatter()],
                      validador: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Adicione o valor do colesterol HDL';
                        }
                        return null;
                      },
                      inputType: TextInputType.number,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.help),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO_REVERSED,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Valor do Colesterol HDL',
                            desc: 'Informe o valor do seu colesterol HDL',
                            btnOkOnPress: () {},
                            btnOkColor: colorsProject.primaryColor,
                          )..show();
                        },
                      ),
                    ),
                  ),
                  // Valor do Triglic??rides
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: TextFieldForm(
                      hintText: 'Valor do Triglic??rides',
                      onChange: (value) {
                        if (value != '') {
                          _triglycerides = double.parse(value);
                        }
                      },
                      inputFormatters: [DecimalTextInputFormatter()],
                      validador: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Adicione o valor do Triglic??rides';
                        }
                        return null;
                      },
                      inputType: TextInputType.number,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.help),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO_REVERSED,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Valor do Triglic??rides',
                            desc: 'Adicione o valor do Triglic??rides em mg/dl',
                            btnOkOnPress: () {},
                            btnOkColor: colorsProject.primaryColor,
                          )..show();
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(30.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: colorsProject.primaryColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                            child: Text(
                              '?? diab??tico (em uso ou n??o de medicamento)?',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: DropdownButtonFormField<String>(
                            hint: Text('Selecione'),
                            isExpanded: true,
                            value: _selectedDiabetic,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Selecione uma das op????es';
                              }
                              return null;
                            },
                            onChanged: (newValue) {
                              setState(() {
                                if (newValue == 'Sim') {
                                  _boolDiabetic = true;
                                } else {
                                  _boolDiabetic = false;
                                }
                                _selectedDiabetic = newValue;
                              });
                            },
                            items: _listYesNo.map((valueItem) {
                              return DropdownMenuItem<String>(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Valor da glicemia em Jejum
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: TextFieldForm(
                      hintText: 'Valor da Glicemia em Jejum',
                      onChange: (value) {
                        if (value != '') {
                          _glicemia = double.parse(value);
                        }
                      },
                      inputFormatters: [DecimalTextInputFormatter()],
                      validador: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Adicione Valor da Glicemia em Jejum';
                        }
                        return null;
                      },
                      inputType: TextInputType.number,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.help),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO_REVERSED,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Valor da Glicemia em Jejum',
                            desc:
                                'Adicione Valor da Glicemia em Jejum em mg/dL',
                            btnOkOnPress: () {},
                            btnOkColor: colorsProject.primaryColor,
                          )..show();
                        },
                      ),
                    ),
                  ),
                  // Valor da Prote??na C Reativa ultrassens??vel
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: TextFieldForm(
                      hintText: 'Valor da Prote??na C Reativa ultrassens??vel',
                      onChange: (value) {
                        if (value != '') {
                          _protein = double.parse(value);
                        }
                      },
                      inputFormatters: [DecimalTextInputFormatter()],
                      validador: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Adicione Valor da Prote??na C';
                        }
                        return null;
                      },
                      inputType: TextInputType.number,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.help),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO_REVERSED,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Valor da Prote??na C Reativa ultrassens??vel',
                            desc:
                                'Adicione valor da Prote??na C Reativa ultrassens??vel em mg/L',
                            btnOkOnPress: () {},
                            btnOkColor: colorsProject.primaryColor,
                          )..show();
                        },
                      ),
                    ),
                  ),
                  //Bot??o de confirma envio da avalia????o
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: ButtonRoundedCustom(
                      'Enviar avalia????o',
                      200,
                      60,
                      () {
                        if (_formKey.currentState!.validate()) {
                          Evaluation evalutionTemp = new Evaluation(
                            name: _name,
                            email: _email,
                            sms: _tel.toString(),
                            dateNasc: _dateNasc,
                            gender: _selectedGender.toString(),
                            race: _selectedRace.toString(),
                            weight: _weight,
                            height: _height,
                            circumferenceWaist: _circumferenceWaist,
                            circumferenceHip: _circumferenceHip,
                            highPressure: _boolPressure,
                            bloodPressure: _bloodPressure,
                            cholesterol: _cholesterol,
                            triglycerides: _triglycerides,
                            diabetic: _boolDiabetic,
                            glicemia: _glicemia,
                            reactiveProteinC: _protein,
                          );
                          evalutionTemp.calculateImc();
                          store.evaluationRepository
                              .addEvalution(evalutionTemp)
                              .then((value) {
                            if (value == 'sucess') {
                              sendEmail(evaluation: evalutionTemp);
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.SUCCES,
                                animType: AnimType.BOTTOMSLIDE,
                                title: 'Avalia????o registrada com sucesso',
                                desc:
                                    'Avalia????o enviada para o email do m??dico.'
                                    ' Verifique seu email para a confirma????o de envio',
                                btnOkColor: colorsProject.primaryColor,
                                btnOkOnPress: () {},
                              )..show();
                            } else {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.ERROR,
                                animType: AnimType.BOTTOMSLIDE,
                                title: 'O envio da avalia????o m??dica deu errado',
                                desc: 'Tente novamente mais tarde',
                                btnOkColor: colorsProject.primaryColor,
                                btnOkOnPress: () {},
                              )..show();
                            }
                          });
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Campos incorretos ou n??o preenchidos',
                            desc: 'Preencha os campos corretamente e'
                                ' tente novamente',
                            btnOkColor: colorsProject.primaryColor,
                            btnOkOnPress: () {},
                          )..show();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
