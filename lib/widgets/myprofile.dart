import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:synapserx_patient/pages/personalinformation.dart';
import 'package:synapserx_patient/widgets/custom_synapse_button.dart';

class MyProfileWidget extends StatefulWidget {
  const MyProfileWidget({Key? key}) : super(key: key);
  static String get routeName => 'profile';
  static String get routeLocation => '/$routeName';

  @override
  MyProfileWidgetState createState() => MyProfileWidgetState();
}

class MyProfileWidgetState extends State<MyProfileWidget> {
  @override
  Widget build(BuildContext context) {
    var buttonwidth = MediaQuery.of(context).size.width * 0.4;
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RxButton(
                        height: buttonwidth,
                        width: buttonwidth,
                        icon: Icons.person_3,
                        title: 'Personal Information',
                        onTap: () {
                          GoRouter.of(context)
                              .push(PersonalInfoPage.routeLocation);
                        }),
                    RxButton(
                        height: buttonwidth,
                        width: buttonwidth,
                        icon: Icons.payment,
                        title: 'Insurance Policies',
                        onTap: () {}),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
