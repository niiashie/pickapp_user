import 'package:flutter/material.dart';
import 'package:pickappuser/ui/shared/dialogs/custom_alert.dialog.dart';
import 'package:pickappuser/ui/shared/dialogs/date_time_picker.dialog.dart';


enum AlertDialogType { success, error, warning, custom }

class DialogService {
  Future<DateTime> showAlertDialog({
    @required BuildContext context,
    @required String message,
    @required AlertDialogType type,
    String title,
    String okayText = "OK",
    String cancelText = "CANCEL",
    bool showCancelBtn = true,
    bool showOkayBtn = true,
    VoidCallback onOkayBtnTap,
    VoidCallback onCancelBtnTap,
  }) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: CustomAlertDialog(
            message: message,
            type: type,
            title: title,
            okayText: okayText,
            cancelText: cancelText,
            showCancelBtn: showCancelBtn,
            showOkayBtn: showOkayBtn,
            onOkayBtnTap: onOkayBtnTap,
            onCancelBtnTap: onCancelBtnTap,
          ),
        );
      },
    );
  }

  Future<DateTime> showDateTimePicker({
    @required BuildContext context,
    DateTime initalValue,
  }) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: DateTimePickerDialog(initalValue: initalValue),
        );
      },
    );
  }

  Future<dynamic> showCustomDialog({
    @required BuildContext context,
    @required Widget customDialog,
    bool barrierDismissible = true,
  }) {
    return showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: customDialog,
        );
      },
    );
  }
}
