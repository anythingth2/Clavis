class Wallet {
  String address;
  String mnemonic;
  String balance;

  Wallet({this.address, this.mnemonic, this.balance});
  Wallet.fromJSON(Map<String, dynamic> walletJson) {
    this.address = walletJson['address'];
    this.mnemonic = walletJson['mnemonic'];
    this.balance = walletJson['balance'];
  }

  void updateBalance(String balance) => this.balance = balance;
  void printStatus() {
    print('address: $address\tmnemonic: $mnemonic\tbalance: $balance');
  }
}
