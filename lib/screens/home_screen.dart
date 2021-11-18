import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zealth_ai_assign/blocs/selected_day_bloc/selected_day_bloc.dart';
import 'package:zealth_ai_assign/blocs/theme_bloc/theme_bloc.dart';
import 'package:zealth_ai_assign/models/pod_model.dart';
import 'package:zealth_ai_assign/screens/view_pic_of_the_day_screen.dart';
import 'package:zealth_ai_assign/services/authentication_services/authentication_services.dart';
import 'package:zealth_ai_assign/services/nasa_api_services/nasa_api_services.dart';
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
            appBar: AppBar(),
            drawer: SafeArea(
                child: Drawer(
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                    currentAccountPicture:
                        CircleAvatar(backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser?.photoURL ?? "")),
                    accountName: Text(FirebaseAuth.instance.currentUser?.displayName ?? "Undefined Name"),
                    accountEmail: Text(FirebaseAuth.instance.currentUser?.email ?? "Undefined email"),
                  ),
                  Column(
                    children: [
                      Divider(height: 0.0),
                      ListTile(
                          onTap: () {
                            // Navigator.of(context).push(route)
                          },
                          dense: true,
                          title: Text("Profile Screen"),
                          subtitle: Text("View Profile"),
                          trailing: Icon(Icons.person_outline_outlined)),
                      Divider(height: 0.0),
                      ListTile(
                        onTap: () {
                          AuthenticationServices.signOut();
                        },
                        dense: true,
                        title: Text("Log out"),
                        subtitle: Text("Log out from this device."),
                        trailing: Icon(Icons.logout_outlined),
                      ),
                      Divider(height: 0.0),
                      ListTile(
                          onTap: () {
                            AuthenticationServices.signOut();
                          },
                          dense: true,
                          title: Text("Dark"),
                          subtitle: Text("Enable/Disable dark mode"),
                          trailing: BlocConsumer<ThemeBloc, ThemeState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return Switch(
                                  value: state.themeMode == ThemeMode.dark,
                                  onChanged: (newVal) {
                                    BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(newVal));
                                  });
                            },
                          )),
                    ],
                  )
                ],
              ),
            )),
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
                                width: 16.0,
                              ),
                              Text(selectedDateState.toString(), style: TextStyle(color: Colors.white))
                            ],
                          ),
                          SizedBox(height: 16.0),
                          OutlinedButton(
                            onPressed: () async {
                              final pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDateState,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now());

                              if (pickedDate != null)
                                BlocProvider.of<SelectedDateBloc>(context).add(ChangeSelectedDateEvent(pickedDate));
                            },
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
