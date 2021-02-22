import 'package:flutter/material.dart';
import 'package:picker_date_time/src/model.dart';
import 'package:picker_date_time/src/picker_widget.dart';

class PickerRoute<T> extends PopupRoute<T> {
  PickerRoute({this.barrierLabel, this.title});

  @override
  Color get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  final String title;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget bottomSheet = new MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: PickerWidget(
        picker: TimePickerModel(
          maxTime: DateTime(2999),
          minTime: DateTime(2000),
          currentTime: DateTime.now(),
          showVal: [TYPE.Y, TYPE.m, TYPE.d, TYPE.H, TYPE.M],
        ),
        // onChanged: onChanged,
        // locale: this.locale,
        // route: this,
        // pickerModel: pickerModel,
        // title: title,
      ),
    );
    ThemeData inheritTheme = Theme.of(context, shadowThemeOnly: true);
    if (inheritTheme != null) {
      bottomSheet = new Theme(data: inheritTheme, child: bottomSheet);
    }
    return SlideTransition(
      position:
          Tween<Offset>(begin: Offset(0, 1.0), end: Offset(0.0, 0.0)).animate(
        CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
      ),
      child: bottomSheet,
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);
}
