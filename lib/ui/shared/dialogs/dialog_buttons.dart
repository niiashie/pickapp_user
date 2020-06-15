import 'package:flutter/material.dart';

class DialogButtons extends StatelessWidget {
  final double height;
  final String okayText;
  final String cancelText;
  final bool showOkayBtn;
  final bool showCancelBtn;
  final VoidCallback onOkayButtonPressed;
  final VoidCallback onCancelButtonPressed;
  final Color color;

  const DialogButtons({
    Key key,
    this.height,
    this.okayText = "OK",
    this.cancelText = "CANCEL",
    this.onOkayButtonPressed,
    this.onCancelButtonPressed,
    this.color,
    this.showOkayBtn = true,
    this.showCancelBtn = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Row(
        mainAxisAlignment: mainAxisAlignment(),
        children: <Widget>[
          cancelBtn(context),
          okayBtn(context),
        ],
      ),
    );
  }

  MainAxisAlignment mainAxisAlignment() {
    if (showOkayBtn && showCancelBtn) {
      return MainAxisAlignment.spaceBetween;
    } else {
      return MainAxisAlignment.center;
    }
  }

  Widget okayBtn(context) {
    final _okayBtn = MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: color == null ? Theme.of(context).primaryColor : color,
      onPressed: onOkayButtonPressed,
      child: Container(
        child: Center(
          child: _buildButtonData(true, okayText),
        ),
      ),
    );

    if (showOkayBtn && showCancelBtn) {
      return Expanded(child: _okayBtn);
    } else if (showOkayBtn && !showCancelBtn) {
      return _okayBtn;
    } else {
      return Container();
    }
  }

  Widget cancelBtn(context) {
    final _cancelBtn = GestureDetector(
      onTap: onCancelButtonPressed,
      child: Container(
        // color: Colors.grey,
        child: Center(
          child: _buildButtonData(false, cancelText),
        ),
      ),
    );

    if (showOkayBtn && showCancelBtn) {
      return Expanded(child: _cancelBtn);
    } else if (showCancelBtn && !showOkayBtn) {
      return _cancelBtn;
    } else {
      return Container();
    }
  }

  Widget _buildButtonData(bool isOkayBtn, String text) {
    final color = isOkayBtn ? Colors.white : Colors.grey;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        )
      ],
    );
  }
}
