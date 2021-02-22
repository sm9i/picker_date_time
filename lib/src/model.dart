import 'dart:collection';
import 'dart:ui';

abstract class PickerModel<T> {
  int getCurrentIndex(TYPE t);

  List<T> getValues(TYPE t);

  List<TYPE> getKeys();

  void setCurrentIndex(TYPE t, int index,VoidCallback onChange);

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

  final List<TYPE> showVal;
  final DateTime maxTime;
  final DateTime minTime;
  final DateTime currentTime;

  final Map<TYPE, List<int>> data = LinkedHashMap();

  final Map<TYPE, int> current = new HashMap();

  void initData() {
    if (showVal.contains(TYPE.Y)) {
      data[TYPE.Y] = List.generate(
          maxTime.year - minTime.year + 1, (index) => minTime.year + index);
      current[TYPE.Y] = data[TYPE.Y].indexOf(currentTime.year);
    }

    if (showVal.contains(TYPE.M)) {
      data[TYPE.M] = List.generate(12, (index) => index + 1);
      current[TYPE.M] = data[TYPE.M].indexOf(currentTime.month);
    }

    if (showVal.contains(TYPE.d)) {
      final timeDay = DateTime(currentTime.year, currentTime.month + 1, 0).day;
      data[TYPE.d] = List.generate(timeDay, (index) => index + 1);

      current[TYPE.d] = data[TYPE.d].indexOf(currentTime.day);
    }

    if (showVal.contains(TYPE.H)) {
      data[TYPE.H] = List.generate(24, (index) => index + 1);
      current[TYPE.H] = data[TYPE.H].indexOf(currentTime.hour);
    }

    if (showVal.contains(TYPE.m)) {
      data[TYPE.m] = List.generate(60, (index) => index + 1);
      current[TYPE.m] = data[TYPE.m].indexOf(currentTime.minute);
    }

    if (showVal.contains(TYPE.s)) {
      data[TYPE.s] = List.generate(60, (index) => index + 1);
      current[TYPE.s] = data[TYPE.s].indexOf(currentTime.second);
    }
  }

  @override
  void setCurrentIndex(TYPE t, int index,VoidCallback onChange) {
    current[t] = index;
    //判断是否有day的显示 并且修改了年月
    if (data.keys.contains(TYPE.d) && (t == TYPE.Y || t == TYPE.M)) {
      final timeDay = DateTime(
          data[TYPE.Y][current[TYPE.Y]], data[TYPE.M][current[TYPE.M]]+1, 0);


      if (timeDay.day != data[TYPE.d].length) {
        data[TYPE.d] = List.generate(timeDay.day, (index) => index + 1);
        onChange?.call();
      }
    }
  }

  @override
  int getCurrentIndex(TYPE t) => current[t] ?? 0;

  @override
  List<int> getValues(TYPE t) => data[t];

  @override
  List<TYPE> getKeys() => data.keys.toList();

  @override
  void resetDayData() {}

  @override
  DateTime getDate() {
    final year =
        showVal.contains(TYPE.Y) ? data[TYPE.Y][current[TYPE.Y]] : null;
    final month = showVal.contains(TYPE.M) ? data[TYPE.M][current[TYPE.M]] : 0;
    final day = showVal.contains(TYPE.d) ? data[TYPE.d][current[TYPE.d]] : null;
    final hours = showVal.contains(TYPE.H) ? data[TYPE.H][current[TYPE.H]] : 0;
    final minute =
        showVal.contains(TYPE.m) ? data[TYPE.m][current[TYPE.m]] : null;
    final second = showVal.contains(TYPE.s) ? data[TYPE.s][current[TYPE.s]] : 0;
    return DateTime(year, month, day, hours, minute, second);
  }
}

enum TYPE { Y, M, d, H, m, s }

const Map<TYPE, String> typeText = {
  TYPE.Y: '年',
  TYPE.M: '月',
  TYPE.d: '日',
  TYPE.H: '时',
  TYPE.m: '分',
  TYPE.s: '秒'
};
