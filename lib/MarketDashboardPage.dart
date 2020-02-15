import 'package:flutter/material.dart';

class MarketDashboardPage extends StatefulWidget {
  @override
  _MarketDashboardPageState createState() => _MarketDashboardPageState();
}

class _MarketDashboardPageState extends State<MarketDashboardPage> {
  TabController tabController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 64,
            ),
            CustomizedTabBar(
              names: ['Exchange', 'Market', 'Future'],
            ),
            TransactionTable(
              headers: ['Libra', 'Amount', 'Value'],
              rows: [
                ['123123', '321123', '132111'],
                ['112325', '432121', '113211'],
                ['121237', '823214', '453555'],
                ['123453', '363456', '553551'],
                ['123453', '363456', '553551'],
                ['123453', '363456', '553551'],
                ['123453', '363456', '553551'],
                ['123453', '363456', '553551'],
                ['123453', '363456', '553551'],
                ['123453', '363456', '553551'],
              ],
              footer: 'Footer',
            )
          ],
        ),
      ),
    );
  }
}

class CustomizedTabBar extends StatefulWidget {
  List<String> names;
  CustomizedTabBar({this.names});
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
    return TabBar(
        controller: tabController,
        indicator: BoxDecoration(color: Colors.blue),
        tabs: widget.names.map((name) => Text(name)).toList());
  }
}

class TransactionTable extends StatelessWidget {
  List<List> rows;
  List<String> headers;
  String footer;
  TransactionTable({this.rows, this.headers, this.footer});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: this.headers.map((header) => Text(header)).toList(),
          ),
          Container(
            height: 128,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: SingleChildScrollView(
              child: Column(
                children: this.rows.map<Widget>((row) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: row.map((cell) => Text(cell)).toList());
                }).toList(),
              ),
            ),
          ),
          if (footer != null)
            Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(border: Border.all(width: 1)),
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
