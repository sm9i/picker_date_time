import 'dart:collection';
import 'dart:ui';

abstract class PickerModel<T> {
  int getCurrentIndex(TYPE t);

  List<T> getValues(TYPE t);

  List<TYPE> getKeys();

  void setCurrentIndex(TYPE t, int index);

  void resetDayData();
}

class TimePickerModel extends PickerModel<int> {
  TimePickerModel({
    List<TYPE> showVal = TYPE.values,
    this.maxTime,
    this.minTime,
    this.currentTime,
  }) {
    initData(showVal);
  }

  final DateTime maxTime;
  final DateTime minTime;
  final DateTime currentTime;

  final Map<TYPE, List<int>> data = LinkedHashMap();

  final Map<TYPE, int> current = new HashMap();

  void initData(List<TYPE> showVal) {
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
      final timeDay = DateTime(currentTime.year, currentTime.month, 0).day;
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
  void setCurrentIndex(TYPE t, int index) {
    current[t] = index;
    //设置完成后判断 day
    if (data.keys.contains(TYPE.d)) {
      final time = DateTime(data[TYPE.Y][current[TYPE.Y]]);
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
