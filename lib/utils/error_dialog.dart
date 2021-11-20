import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

errorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/not_found.png",
              height: 150.0,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              message,
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Okay",
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
            ),
          ),
        ],
      );
    },
  );
}
