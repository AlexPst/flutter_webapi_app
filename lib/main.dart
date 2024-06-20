import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late String result = 'EMPTY';

  Future<String> getInfo() async {
    var res = await Process.run('openconnect', ['--version']);
    //result = res.stdout;
    print(res.stdout);

    return res.stdout;
  }

  @override
  Widget build(BuildContext context) {
    getInfo();
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                  child: Text(result, style: const TextStyle(fontSize: 24))),
              FloatingActionButton(
                onPressed: () async {
                  result = await getInfo();
                  setState(() {});
                },
                child: const Icon(Icons.refresh),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
