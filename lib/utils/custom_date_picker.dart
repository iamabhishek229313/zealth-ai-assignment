import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<DateTime?> selectDate(BuildContext context, DateTime initialDate) async {
  return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
      builder: (context) {
        DateTime? newPickedValue = initialDate;
        return StatefulBuilder(
          builder: (BuildContext context, modalState) {
            return ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.33,
                width: double.maxFinite,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Hover date " + newPickedValue.toString().split(' ')[0],
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: CupertinoDatePicker(
                        initialDateTime: initialDate,
                        maximumDate: DateTime.now(),
                        maximumYear: DateTime.now().year,
                        minimumYear: 1996,
                        minimumDate: DateTime(1996),
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (newValue) {
                          modalState(() {
                            newPickedValue = newValue;
                          });
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Spacer(),
                        FlatButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Cancel",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18.0),
                            )),
                        SizedBox(
                          height: 28.0,
                          child: VerticalDivider(
                            color: Colors.blueGrey.shade100,
                          ),
                        ),
                        FlatButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop(newPickedValue);
                            },
                            child: Text(
                              "Done",
                              style: TextStyle(
                                  color: Colors.green, fontSize: 18.0),
                            )),
                        Spacer()
                      ],
                    ),
                    SizedBox(
                      height: 12.0,
                    )
                  ],
                ),
              ),
            );
          },
        );
      });
}
