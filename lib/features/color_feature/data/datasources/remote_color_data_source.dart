import 'dart:convert';
import 'dart:ui';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:test_color_project/core/error/exception.dart';
import 'package:test_color_project/features/color_feature/data/mapper/color_mapper.dart';
import 'package:test_color_project/core/util/string_extension.dart';

abstract class RemoteColorDataSource {
  Future<Color> getRandomColor();
}

const urlColorApi = 'http://www.colr.org/json/color/random';

class RemoteColorDataSourceImpl extends RemoteColorDataSource {
  final http.Client client;
  final ColorMapper colorMapper;

  RemoteColorDataSourceImpl({
    @required this.client,
    @required this.colorMapper,
  });

  @override
  Future<Color> getRandomColor() async {
    final responce = await client.get(urlColorApi);

    if (responce.statusCode == 200) {
      if (responce.body.isValideJson) {
        return colorMapper.fromJson(json.decode(responce.body));
      } else {
        throw JsonException();
      }
    } else {
      throw NetworkException();
    }
  }
}
