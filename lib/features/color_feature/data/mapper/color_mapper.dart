import 'dart:ui';

import 'package:test_color_project/core/util/color_extension.dart';

class ColorMapper {
  Color fromJson(Map<String, dynamic> jsonMap) {
    final hexString = jsonMap['new_color'];
    return ColorHex.getFromHex(hexString);
  }
}
