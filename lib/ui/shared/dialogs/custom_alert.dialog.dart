import 'package:flutter/material.dart';
import 'package:pickappuser/services/dialog.service.dart';
import 'dialog_buttons.dart';

class CustomAlertDialog extends StatelessWidget {
  final AlertDialogType type;
  final String title;
  final String message;
  final String okayText;
  final String cancelText;
  final bool showCancelBtn;
  final bool showOkayBtn;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onOkayBtnTap;
  final VoidCallback onCancelBtnTap;

  const CustomAlertDialog({
    Key key,
    @required this.type,
    this.title,
    @required this.message,
    this.okayText,
    this.cancelText,
    this.showCancelBtn,
    this.showOkayBtn,
    this.icon,
    this.iconColor,
    this.onOkayBtnTap,
    this.onCancelBtnTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final top = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Color(0xFF515C6F),
      ),
      height: 150,
      child: Center(
        child: Icon(
          _chooseIcon(),
          color: _chooseColor(),
          size: 90.0,
        ),
      ),
    );

    final title = Text(
      _chooseTitle(),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 24.0,
        color: Colors.black.withOpacity(0.7),
      ),
    );

    final content = Expanded(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10.0),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.withOpacity(0.7),
                ),
              )
            ],
          ),
        ),
      ),
    );

    final buttons = Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.only(bottom: 10),
      child: DialogButtons(
        okayText: okayText,
        cancelText: cancelText,
        onOkayButtonPressed:
            onOkayBtnTap != null ? onOkayBtnTap : () => pop(context),
        onCancelButtonPressed:
            onCancelBtnTap != null ? onCancelBtnTap : () => pop(context),
        showCancelBtn: showCancelBtn,
        showOkayBtn: showOkayBtn,
      ),
    );

    return Container(
      height: 350.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          top,
          title,
          content,
          // Utils.verticalSpacer(),
          buttons,
        ],
      ),
    );
  }

  Color _chooseColor() {
    if (iconColor == null) {
      if (type == AlertDialogType.success) {
        return Colors.green;
      } else if (type == AlertDialogType.error) {
        return Colors.red;
      } else {
        return Colors.orange;
      }
    } else {
      return iconColor;
    }
  }

  String _chooseTitle() {
    if (title == null) {
      if (type == AlertDialogType.success) {
        return "Success!!!";
      } else if (type == AlertDialogType.error) {
        return "Error!!!";
      } else {
        return "Warning!!!";
      }
    } else {
      return title;
    }
  }

  IconData _chooseIcon() {
    if (icon == null) {
      if (type == AlertDialogType.success) {
        return Icons.check_circle_outline;
      } else if (type == AlertDialogType.error) {
        return Icons.error_outline;
      } else {
        return Icons.info_outline;
      }
    } else {
      return icon;
    }
  }

  void pop(context) {
    Navigator.of(context).pop();
  }
}
