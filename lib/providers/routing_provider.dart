import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:synapserx_patient/pages/registeruser.dart';
import '../main.dart';
import '../pages/forgotpassword.dart';
import '../pages/landing.dart';
import '../pages/loginpage.dart';
import '../widgets/homepage.dart';
import '../widgets/myprescriptions.dart';
import 'auth_provider.dart';
import 'user_provider.dart';

final _key = GlobalKey<NavigatorState>();
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  final notifier = ref.watch(userDataProvider.notifier);
  return GoRouter(
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: SplashPage.routeLocation,
    routes: <RouteBase>[
      GoRoute(
        path: SplashPage.routeLocation,
        name: SplashPage.routeName,
        builder: (context, state) {
          return const SplashPage();
        },
      ),
      GoRoute(
          path: LoginPage.routeLocation,
          name: LoginPage.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
          routes: [
            GoRoute(
              path: RegisterUserPage.routeLocation,
              name: RegisterUserPage.routeName,
              builder: (context, state) {
                return const RegisterUserPage();
              },
            ),
            GoRoute(
              path: ForgottenPasswordPage.routeLocation,
              name: ForgottenPasswordPage.routeName,
              builder: (context, state) => const ForgottenPasswordPage(),
            ),
          ]),
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return LandingPage(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
                //navigatorKey: _shellNavigatorHomeKey,
                routes: <RouteBase>[
                  GoRoute(
                    path: HomePage.routeLocation,
                    name: HomePage.routeName,
                    pageBuilder: (context, state) => const NoTransitionPage(
                      child: HomePage(),
                    ),
                  )
                ]),
            StatefulShellBranch(
                //navigatorKey: _shellNavigatorPrescriptionsKey,
                routes: <RouteBase>[
                  GoRoute(
                    path: '/prescriptions',
                    pageBuilder: (context, state) => const NoTransitionPage(
                      child: MyPrescriptionsWidget(),
                    ),
                  )
                ])
          ])
    ],
    redirect: (context, state) {
      // If our async state is loading, don't perform redirects, yet
      if (authState.isLoading || authState.hasError) return null;

      // Here we guarantee that hasData == true, i.e. we have a readable value

      // This has to do with how the FirebaseAuth SDK handles the "log-in" state
      // Returning `null` means "we are not authorized"
      final isAuth = authState.valueOrNull != null;

      if (isAuth) {
        var user = FirebaseAuth.instance.currentUser;
        notifier.setFullname(user!.displayName.toString());
      }

      final isSplash = state.location == SplashPage.routeLocation;
      if (isSplash) {
        return isAuth ? HomePage.routeLocation : LoginPage.routeLocation;
      }

      final isLoggingIn = state.location == LoginPage.routeLocation;
      if (isLoggingIn) return isAuth ? HomePage.routeLocation : null;

      // return isAuth ? null : SplashPage.routeLocation;
      return null;
    },
  );
});
