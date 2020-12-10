import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_color_project/features/color_feature/data/datasources/local_color_data_source.dart';

void main() {
  LocalColorDataSourceImpl dataSourceImpl;

  setUp(() {
    dataSourceImpl = LocalColorDataSourceImpl();
  });

  test('should return random [Color] from Color.primaries', () {
    // arrange
    // act
    final result = dataSourceImpl.getRandomColor();
    final actualContains = Colors.primaries.contains(result);
    // assert
    expect(actualContains, true);
  });
}
