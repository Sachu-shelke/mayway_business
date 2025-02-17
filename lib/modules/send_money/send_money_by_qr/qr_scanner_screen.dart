import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mayway_business/config/routes/router_import.gr.dart';
import 'package:mayway_business/constants/method/common_method.dart';
import 'package:mayway_business/main.dart';
import 'package:mayway_business/widget/appbars/custom_app_bar.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

@RoutePage()
class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // Barcode? result;
  // QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      // controller!.pauseCamera();
    } else if (Platform.isIOS) {
      // controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Scan Mirror Qr',
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                  onTap: () async {
                    // await controller!.toggleFlash();
                  },
                  child: const Icon(Icons.flashlight_on_outlined)),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // QR Code Scanner
          // SizedBox(
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   child: QRView(
          //     key: qrKey,
          //     onQRViewCreated: _onQRViewCreated,
          //   ),
          // ),
          // Displaying a loading GIF or an overlay
          Center(child: Image.asset('assets/gif/qr_scanner.gif'))
        ],
      ),
    );
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     if (isValidPhoneNumber(scanData.code.toString())) {
  //       result = scanData;
  //       controller.pauseCamera();
  //       Navigator.pop(context);
  //       appRouter.push(
  //         SendMoneyScreenRoute(
  //             isFromEpin: "false", mobileNumber: result!.code.toString()),
  //       );
  //     } else {
  //       CommonMethod().dialogData(
  //           context: context,
  //           title: 'Error',
  //           errorMessage:
  //           'Invalid QR code, please scan mirror QR code or contact mirror support team.');
  //     }
  //   });
  // }

  bool isValidPhoneNumber(String phoneNumber) {
    const pattern = r'^[0-9]{10}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(phoneNumber);
  }

  @override
  void dispose() {
    // controller?.dispose();
    super.dispose();
  }
}

