// import 'dart:wasm';

import 'package:clavis/Model.dart';
import 'package:clavis/Repository.dart';
import 'package:flutter/material.dart';
import 'package:clavis/API.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    API.createWallet().then((Wallet wallet) {
      wallet.printStatus();
      Repository.initialize(wallet);
    });
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text(
          'Clavis',
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
