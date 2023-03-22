import 'package:flutter/material.dart';

void main() {
  runApp(CounterApp());
}

class CounterApp extends StatefulWidget {
  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Couter App'),
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: Text(
            _counter.toString(),
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.purple[300],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: IconButton(
            icon: Icon(
              Icons.plus_one,
              color: Colors.red[800],
            ),
            onPressed: () {
              setState(() {
                _counter += 1;
                print(_counter);
              });
            },
          ),
        ),
      ),
    );
  }
}
