import 'package:flutter_test/flutter_test.dart';

import '../../fixture/fixture_reader.dart';
import 'package:test_color_project/core/util/string_extension.dart';

main() {
  test('should return true when string is valid json', () {
    // arrange
    final String jsonString = fixture('api_responce.json');
    // act
    final result = jsonString.isValideJson;
    // assert
    expect(result, true);
  });

  test('should return false when string is not valid json', () {
    // arrange
    final String jsonString = fixture('api_not_correct_responce.json');
    // act
    final result = jsonString.isValideJson;
    // assert
    expect(result, false);
  });
}
