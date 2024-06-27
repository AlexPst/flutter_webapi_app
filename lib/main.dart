import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:process_run/shell.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late String result = 'No result yet';

  Future<String> getInfo() async {
    var pwd = '1';
    var stdin =
        ByteStream.fromBytes(systemEncoding.encode(pwd)).asBroadcastStream();

    var env = ShellEnvironment()..aliases['sudo'] = 'sudo --stdin';
    var shell = Shell(environment: env, stdin: stdin);
    var res = await shell.run('sudo occtl show users');

    print(res);

    return res.outText;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                      child:
                          Text(result, style: const TextStyle(fontSize: 24)))),
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
