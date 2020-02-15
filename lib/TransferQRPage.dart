import 'package:clavis/Repository.dart';
import 'package:flutter/material.dart';
import 'package:clavis/API.dart';

class TransferQRPage extends StatefulWidget {
  String toAddress;
  TransferQRPage({this.toAddress});
  @override
  _TransferQRPageState createState() => _TransferQRPageState();
}

class _TransferQRPageState extends State<TransferQRPage> {
  TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Transfer to ${widget.toAddress}',
              style: TextStyle(fontSize: 24),
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            MaterialButton(
              child: Text(
                'Send',
                style: TextStyle(fontSize: 24),
              ),
              color: Colors.blue,
              onPressed: () async {
                print(
                    'transfer to address: ${widget.toAddress}\tamount: ${amountController.text}');
                await API.transfer(
                    fromWallet: Repository.wallet,
                    toAddress: widget.toAddress,
                    amount: amountController.text);
                print('sented');
              },
            )
          ],
        ),
      ),
    );
  }
}
