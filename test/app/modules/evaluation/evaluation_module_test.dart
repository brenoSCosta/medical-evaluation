import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:avaliacao_medica/app/modules/evaluation/evaluation_module.dart';

void main() {
  setUpAll(() {
    initModule(EvaluationModule());
  });
}
/*

void main() {
  late EvaluationStore store;

  setUpAll(() {
    store = EvaluationStore();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
*/