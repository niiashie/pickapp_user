import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pickappuser/constants/utils.dart';

class DateTimePickerDialog extends StatefulWidget {
  final DateTime initalValue;
  DateTimePickerDialog({
    Key key,
    this.initalValue,
  }) : super(key: key);

  @override
  _DateTimePickerDialogState createState() => _DateTimePickerDialogState();
}

class _DateTimePickerDialogState extends State<DateTimePickerDialog> {
  final format = DateFormat("yyyy-MM-dd HH:mm");

  DateTime selectedDateTime;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Theme(
            data: Theme.of(context).copyWith(
              accentColor: Theme.of(context).primaryColor,
              buttonTheme: ButtonThemeData(
                colorScheme: ColorScheme.light(
                  primary: Theme.of(context).primaryColor,
                ),
              ),
            ),
            child: Builder(builder: (BuildContext context) {
              return DateTimeField(
                initialValue: widget.initalValue,
                format: format,
                decoration: InputDecoration(
                  labelText: "Select Date and Time",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)
                  ),
                  prefixIcon: Icon(Icons.date_range),
                ),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                        currentValue ?? DateTime.now(),
                      ),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
                onChanged: (selectedDate) {
                  selectedDateTime = selectedDate;
                },
              );
            }),
          ),
        ],
      ),
    );

    final cancelBtn = Expanded(
      child: MaterialButton(
        color: Colors.grey.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        onPressed: () => Navigator.pop(context, selectedDateTime),
        child: Container(
          // color: Colors.grey,
          child: Center(
            child: _buildButtonData(false, "Cancel"),
          ),
        ),
      ),
    );

    final okayBtn = Expanded(
      child: MaterialButton(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        onPressed: () => Navigator.pop(context, selectedDateTime),
        child: Container(
          child: Center(
            child: _buildButtonData(true, "Apply"),
          ),
        ),
      ),
    );

    final buttons = Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[cancelBtn, Utils.horizontalSpacer(), okayBtn],
      ),
    );

    return Container(
      height: 170.0,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[content, buttons],
      ),
    );
  }

  Widget _buildButtonData(bool isOkayBtn, String text) {
    final color = Colors.white;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        )
      ],
    );
  }
}
