import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:synapserx_patient/widgets/qr_overlay.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({super.key, required this.title});
  final String title;
  static String get routeName => 'barcodescanner';
  static String get routeLocation => routeName;

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: Stack(children: [
        MobileScanner(
          controller: cameraController,
          onDetect: (captured) {
            //cameraController.stop();
            Navigator.pop(context, captured.barcodes.first.rawValue);
          },
        ),
        QRScannerOverlay(
          overlayColour: Colors.black.withOpacity(0.5),
          onScanButtonTap: () {
            cameraController.start();
          },
        ),
      ]),
    );
  }
}
