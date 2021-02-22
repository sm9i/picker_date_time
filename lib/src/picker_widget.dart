import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picker_date_time/src/model.dart';

class PickerWidget extends StatefulWidget {
  const PickerWidget({Key key, this.picker, this.title}) : super(key: key);
  final PickerModel picker;
  final String title;

  @override
  _PickerWidgetState createState() => _PickerWidgetState();
}

class _PickerWidgetState extends State<PickerWidget> {
  Map<DateType, FixedExtentScrollController> controllers = {};

  @override
  void initState() {
    widget.picker.getKeys().forEach((element) {
      controllers[element] = FixedExtentScrollController(initialItem: widget.picker.getCurrentIndex(element));
    });
    super.initState();
  }

  @override
  void dispose() {
    controllers.values.forEach((element) => element?.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 300,
        color: Colors.red,
        child: Material(
          child: Column(
            children: [
              buildTitle(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: widget.picker.getKeys().map((key) => buildColumnItem(key)).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildColumnItem(DateType key) {
    final data = widget.picker.getValues(key);
    final controller = controllers[key];
    return Expanded(
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (ScrollEndNotification notification) {
          widget.picker.setCurrentIndex(
            key,
            controller.selectedItem,
            () {
              controllers[DateType.d] = FixedExtentScrollController(initialItem: widget.picker.getCurrentIndex(DateType.d));
              setState(() {});
            },
          );

          return false;
        },
        child: CupertinoPicker.builder(
          key: ValueKey(controllers[key]),
          scrollController: controller,
          itemExtent: 36,
          itemBuilder: (context, index) {
            return Center(
              child: Text(
                '${data[index]}${buildText(key)}',
                style: TextStyle(fontSize: 15),
              ),
            );
          },
          childCount: data.length,
          onSelectedItemChanged: (int value) {},
        ),
      ),
    );
  }

  Widget buildTitle() {
    return Row(
      children: <Widget>[
        TextButton(
          onPressed: () {},
          child: Text(
            '取消',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        Expanded(
          child: widget.title != null
              ? Center(
                  child: Text(
                    widget.title ?? '',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )
              : SizedBox(),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, widget.picker.getDate());
          },
          child: Text(
            '确定',
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }

  String buildText(DateType t) => typeText[t];
}
