import 'package:flutter/material.dart';
import 'package:flutter_listview/data.dart';

void main() => runApp(MaterialApp(
      home: MainApp(),
      theme: ThemeData(primarySwatch: Colors.lime),
    ));

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var _datas = List<Data>();
  int _radioTypeMessage = -1;
  TextEditingController _messageTextEditingController =
      TextEditingController(text: "");
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Flutter ListView",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, position) {
                    var data = _datas[position];
                    switch (data.typeMessage) {
                      case 1:
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Card(
                              color: Colors.lime,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data.message,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                        break;
                      default:
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data.message,
                                ),
                              ),
                            ),
                          ],
                        );
                    }
                  },
                  itemCount: _datas.length,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: _radioTypeMessage,
                          onChanged: (value) {
                            setState(() {
                              _radioTypeMessage = value;
                            });
                          },
                        ),
                        Text("Left"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Radio(
                          value: 2,
                          groupValue: _radioTypeMessage,
                          onChanged: (value) {
                            setState(() {
                              _radioTypeMessage = value;
                            });
                          },
                        ),
                        Text("Right"),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _messageTextEditingController,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      String message =
                          _messageTextEditingController.text.toString().trim();
                      if (message.isEmpty) {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              "Message is empty",
                            ),
                          ),
                        );
                      } else if (_radioTypeMessage == -1) {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              "Please choose type message",
                            ),
                          ),
                        );
                      } else {
                        _messageTextEditingController.clear();
                        setState(() {
                          _datas.add(Data(message, _radioTypeMessage));
                          _radioTypeMessage = -1;
                        });
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
