
import 'dart:convert';

extension StringValidation on String {

  bool get isValideJson {

    if (this.isEmpty) {
      return false;
    }

    Map<String, dynamic> jsonMap = json.decode(this);
    final String newColorValue = jsonMap['new_color'];

    if (newColorValue.isEmpty) {
      return false;
    }

    return true;
  }

}