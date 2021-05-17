import 'package:flutter/material.dart';
import 'package:picker_date_time/src/model.dart';
import 'package:picker_date_time/src/picker_widget.dart';

import 'model.dart';
import 'model.dart';

class PickerRoute<T> extends PopupRoute<T> {
  PickerRoute({
    required this.barrierLabel,
    required this.title,
    required this.max,
    required this.min,
    required this.current,
    this.types = DateType.values,
  });

  @override
  Color get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  final String? title;

  final DateTime? max;
  final DateTime? min;
  final DateTime? current;
  final List<DateType> types;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    Widget bottomSheet = new MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: PickerWidget(
        title: title,
        picker: TimePickerModel(
          maxTime: max ?? DateTime(2999),
          minTime: min ?? DateTime(2000),
          currentTime: current ?? DateTime.now(),
          showVal: types,
        ),
        // onChanged: onChanged,
        // locale: this.locale,
        // route: this,
        // pickerModel: pickerModel,
        // title: title,
      ),
    );
    ThemeData inheritTheme = Theme.of(context);
    if (inheritTheme != null) {
      bottomSheet = new Theme(data: inheritTheme, child: bottomSheet);
    }
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(0, 1.0), end: Offset(0.0, 0.0)).animate(
        CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
      ),
      child: bottomSheet,
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);
}
