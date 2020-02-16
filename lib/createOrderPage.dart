import 'package:flutter/material.dart';

class createOrderPage extends StatefulWidget {
  @override
  _createOrderPageState createState() => _createOrderPageState();
}

class _createOrderPageState extends State<createOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),body:
      leftElement(),

    );
  }
}

class leftElement extends StatefulWidget {
  @override
  _leftElementState createState() => _leftElementState();
}

class _leftElementState extends State<leftElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      Column(
      children:[
        textFieldRow(),
        textFieldRow(),
        percentButtonRow(),
      ],
    ),
    );
  }
}


class percentButtonRow extends StatefulWidget {
  @override
  _percentButtonRowState createState() => _percentButtonRowState();
}

class _percentButtonRowState extends State<percentButtonRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child:
            SizedBox(
                width: 70.0,
                height: 30.0,
                child:
                OutlineButton(
                  color: Colors.white,
                  textColor: Colors.black,
                  disabledBorderColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  //padding: EdgeInsets.all(5.0),
                  splashColor: Colors.blueAccent,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                  onPressed: () {
                    /*...*/
                  },
                  child: Text(
                    "75%",
                    style: TextStyle(fontSize: 10.0),
                  ),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child:
            SizedBox(
                width: 70.0,
                height: 30.0,
                child:
                OutlineButton(
                  color: Colors.white,
                  textColor: Colors.black,
                  disabledBorderColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  //padding: EdgeInsets.all(5.0),
                  splashColor: Colors.blueAccent,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                  onPressed: () {
                    /*...*/
                  },
                  child: Text(
                    "75%",
                    style: TextStyle(fontSize: 10.0),
                  ),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child:
            SizedBox(
                width: 70.0,
                height: 30.0,
                child:
                OutlineButton(
                  color: Colors.white,
                  textColor: Colors.black,
                  disabledBorderColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  //padding: EdgeInsets.all(5.0),
                  splashColor: Colors.blueAccent,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                  onPressed: () {
                    /*...*/
                  },
                  child: Text(
                    "75%",
                    style: TextStyle(fontSize: 10.0),
                  ),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child:
            SizedBox(
                width: 70.0,
                height: 30.0,
                child:
                OutlineButton(
                  color: Colors.white,
                  textColor: Colors.black,
                  disabledBorderColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  //padding: EdgeInsets.all(5.0),
                  splashColor: Colors.blueAccent,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                  onPressed: () {
                    /*...*/
                  },
                  child: Text(
                    "75%",
                    style: TextStyle(fontSize: 10.0),
                  ),
                )
            ),
          ),

        ],
      ),
    );
  }
}


class textFieldRow extends StatefulWidget {
  @override
  _textFieldRowState createState() => _textFieldRowState();
}

class _textFieldRowState extends State<textFieldRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 30.0, 10.0),
            child:
            Text(
                'Clavis',
                textAlign: TextAlign.center),
          ),
          Expanded(
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              )
          ),

        ],
      ),
    );
  }
}

