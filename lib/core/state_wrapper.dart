import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:zealth_ai_assign/screens/auth/authentication_screen.dart';
import 'package:zealth_ai_assign/screens/home_screen/home_screen.dart';
import 'package:zealth_ai_assign/utils/network_error_dialog.dart';

class StateWrapper extends StatefulWidget {
  const StateWrapper({Key? key}) : super(key: key);

  @override
  _StateWrapperState createState() => _StateWrapperState();
}

class _StateWrapperState extends State<StateWrapper> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      if (_connectionStatus.index == 3) {
        showNetworkErrorDailog(context);
      }
      log(_connectionStatus.index.toString() + " : " + _connectionStatus.toString());
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return ProgressHUD(
      barrierColor: Colors.black54,
      backgroundColor: Colors.white,
      indicatorWidget: CircularProgressIndicator(),
      child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == null)
                return AuthenticationScreen();
              else
                return HomeScreen();
            }
            return AuthenticationScreen();
          }),
    );
  }
}
