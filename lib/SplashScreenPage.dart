// import 'dart:wasm';

import 'dart:async';

import 'package:clavis/HomePage.dart';
import 'package:clavis/MarketDashboardPage.dart';
import 'package:clavis/Model.dart';
import 'package:clavis/Repository.dart';
import 'package:clavis/WireTransferPage.dart';
import 'package:flutter/material.dart';
import 'package:clavis/API.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool isLibraReady = false;

  @override
  void initState() {
    super.initState();
    API.createWallet().then((Wallet wallet) {
      wallet.printStatus();
      Repository.initialize(wallet);
      setState(() {
        isLibraReady = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 1), () {
    //   Navigator.pushReplacement(
    //       context,
    //       PageTransition(
    //           child: MarketDashboardPage(),
    //           type: PageTransitionType.rightToLeft,
    //           duration: Duration(milliseconds: 200)));
    // });
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: MarketDashboardPage(),
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 200)));
    });
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Clavis',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            RaisedButton(
              child: Text('Libra'),
              onPressed: isLibraReady
                  ? () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: HomePage(),
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 200)));
                    }
                  : null,
            ),
            RaisedButton(
              child: Text('Binance Order Dashboard'),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: MarketDashboardPage(),
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 200)));
              },
            )
          ],
        ),
      ),
    );
  }
}
