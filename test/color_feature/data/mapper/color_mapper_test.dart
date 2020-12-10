import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_color_project/features/color_feature/data/mapper/color_mapper.dart';

import '../../../fixture/fixture_reader.dart';

void main() {
  ColorMapper colorMapper;

  setUp(() {
    colorMapper = ColorMapper();
  });

  final tColor = Color.fromRGBO(174, 208, 148, 1);

  test('should return a valid [Color] from json', () {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(fixture('api_responce.json'));
    // act
    final result = colorMapper.fromJson(jsonMap);
    // assert
    expect(result, tColor);
  });
}
