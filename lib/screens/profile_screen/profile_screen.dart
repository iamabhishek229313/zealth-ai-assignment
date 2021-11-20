import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zealth_ai_assign/blocs/selected_day_bloc/selected_day_bloc.dart';
import 'package:zealth_ai_assign/constants/local_storage_constants.dart';
import 'package:zealth_ai_assign/utils/error_dialog.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _mobileNumberController;
  late TextEditingController _githubLinkController;

  late FocusNode _mobileFocus;
  late FocusNode _githubLinkFocus;
  bool _mobileEdit = false;
  bool _githubLinkEdit = false;

  bool _first = true;

  @override
  void initState() {
    super.initState();
    _mobileFocus = FocusNode();
    _githubLinkFocus = FocusNode();
    _mobileNumberController = TextEditingController();
    _githubLinkController = TextEditingController();
  }

  Future<SharedPreferences> _getPrefs() async {
    log("PREFS :: ");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_first) {
      _mobileNumberController.text = _prefs.getString(LocalStorageConstants.mobileNumber) ?? "";
      _githubLinkController.text = _prefs.getString(LocalStorageConstants.githubLink) ?? "";
    }
    _first = false;
    return _prefs;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    var profileInfo = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
            radius: screenWidth * 0.13,
            backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser?.photoURL ?? "")),
        SizedBox(height: screenHeight * 0.01),
        Text(
          FirebaseAuth.instance.currentUser?.displayName ?? "No Name",
          style: TextStyle(fontSize: 24.0),
        ),
        Text(
          FirebaseAuth.instance.currentUser?.email ?? "Not provided",
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(
          height: screenHeight * 0.05,
        )
      ],
    );

    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () {
          BlocProvider.of<SelectedDateBloc>(context).add(SelectedDateChanged(DateTime(2000)));
        },
        child: Container(
          height: screenHeight * 0.065,
          width: screenWidth,
          color: Colors.red.shade700,
          child: Center(
            child: Text(
              "Reset",
              style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: _getPrefs(),
        builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData == false)
            return Center(
              child: CupertinoActivityIndicator(),
            );
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            child: SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  profileInfo,
                  Column(
                    children: [
                      TextField(
                        focusNode: _mobileFocus,
                        controller: _mobileNumberController..text,
                        enabled: _mobileEdit,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mobile Number',
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            child: Text("Edit"),
                            onPressed: () {
                              FocusScope.of(context).requestFocus(_mobileFocus);
                              setState(() {
                                _mobileEdit = true;
                              });
                            },
                            style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                          ),
                          TextButton(
                            child: Text(
                              "Save",
                              style: TextStyle(color: Colors.green.shade700),
                            ),
                            onPressed: () {
                              setState(() {
                                _first = false;
                                snapshot.data!
                                    .setString(LocalStorageConstants.mobileNumber, _mobileNumberController.text);
                              });
                            },
                            style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Column(
                    children: [
                      TextField(
                        focusNode: _githubLinkFocus,
                        controller: _githubLinkController,
                        enabled: _githubLinkEdit,
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Github Link',
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            child: Text("Edit"),
                            onPressed: () {
                              FocusScope.of(context).requestFocus(_githubLinkFocus);
                              setState(() {
                                _githubLinkEdit = true;
                              });
                            },
                            style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                          ),
                          TextButton(
                            child: Text(
                              "Save",
                              style: TextStyle(color: Colors.green.shade700),
                            ),
                            onPressed: () {
                              setState(() {
                                _first = false;
                                snapshot.data!.setString(LocalStorageConstants.githubLink, _githubLinkController.text);
                              });
                            },
                            style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                          ),
                          Spacer(),
                          TextButton(
                            child: Text(
                              "Open",
                              style: TextStyle(color: Colors.indigoAccent),
                            ),
                            onPressed: () async {
                              String url = snapshot.data!.getString(LocalStorageConstants.githubLink) ?? "";
                              await canLaunch(url) ? await launch(url) : errorDialog(context, "Could not launch $url");
                            },
                            style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
