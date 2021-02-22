import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picker_date_time/src/model.dart';

class PickerWidget extends StatefulWidget {
  const PickerWidget({Key key, this.picker}) : super(key: key);
  final PickerModel picker;

  @override
  _PickerWidgetState createState() => _PickerWidgetState();
}

class _PickerWidgetState extends State<PickerWidget> {
  Map<TYPE, FixedExtentScrollController> controllers = {};

  @override
  void initState() {
    widget.picker.getKeys().forEach((element) {
      controllers[element] = FixedExtentScrollController(
          initialItem: widget.picker.getCurrentIndex(element));
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
                    children: widget.picker
                        .getKeys()
                        .map((key) => buildColumnItem(key))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildColumnItem(TYPE key) {
    final data = widget.picker.getValues(key);
    final controller = controllers[key];
    return Expanded(
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (ScrollEndNotification notification) {
          debugPrint('current selected index:${controller.selectedItem}');
          widget.picker.setCurrentIndex(key, controller.selectedItem);
          return false;
        },
        child: CupertinoPicker.builder(
          scrollController: controller,
          itemExtent: 36,
          itemBuilder: (context, index) {
            return Center(
              child: Text(
                data[index],
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
        Spacer(),
        TextButton(
          onPressed: () {},
          child: Text(
            '确定',
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }

  
  String buildText(TYPE t){

  }
  
}
