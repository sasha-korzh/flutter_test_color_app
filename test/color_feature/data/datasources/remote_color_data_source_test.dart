import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test_color_project/core/error/exception.dart';
import 'package:test_color_project/features/color_feature/data/datasources/remote_color_data_source.dart';
import 'package:test_color_project/features/color_feature/data/mapper/color_mapper.dart';

import '../../../fixture/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  RemoteColorDataSourceImpl dataSourceImpl;
  MockHttpClient mockHttpClient;
  ColorMapper colorMapper;

  setUp(() {
    mockHttpClient = MockHttpClient();
    colorMapper = ColorMapper();
    dataSourceImpl = RemoteColorDataSourceImpl(
      client: mockHttpClient,
      colorMapper: colorMapper,
    );
  });

  void setUpMockHttpClientSuccess() {
    when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(fixture('api_responce.json'), 200));
  }

  void setUpMockHttpClientUnsuccess() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpMockHttpClientSuccessWithUncorrectJson() {
    when(mockHttpClient.get(any)).thenAnswer((_) async =>
        http.Response(fixture('api_not_correct_responce.json'), 200));
  }

  group('getRandomColor', () {
    final tColor = Color.fromRGBO(174, 208, 148, 1);

    test('''should perform a GET request on a URL with number
       being the endpoint and with application/json header''', () async {
      // arrange
      setUpMockHttpClientSuccess();
      // act
      dataSourceImpl.getRandomColor();
      // assert
      verify(mockHttpClient.get(
        urlColorApi,
      ));
    });

    test('should return [Color] when the responce code is 200', () async {
      // arrange
      setUpMockHttpClientSuccess();
      // act
      final result = await dataSourceImpl.getRandomColor();
      // assert
      expect(result, tColor);
    });

    test(
        'should throw a [NetworkException] when the responce code is 404 or other',
        () async {
      // arrange
      setUpMockHttpClientUnsuccess();
      // act
      final call = dataSourceImpl.getRandomColor;
      // assert
      expect(() => call(), throwsA(isInstanceOf<NetworkException>()));
    });

    test(
        'should throw a [JsonException] when the responce body has invalid json',
        () async {
      // arrange
      setUpMockHttpClientSuccessWithUncorrectJson();
      // act
      final call = dataSourceImpl.getRandomColor;
      // assert
      expect(() => call(), throwsA(isInstanceOf<JsonException>()));
    });
  });
}
