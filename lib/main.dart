import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('pt', 'BR') // Portuguese, Brazil
      ],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MyApp'),
        ),
        body: const HelloWorldWidget()
      ),
    );
  }
}

class HelloWorldWidget extends StatefulWidget {
  const HelloWorldWidget({Key? key}) : super(key: key);

  @override
  State<HelloWorldWidget> createState() => _HelloWorldWidgetState();
}

class _HelloWorldWidgetState extends State<HelloWorldWidget> {
  int _clickCounter = 0;

  void _handleClickHelloWorld() {
    setState(() {
      _clickCounter += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: _handleClickHelloWorld, 
            child: Text(
              AppLocalizations.of(context)!.helloWorld,
              style: const TextStyle(fontSize: 50),
              ) 
          ),
          SizedBox(
            child: SizedBox(
              child: Text(
                '$_clickCounter',
                style: const TextStyle(fontSize: 30),
              )
            ),
          )
        ]
      ),
    );
  }
}