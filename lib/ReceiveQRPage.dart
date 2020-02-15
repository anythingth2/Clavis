import 'package:clavis/Repository.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveQRPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receive'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImage(
              data: Repository.wallet.address,
              version: QrVersions.auto,
            ),
            Text(
              Repository.wallet.address,
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
