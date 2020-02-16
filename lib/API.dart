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

  static Future<List<List<String>>> getOrder() async {
    Response res = await client
        .get('https://api.binance.com/api/v3/depth?symbol=BTCUSDT&limit=10');
    List bids = res.data['bids'];
    return bids
        .map<List<String>>((row) => [
              row[0],
              row[1],
              (double.parse(row[0]) * double.parse(row[1])).toString()
            ])
        .toList();
  }

  static Future<List<List<String>>> getOrderAsk() async {
    Response res = await client
        .get('https://api.binance.com/api/v3/depth?symbol=BTCUSDT&limit=10');
    List bids = res.data['asks'];
    return bids
        .map<List<String>>((row) => [
              row[0],
              row[1],
              (double.parse(row[0]) * double.parse(row[1])).toString()
            ])
        .toList();
  }

}
