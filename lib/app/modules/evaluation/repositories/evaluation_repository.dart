import 'package:avaliacao_medica/app/modules/evaluation/models/evaluation.dart';
import 'package:avaliacao_medica/app/modules/evaluation/repositories/evaluation_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EvaluationRepository implements IEvaluationRepository {
  final FirebaseFirestore firestore;

  EvaluationRepository(this.firestore);

  //Adicionar avaliação no banco
  @override
  Future<String> addEvalution(Evaluation evalution) async {
    Map<String, dynamic> tempJsonEval = evalution.toJson();
    try {
      await firestore
          .collection('evalutions')
          .doc()
          .set(tempJsonEval)
          .then((value) {
        return value;
      });
    } catch (error) {
      return error.toString();
    }

    return 'sucess';
  }
}
