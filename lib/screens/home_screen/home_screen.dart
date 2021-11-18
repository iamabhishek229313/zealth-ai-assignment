import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zealth_ai_assign/blocs/selected_day_bloc/selected_day_bloc.dart';
import 'package:zealth_ai_assign/models/pod_model.dart';
import 'package:zealth_ai_assign/screens/home_screen/drawer.dart';
import 'package:zealth_ai_assign/screens/view_pod/view_pod_screen.dart';
import 'package:zealth_ai_assign/services/nasa_api_services/nasa_api_services.dart';
import 'package:zealth_ai_assign/utils/custom_date_picker.dart';
import 'package:zealth_ai_assign/utils/error_dialog.dart';
import 'package:zealth_ai_assign/utils/weekdays_color_getter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectedDateBloc, DateTime>(
      listener: (context, state) {},
      builder: (context, selectedDateState) {
        return Scaffold(
            backgroundColor: getColor(selectedDateState),
            appBar: AppBar(
              title: Text("Zealth-AI"),
            ),
            drawer: CustomDrawer(),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: selectedDateState.weekday == DateTime.tuesday ? Colors.white12 : Colors.black87,
                      borderRadius: BorderRadius.circular(9)),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Selected Date : ",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(selectedDateState.toString().split(' ')[0],
                                  style: TextStyle(
                                      color: Colors.indigoAccent, fontWeight: FontWeight.bold, fontSize: 18.0))
                            ],
                          ),
                          SizedBox(height: 16.0),
                          OutlinedButton(
                            onPressed: () async {
                              final pickedDate = await selectDate(context, selectedDateState);
                              if (pickedDate != null)
                                BlocProvider.of<SelectedDateBloc>(context).add(ChangeSelectedDateEvent(pickedDate));
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(width: 1.0, color: Colors.orange),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Select other date"), Icon(Icons.date_range_outlined)],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                          onPressed: () async {
                            /// [Call the NASA API]
                            PODModel podModel;
                            try {
                              podModel =
                                  await NasaAPIServices().getPOD(BlocProvider.of<SelectedDateBloc>(context).state);
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) => ViewPODScreen(podModel: podModel)));
                            } catch (ex) {
                              errorDialog(context, "Couldn't do this");
                              log("Expection faced : " + ex.toString());
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Show"),
                              Icon(Icons.arrow_forward),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
