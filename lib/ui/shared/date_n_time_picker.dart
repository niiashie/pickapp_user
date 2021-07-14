import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateNTimePicker extends StatelessWidget {
  final String labelText;
  final DateTime initialValue;
  final void Function(DateTime value) onChanged;
  final FormFieldValidator<DateTime> validator;

  const DateNTimePicker({
    Key key,
    @required this.labelText,
    this.onChanged,
    this.initialValue,
    this.validator
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Theme.of(context).primaryColor,
      ),
      child: Builder(builder: (BuildContext context) {
        return DateTimeField(
          initialValue: initialValue,
          format: DateFormat("yyyy-MM-dd HH:mm"),
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
              /*borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.4),
              ),*/
            ),
            prefixIcon: Icon(Icons.date_range),
            contentPadding: EdgeInsets.symmetric(
              vertical: 18.0,
              horizontal: 10.0,
            ),
            focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.purple, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),

            ),
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
          onChanged: onChanged,
          validator: validator,
        );
      }),
    );
  }
}
