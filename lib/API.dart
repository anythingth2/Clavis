import 'package:clavis/Model.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class API {
  static Dio client = Dio();

  static Future<Wallet> createWallet() async {
    Response res =
        await client.post('https://libraservice3.kulap.io/createWallet');
    return Wallet.fromJSON(res.data);
  }

  static Future<void> updateBalance(Wallet wallet) async {
    Response res = await client.post(
        'https://libraservice2.kulap.io/getBalance',
        data: {'address': wallet.address});
    wallet.updateBalance(res.data['balance']);
  }

  static Future<void> transfer(
      {Wallet fromWallet, String toAddress, String amount}) async {
    Response res =
        await client.post('https://libraservice3.kulap.io/transfer', data: {
      'fromAddress': fromWallet.address,
      'mnemonic': fromWallet.mnemonic,
      'toAddress': toAddress,
      'amount': amount
    });
    
  }
}
