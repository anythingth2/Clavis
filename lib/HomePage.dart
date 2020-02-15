import 'package:clavis/Repository.dart';
import 'package:clavis/API.dart';
import 'package:flutter/material.dart';

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
              onPressed: () {},
            ),
            MaterialButton(
              child: Text('Receive'),
              color: Colors.cyan,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
