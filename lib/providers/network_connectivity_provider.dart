import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ConnectivityStatus { notDetermined, isConnected, isDisonnected }

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
  StreamController<ConnectivityResult> controller =
      StreamController<ConnectivityResult>();

  ConnectivityStatus? lastResult;
  ConnectivityStatus? newState;

  ConnectivityStatusNotifier() : super(ConnectivityStatus.isConnected) {
    if (state == ConnectivityStatus.isConnected) {
      lastResult = ConnectivityStatus.isConnected;
    } else {
      lastResult = ConnectivityStatus.isDisonnected;
    }
    lastResult = ConnectivityStatus.notDetermined;
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      switch (result) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
        case ConnectivityResult.ethernet:
        case ConnectivityResult.vpn:
          {
            try {
              final result = await InternetAddress.lookup('api.synapserx.com');
              if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                newState = ConnectivityStatus.isConnected;
                await Fluttertoast.showToast(
                    toastLength: Toast.LENGTH_SHORT,
                    msg: 'You are back onine',
                    backgroundColor: Colors.green);
              } else {
                newState = ConnectivityStatus.isDisonnected;
                await Fluttertoast.showToast(
                    toastLength: Toast.LENGTH_SHORT,
                    msg: 'Disconnected, only cached data will be shown',
                    backgroundColor: Colors.red);
              }
            } on SocketException catch (_) {
              newState = ConnectivityStatus.isDisonnected;
              await Fluttertoast.showToast(
                  toastLength: Toast.LENGTH_SHORT,
                  msg: 'Socket Error, unable to connect',
                  backgroundColor: Colors.red);
            }
          }
          break;
        case ConnectivityResult.none:
        case ConnectivityResult.bluetooth:
        case ConnectivityResult.other:
          newState = ConnectivityStatus.isDisonnected;
          break;
      }
      if (newState != lastResult) {
        state = newState!;
        lastResult = newState;
      }
    });
  }
}

final connectivityStatusProviders = StateNotifierProvider((ref) {
  return ConnectivityStatusNotifier();
});
