import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zealth_ai_assign/blocs/theme_bloc/theme_bloc.dart';
import 'package:zealth_ai_assign/screens/profile_screen/profile_screen.dart';
import 'package:zealth_ai_assign/services/authentication_services/authentication_services.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    FirebaseAuth.instance.currentUser?.photoURL ?? "")),
            accountName: Text(FirebaseAuth.instance.currentUser?.displayName ??
                "Undefined Name"),
            accountEmail: Text(
                FirebaseAuth.instance.currentUser?.email ?? "Undefined email"),
          ),
          _itemList(context)
        ],
      ),
    ));
  }

  Column _itemList(BuildContext context) {
    return Column(
      children: [
        Divider(height: 0.0),
        ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ProfileScreen()));
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
            title: Text("Dark Mode"),
            subtitle: Text("Enable/Disable dark mode"),
            trailing: BlocConsumer<ThemeBloc, ThemeState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Switch(
                    value: state.themeMode == ThemeMode.dark,
                    onChanged: (newVal) {
                      BlocProvider.of<ThemeBloc>(context)
                          .add(ThemeChanged(newVal));
                    });
              },
            )),
      ],
    );
  }
}
