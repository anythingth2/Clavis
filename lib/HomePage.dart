import 'package:clavis/ReceiveQRPage.dart';
import 'package:clavis/Repository.dart';
import 'package:clavis/API.dart';
import 'package:clavis/TransferQRPage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    API.updateBalance(Repository.wallet).then((_) {
      setState(() {
        Repository.wallet;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Clavis'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Address ${Repository.wallet.address}',
              style: TextStyle(
                fontSize: 18,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Balance ${Repository.wallet.balance} Libra',
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            MaterialButton(
              child: Text('Transfer'),
              color: Colors.cyan,
              onPressed: () {
                scanner.scan().then((qr) {
                  print('qr $qr');
                  Navigator.push(
                      context,
                      PageTransition(
                          child: TransferQRPage(toAddress: qr,),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200)));
                });
              },
            ),
            MaterialButton(
              child: Text('Receive'),
              color: Colors.cyan,
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: ReceiveQRPage(),
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
