import 'dart:collection';
import 'dart:ui';

abstract class PickerModel<T> {
  int getCurrentIndex(DateType t);

  List<T> getValues(DateType t);

  List<DateType> getKeys();

  void setCurrentIndex(DateType t, int index, VoidCallback onChange);

  void resetDayData();

  DateTime getDate();
}

class TimePickerModel extends PickerModel<int> {
  TimePickerModel({
    this.showVal,
    this.maxTime,
    this.minTime,
    this.currentTime,
  }) {
    initData();
  }

  final List<DateType> showVal;
  final DateTime maxTime;
  final DateTime minTime;
  final DateTime currentTime;

  final Map<DateType, List<int>> data = LinkedHashMap();

  final Map<DateType, int> current = new HashMap();

  void initData() {
    if (showVal.contains(DateType.Y)) {
      data[DateType.Y] = List.generate(maxTime.year - minTime.year + 1, (index) => minTime.year + index);
      current[DateType.Y] = data[DateType.Y].indexOf(currentTime.year);
    }

    if (showVal.contains(DateType.M)) {
      data[DateType.M] = List.generate(12, (index) => index + 1);
      current[DateType.M] = data[DateType.M].indexOf(currentTime.month);
    }

    if (showVal.contains(DateType.d)) {
      final timeDay = DateTime(currentTime.year, currentTime.month + 1, 0).day;
      data[DateType.d] = List.generate(timeDay, (index) => index + 1);

      current[DateType.d] = data[DateType.d].indexOf(currentTime.day);
    }

    if (showVal.contains(DateType.H)) {
      data[DateType.H] = List.generate(24, (index) => index + 1);
      current[DateType.H] = data[DateType.H].indexOf(currentTime.hour);
    }

    if (showVal.contains(DateType.m)) {
      data[DateType.m] = List.generate(60, (index) => index + 1);
      current[DateType.m] = data[DateType.m].indexOf(currentTime.minute);
    }

    if (showVal.contains(DateType.s)) {
      data[DateType.s] = List.generate(60, (index) => index + 1);
      current[DateType.s] = data[DateType.s].indexOf(currentTime.second);
    }
  }

  @override
  void setCurrentIndex(DateType t, int index, VoidCallback onChange) {
    current[t] = index;
    //判断是否有day的显示 并且修改了年月
    if (data.keys.contains(DateType.d) && (t == DateType.Y || t == DateType.M)) {
      final timeDay = DateTime(data[DateType.Y][current[DateType.Y]], data[DateType.M][current[DateType.M]] + 1, 0);

      if (timeDay.day != data[DateType.d].length) {
        data[DateType.d] = List.generate(timeDay.day, (index) => index + 1);
        onChange?.call();
      }
    }
  }

  @override
  int getCurrentIndex(DateType t) => current[t] ?? 0;

  @override
  List<int> getValues(DateType t) => data[t];

  @override
  List<DateType> getKeys() => data.keys.toList();

  @override
  void resetDayData() {}

  @override
  DateTime getDate() {
    final year = showVal.contains(DateType.Y) ? data[DateType.Y][current[DateType.Y]] : null;
    final month = showVal.contains(DateType.M) ? data[DateType.M][current[DateType.M]] : 0;
    final day = showVal.contains(DateType.d) ? data[DateType.d][current[DateType.d]] : null;
    final hours = showVal.contains(DateType.H) ? data[DateType.H][current[DateType.H]] : 0;
    final minute = showVal.contains(DateType.m) ? data[DateType.m][current[DateType.m]] : null;
    final second = showVal.contains(DateType.s) ? data[DateType.s][current[DateType.s]] : 0;
    return DateTime(year, month, day, hours, minute, second);
  }
}

enum DateType { Y, M, d, H, m, s }

const Map<DateType, String> typeText = {DateType.Y: '年', DateType.M: '月', DateType.d: '日', DateType.H: '时', DateType.m: '分', DateType.s: '秒'};
