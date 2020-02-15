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
}
