import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodeScreen extends StatelessWidget {
  const ScanCodeScreen({Key? key}) : super(key: key);

  static const path = "scan-code";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 20,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded),
              ),
            ),
            // MobileScanner(
            //   allowDuplicates: false,
            //   onDetect: (barcode, args) {
            //     // TODO: make request to add to team
            //     Navigator.pop(context);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
