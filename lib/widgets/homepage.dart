import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synapserx_patient/services/auth_services.dart';
import 'package:synapserx_patient/widgets/synapsepxdrawer.dart';
import '../services/dio_client.dart';

final DioClient _dioClient = DioClient();

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  static String get routeName => 'home';
  static String get routeLocation => '/$routeName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final UserData userData = ref.watch(userDataProvider);
    return Scaffold(
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
                    const Text('userData.fullname')
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
                        await _dioClient.getProfile();
                      },
                      child: const Text('Get Profile'))
                ]),
          ],
        ),
      ),
    );
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
