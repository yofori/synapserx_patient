import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InsurancePage extends ConsumerWidget {
  InsurancePage({super.key});

  static String get routeName => 'insurance';
  static String get routeLocation => '/$routeName';
  final TextEditingController _firstnameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance Policies'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _firstnameController,
          ),
          ElevatedButton(onPressed: () {}, child: Text('Change Me'))
        ],
      ),
    );
  }
}
