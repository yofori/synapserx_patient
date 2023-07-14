import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
                Navigator.pop(context);
                await FirebaseAuth.instance.signOut();
              }),
          const Divider(),
        ]));
  }
}
