import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

abstract class LocalColorDataSource {
  Color getRandomColor();
}

class LocalColorDataSourceImpl extends LocalColorDataSource {
  @override
  Color getRandomColor() {
    int length = Colors.primaries.length;
    int random = Random().nextInt(length);

    return Colors.primaries[random];
  }
}
