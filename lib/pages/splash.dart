import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/user_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});
  static String get routeName => 'splash';
  static String get routeLocation => '/$routeName';

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  void getLoginUserDisplayName() async {
    final notifier = ref.watch(userDataProvider.notifier);
    User? userCred = FirebaseAuth.instance.currentUser;
    if (userCred != null) {
      notifier.setFullname(userCred.displayName.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (mounted) {
        context.go('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getLoginUserDisplayName();
    return const Scaffold(
      body: Center(child: Text("Splash Page")),
    );
  }
}
