import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:synapserx_patient/pages/myqrcodepage.dart';
import 'package:synapserx_patient/pages/registeruser.dart';
import '../pages/forgotpassword.dart';
import '../pages/insurancepage.dart';
import '../pages/landing.dart';
import '../pages/loginpage.dart';
import '../pages/personalinformation.dart';
import '../pages/splash.dart';
import '../widgets/homepage.dart';
import '../widgets/myprescriptions.dart';
import '../widgets/myprofile.dart';
import 'auth_provider.dart';

final _key = GlobalKey<NavigatorState>();
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
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
        path: PersonalInfoPage.routeLocation,
        name: PersonalInfoPage.routeName,
        builder: (context, state) {
          return const PersonalInfoPage();
        },
      ),
      GoRoute(
        path: InsurancePage.routeLocation,
        name: InsurancePage.routeName,
        builder: (context, state) {
          return InsurancePage();
        },
      ),
      GoRoute(
        path: QRPage.routeLocation,
        name: QRPage.routeName,
        builder: (context, state) {
          return const QRPage();
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
              builder: (BuildContext context, GoRouterState state) {
                return const RegisterUserPage();
              },
            ),
            GoRoute(
              path: ForgottenPasswordPage.routeLocation,
              name: ForgottenPasswordPage.routeName,
              builder: (BuildContext context, GoRouterState state) =>
                  const ForgottenPasswordPage(),
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
                ]),
            StatefulShellBranch(
                //navigatorKey: _shellNavigatorPrescriptionsKey,
                routes: <RouteBase>[
                  GoRoute(
                    path: '/profile',
                    pageBuilder: (context, state) => const NoTransitionPage(
                      child: MyProfileWidget(),
                    ),
                  )
                ])
          ])
    ],
    redirect: (context, state) {
      // // If our async state is loading, don't perform redirects, yet
      if (authState.isLoading || authState.hasError) return null;
      final isAuth = authState.valueOrNull != null;
      final isSplash = state.location == SplashPage.routeLocation;
      final isLoggingIn = state.location == LoginPage.routeLocation;
      final isPasswordReset =
          state.location == ForgottenPasswordPage.routeLocation;
      final isSignup = state.location == RegisterUserPage.routeLocation;
      final isHomePage = state.location == HomePage.routeLocation;
      if (isSplash) {
        return null;
      } else if (isAuth && isLoggingIn) {
        return HomePage.routeLocation;
      } else if (isLoggingIn && isAuth) {
        return HomePage.routeLocation;
      } else if (isLoggingIn || isSignup || isPasswordReset && !isAuth) {
        return null;
      } else if (isHomePage && !isAuth) {
        return LoginPage.routeLocation;
      }
    },
  );
});
