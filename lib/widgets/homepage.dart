import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:synapserx_patient/providers/userprofile_provider.dart';
import 'package:synapserx_patient/services/auth_services.dart';
import 'package:synapserx_patient/widgets/synapsepxdrawer.dart';
import '../services/dio_client.dart';
import '../services/settings.dart';

final DioClient _dioClient = DioClient();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String get routeName => 'home';
  static String get routeLocation => '/$routeName';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    checkIfProfileIsCreated();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        drawer: const PxDrawer(),
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: (BoxDecoration(
                    color: Colors.deepPurple[50],
                    border: Border.all(
                      color: Colors.deepPurple,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  )),
                  child: Column(children: [
                    Column(children: [
                      Text(
                        greeting(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // Consumer(builder: (context, ref, child) {
                      //   final fullname = ref.watch(setFullnameProvider);
                      //   return Text(fullname);
                      // }),
                      Text(GlobalData.fullname),
                    ]),
                  ])),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'What would you like to do?',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04),
                      //textAlign: TextAlign.left,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _dioClient.test();
                        },
                        child: const Text('Test')),
                    ElevatedButton(
                        onPressed: () async {
                          await AuthService().getFirebaseUID();
                        },
                        child: const Text('Get UID')),
                    ElevatedButton(
                        onPressed: () async {
                          await AuthService()
                              .getFirebaseIdToken()
                              .then((value) => print(value));
                        },
                        child: const Text('Get idToken')),
                    ElevatedButton(
                        onPressed: () async {
                          await _dioClient
                              .getProfile()
                              .then((value) => {print(value)});
                        },
                        child: const Text('Get Profile'))
                  ]),
            ],
          ),
        ),
      ),
    );
  }

  checkIfProfileIsCreated() async {
    final profile = await _dioClient.getProfile();
    setState(() {
      GlobalData.fullname = profile.fullname.toString();
    });

    if (profile.patientuid == null) {
      if (mounted) {
        context.go('/createprofile');
      }
    }
  }
}

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  }
  if (hour < 17) {
    return 'Good Afternoon';
  }
  return 'Good Evening';
}
