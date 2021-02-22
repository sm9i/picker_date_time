library picker_date_time;

import 'package:flutter/material.dart';
import 'package:picker_date_time/src/route.dart';

class Picker {
  Future<T> show<T>(BuildContext context) {
    return Navigator.push(
      context,
      new PickerRoute<T>(
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
      ),
    );
  }
}
