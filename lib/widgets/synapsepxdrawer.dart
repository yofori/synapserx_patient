import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:synapserx_patient/main.dart';
import 'package:synapserx_patient/services/auth_services.dart';

import '../services/settings.dart';

class PxDrawer extends StatelessWidget {
  const PxDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: 200,
        child: ListView(children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('My Profile'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
              title: const Text('Sign out'),
              onTap: () async {
                await AuthService.signOut(context: context);
                GlobalData.fullname = '';
                Navigator.pop(scaffoldMessengerKey.currentContext!);
                //await FirebaseAuth.instance.signOut();
              }),
          const Divider(),
        ]));
  }
}
