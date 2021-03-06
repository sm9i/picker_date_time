library picker_date_time;

import 'package:flutter/material.dart';
import 'package:picker_date_time/src/route.dart';

import 'src/model.dart';
import 'src/route.dart';

export 'src/model.dart';
export 'src/picker_widget.dart';
export 'src/route.dart';

class Picker {
  const Picker._();

  //选择时间
  static Future<DateTime?> show(
    BuildContext context, {
    String? title,
    DateTime? max,
    DateTime? min,
    DateTime? current,
    List<DateType> types = const [
      DateType.Y,
      DateType.M,
      DateType.d,
      DateType.Y,
      DateType.H,
      DateType.m,
    ],
  }) {
    if (max != null && min != null) {
      assert(max.microsecondsSinceEpoch > min.microsecondsSinceEpoch);
    }

    return Navigator.push(
      context,
      new PickerRoute<DateTime>(
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        title: title,
        max: max,
        min: min,
        current: current,
        types: types,
      ),
    );
  }
}
