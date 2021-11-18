import 'package:flutter/material.dart';
import 'package:zealth_ai_assign/models/pod_model.dart';

showPODDetailSheet(PODModel podModel, BuildContext context) async {
  await showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      context: context,
      elevation: 5.0,
      isScrollControlled: true,
      builder: (context) {
        final MediaQueryData mediaQueryData = MediaQuery.of(context);

        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Padding(
              padding: mediaQueryData.viewInsets,
              child: StatefulBuilder(
                builder: (BuildContext context, setState) => SingleChildScrollView(
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 8,
                              width: 48,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    podModel.title,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.clear))
                          ],
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text("Description", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(podModel.explanation),
                        SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          children: [
                            Text("On", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(podModel.date)
                          ],
                        ),
                        SizedBox(
                          height: 42.0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      });
}
