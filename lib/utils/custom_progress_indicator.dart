import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CustomProgressIndicatorDialog {
  ProgressDialog customProgressIndicator(BuildContext context) {
    final ProgressDialog pr = ProgressDialog(context);
    pr.style(
        message: 'Downloading file...',
        borderRadius: 10.0,
        child: CupertinoActivityIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        textAlign: TextAlign.left,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    return pr;
  }
}
