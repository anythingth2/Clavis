import 'package:flutter/material.dart';
import 'dart:async';
import 'package:clavis/API.dart';

class MarketDashboardPage extends StatefulWidget {
  @override
  _MarketDashboardPageState createState() => _MarketDashboardPageState();
}

class _MarketDashboardPageState extends State<MarketDashboardPage> {
  TabController tabController;

  List<List<String>> bids = [];
  List<List<String>> asks = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 500), (_) async {
      List _bids = await API.getOrder();
      List _asks = await API.getOrderAsk();
      setState(() {
        bids = _bids;
        asks = _asks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomizedTabBar(
          names: ['Exchange', 'Market', 'Future'],
          unselectedColor: Colors.grey[300],
          fontSize: 24,
        ),
        backgroundColor: Colors.green[800],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: CustomizedTabBar(
                    names: ['Open Order', 'Chart'],
                    selectIndex: 0,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'BTC / LIBRA',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Text(
                        '+0.99%',
                        style: TextStyle(
                            color: Colors.white,
                            backgroundColor: Colors.green,
                            fontSize: 14),
                      ),
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  child: RaisedButton(
                    child: Text('Buy Order'),
                    color: Colors.lightGreen,
                    onPressed: () {},
                  ),
                ),
                RaisedButton(
                  child: Text('Sell Order'),
                  onPressed: () {},
                )
              ],
            ),
            TransactionTable(
              headers: ['BTC', 'Amount', 'Price'],
              rows: bids,
              footer: bids.first.first.substring(0, 7),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Sell Order',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
            TransactionTable(headers: ['BTC', 'Amount', 'Price'], rows: asks),
          ],
        ),
      ),
    );
  }
}

class CustomizedTabBar extends StatefulWidget {
  List<String> names;
  int selectIndex;
  Color unselectedColor;
  double fontSize;
  CustomizedTabBar(
      {this.names,
      this.selectIndex = 0,
      this.unselectedColor = Colors.black,
      this.fontSize = 16});
  @override
  _CustomizedTabBarState createState() => _CustomizedTabBarState();
}

class _CustomizedTabBarState extends State<CustomizedTabBar>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // return TabBar(
    //     controller: tabController,
    //     indicator: BoxDecoration(color: Colors.blue),
    //     tabs: widget.names.map((name) => Text(name)).toList());
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(
          widget.names.length,
          ((i) => Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        widget.names[i],
                        style: TextStyle(
                            fontSize: widget.fontSize,
                            fontWeight: FontWeight.bold,
                            color: i == widget.selectIndex
                                ? Colors.green
                                : widget.unselectedColor),
                      )),
                  Container(
                    height: 4,
                    width: 60,
                    color: i == widget.selectIndex
                        ? Colors.green
                        : Colors.transparent,
                  )
                ],
              ))).toList(),
    );
  }
}

class TransactionTable extends StatelessWidget {
  List<List> rows;
  List<String> headers;
  String footer;
  TransactionTable({this.rows, this.headers, this.footer});
  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.grey[400];

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: this
                  .headers
                  .map((header) => Text(
                        header,
                        style: TextStyle(color: Colors.grey[800], fontSize: 12),
                      ))
                  .toList(),
            ),
          ),
          Container(
            height: 128,
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: borderColor)),
            child: SingleChildScrollView(
              child: Column(
                children: this.rows.map<Widget>((row) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: row.map((cell) {
                        String value = cell as String;
                        int fixLength = 7;
                        if (value.length < fixLength)
                          value = value.padRight(fixLength - value.length, '0');
                        else
                          value = value.substring(0, fixLength);
                        return Text(
                          value,
                          style: TextStyle(fontSize: 14),
                        );
                      }).toList());
                }).toList(),
              ),
            ),
          ),
          if (footer != null)
            Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1, color: borderColor),
                        right: BorderSide(width: 1, color: borderColor),
                        bottom: BorderSide(width: 1, color: borderColor))),
                child: Text(footer))
          else
            Container()
        ],
      ),
    );
  }
}

class OrderTable extends StatelessWidget {
  List<List> rows;
  OrderTable({this.rows});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: TransactionTable(
        rows: this.rows,
      ),
    );
  }
}

class MarketTradeTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
