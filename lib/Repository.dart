import 'package:clavis/Model.dart';

class Repository {
  static Wallet wallet;
  static void initialize(Wallet _wallet) {
    wallet = _wallet;
  }
}
