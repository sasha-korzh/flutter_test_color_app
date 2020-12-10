

import 'package:flutter/material.dart';

extension ColorHex on Color {
  
  static Color getFromHex(String hex) {
    final buffer = StringBuffer();

    if (hex.length == 6) {
      buffer.write('ff');
    }
    buffer.write(hex);

    final result = int.parse(buffer.toString(), radix: 16);
    return Color(result);
  }
}