library picker_date_time;

import 'package:flutter/material.dart';
import 'package:picker_date_time/src/route.dart';

class Picker {
  void show(BuildContext context) {
    Navigator.push(
      context,
      new PickerRoute(
          MaterialLocalizations.of(context).modalBarrierDismissLabel),
    );
  }
}
