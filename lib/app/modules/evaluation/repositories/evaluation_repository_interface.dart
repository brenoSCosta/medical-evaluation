import 'package:avaliacao_medica/app/modules/evaluation/models/evaluation.dart';

abstract class IEvaluationRepository {
  Future<String> addEvalution(Evaluation evalution);
}
