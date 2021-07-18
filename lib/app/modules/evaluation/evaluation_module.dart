import 'package:avaliacao_medica/app/modules/evaluation/evaluation_Page.dart';
import 'package:avaliacao_medica/app/modules/evaluation/evaluation_store.dart';
import 'package:avaliacao_medica/app/modules/evaluation/repositories/evaluation_repository.dart';
import 'package:avaliacao_medica/app/modules/evaluation/repositories/evaluation_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EvaluationModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => EvaluationStore(i.get())),
    Bind.lazySingleton<IEvaluationRepository>(
        (i) => EvaluationRepository(FirebaseFirestore.instance)),
    //Bind.instance(colorsProject.listColors)
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => EvaluationPage()),
    ChildRoute('/', child: (_, args) => EvaluationPage()),
  ];
}
