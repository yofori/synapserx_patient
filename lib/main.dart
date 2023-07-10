import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:synapserx_patient/pages/loginpage.dart';
import 'package:synapserx_patient/pages/registeruser.dart';
import 'package:synapserx_patient/widgets/homepage.dart';
import 'package:synapserx_patient/widgets/myprescriptions.dart';
import 'firebase_options.dart';
import 'pages/mainpage.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'Home');
final _shellNavigatorPrescriptionsKey =
    GlobalKey<NavigatorState>(debugLabel: 'Prescriptions');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.useAuthEmulator("10.0.2.2", 9099);
  runApp(const ProviderScope(child: MyApp()));
}

final GoRouter _router = GoRouter(
    initialLocation: '/login',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
          routes: [
            GoRoute(
              path: "register",
              builder: (context, state) => const RegisterUser(),
            ),
          ]),
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainPage(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(navigatorKey: _shellNavigatorHomeKey, routes: [
              GoRoute(
                path: '/home',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomePage(),
                ),
              )
            ]),
            StatefulShellBranch(
                navigatorKey: _shellNavigatorPrescriptionsKey,
                routes: [
                  GoRoute(
                    path: '/prescriptions',
                    pageBuilder: (context, state) => const NoTransitionPage(
                      child: MyPrescriptionsWidget(),
                    ),
                  )
                ])
          ])
    ]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'synapsePX',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}
