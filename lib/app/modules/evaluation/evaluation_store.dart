import 'package:avaliacao_medica/app/modules/evaluation/repositories/evaluation_repository_interface.dart';
import 'package:flutter_triple/flutter_triple.dart';

class EvaluationStore extends NotifierStore<Exception, int> {
  final IEvaluationRepository evaluationRepository;
  EvaluationStore(this.evaluationRepository) : super(0);
}
