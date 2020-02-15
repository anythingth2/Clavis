import 'dart:ffi';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';

class WireTransferPage extends StatefulWidget {
  @override
  _WireTransferPageState createState() => _WireTransferPageState();
}

class _WireTransferPageState extends State<WireTransferPage> {
  double exchangeRate = 213.123;
  String note = '';
  TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    noteController = TextEditingController(text: '');
    noteController.addListener(() {
      setState(() {
        note = noteController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextPrice(
                      label: 'Buying Power',
                      price: 1234.12345,
                      currency: 'THB',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextPrice(
                      label: 'Destination Available',
                      price: 30.85154134,
                      currency: 'USD',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: CurrencyField(
                      currencies: ['THB', 'USD'],
                      onChange: (selected, amount, selectedCurrency) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: CurrencyField(
                      currencies: ['THB', 'USD'],
                    ),
                  ),
                  Text(
                    exchangeRate.toString(),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              'Note',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${note.length} / 40',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8),
                      child: Text(
                        'CONFIRM',
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                    shape: Border.all(
                      width: 1,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextPrice extends StatelessWidget {
  String label, currency;
  double price;

  final double _fontSize = 16;
  TextPrice({this.label, this.price, this.currency});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            this.label,
            style: TextStyle(fontSize: _fontSize),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  this.price.toString(),
                  style: TextStyle(
                      fontSize: _fontSize, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                this.currency,
                style: TextStyle(fontSize: _fontSize),
              )
            ],
          )
        ],
      ),
    );
  }
}

typedef CurrencyFieldOnChange(
    bool selected, double amount, String selectedCurrency);

class CurrencyField extends StatefulWidget {
  List<String> currencies;
  CurrencyFieldOnChange onChange;
  CurrencyField({this.currencies, this.onChange});
  @override
  _CurrencyFieldState createState() => _CurrencyFieldState();
}

class _CurrencyFieldState extends State<CurrencyField> {
  bool _selected = false;
  double _amount;

  String selectedCurrency;

  TextEditingController amountController;
  @override
  void initState() {
    super.initState();
    selectedCurrency = widget.currencies[0];
    amountController = TextEditingController(text: '');
    amountController.addListener(() {
      _amount = double.tryParse(amountController.text);
      notify();
    });
  }

  void notify() {
    print(
        'selected: $_selected\tamount: $_amount\tselectedCurrency: $selectedCurrency');
    if (widget.onChange != null)
      widget.onChange(_selected, _amount, selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularCheckBox(
              value: _selected,
              onChanged: (v) {
                setState(() {
                  _selected = v;
                  notify();
                });
              }),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: DropdownButton(
              items: widget.currencies
                  .map<DropdownMenuItem>((currency) => DropdownMenuItem(
                        child: Container(
                          child: Text(currency),
                        ),
                        value: currency,
                      ))
                  .toList(),
              value: selectedCurrency,
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value;
                  notify();
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
