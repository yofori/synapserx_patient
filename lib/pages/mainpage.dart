import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:synapserx_patient/widgets/scaffoldwithnavigationbar.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('MainPage'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithNavigationBar(
        body: navigationShell,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch);
  }
}
