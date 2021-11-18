import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zealth_ai_assign/blocs/selected_day_bloc/selected_day_bloc.dart';
import 'package:zealth_ai_assign/blocs/theme_bloc/theme_bloc.dart';
import 'package:zealth_ai_assign/models/pod_model.dart';
import 'package:zealth_ai_assign/services/nasa_api_services/nasa_api_services.dart';
import 'package:zealth_ai_assign/utils/error_dialog.dart';

class ViewPODScreen extends StatefulWidget {
  PODModel podModel;

  ViewPODScreen({Key? key, required this.podModel}) : super(key: key);

  @override
  _ViewPODScreenState createState() => _ViewPODScreenState();
}

class _ViewPODScreenState extends State<ViewPODScreen> {
  _setNewPODData(DateTime newDate) async {
    PODModel? newPODdata;
    try {
      newPODdata = await NasaAPIServices().getPOD(newDate);
      log("newwest : " + newPODdata.toJson().toString());
    } catch (ex) {
      newPODdata = null;
      log("Caught exception : " + ex.toString());
      errorDialog(context, "Couldn't do this.");
    }
    setState(() {
      if (newPODdata != null) {
        widget.podModel = newPODdata;
        BlocProvider.of<SelectedDateBloc>(context).add(ChangeSelectedDateEvent(newDate));
      }
      log("changed version : " + widget.podModel.toJson().toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        await _setNewPODData(DateTime(2000));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Picture of the day"),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_rounded)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                showSheet(widget.podModel, context);
              },
              mini: true,
              child: Icon(
                Icons.arrow_upward_outlined,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              "More details",
              style: TextStyle(
                  fontSize: 12.0,
                  color: (BlocProvider.of<ThemeBloc>(context).state.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black)),
            )
          ],
        ),
        body: SafeArea(
          child: GestureDetector(
            onLongPress: () async {
              final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: BlocProvider.of<SelectedDateBloc>(context).state,
                  firstDate: DateTime(1966),
                  lastDate: DateTime.now());

              if (pickedDate != null) {
                await _setNewPODData(pickedDate);
              }
            },
            child: Container(
              constraints: BoxConstraints.expand(),
              width: screenWidth,
              color: Colors.transparent,
              child: InteractiveViewer(
                panEnabled: false, // Set it to false
                boundaryMargin: EdgeInsets.zero,
                minScale: 0.1,
                maxScale: 2,
                scaleEnabled: true,
                child: CachedNetworkImage(
                  key: Key(widget.podModel.hdurl),
                  imageUrl: widget.podModel.hdurl,
                  fit: BoxFit.contain,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(child: CupertinoActivityIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

showSheet(PODModel podModel, BuildContext context) async {
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
