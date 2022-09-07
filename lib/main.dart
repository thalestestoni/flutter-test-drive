import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const FirstRoute());
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cálculo IMC',
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
          title: const Text('Aplicativo cálculo IMC'),
        ),
        body: const IMCForm()
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute ({
    super.key, 
    required this.nome, 
    required this.peso, 
    required this.altura,
    required this.imc
  });

  final String nome;
  final double peso;
  final double altura;
  final double imc;


  @override
  Widget build(BuildContext context) {
    final formattedImc = imc.toStringAsPrecision(3);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado IMC'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Text('Nome: $nome'),
          Text('Peso: $peso Kg'),
          Text('Altura: $altura m'),
          Text('IMC: $formattedImc')
        ],
      )
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

class IMCForm extends StatefulWidget {
  const IMCForm({Key? key}) : super(key: key);

  @override
  State<IMCForm> createState() => _IMCFormState();
}

class _IMCFormState extends State<IMCForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();

  @override void dispose() {
    nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: nomeController,
            decoration: const InputDecoration(
              hintText: 'Nome',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu nome.';
              }
              return null;
            },
          ),
          TextFormField(
            controller: pesoController,
            decoration: const InputDecoration(
              hintText: 'Peso',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu peso.';
              }

              return null;
            },
          ),
          TextFormField(
            controller: alturaController,
            decoration: const InputDecoration(
              hintText: 'Altura',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira sua altura.';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final peso = double.tryParse(pesoController.text) ?? double.minPositive;
                  final altura = double.tryParse(alturaController.text) ?? double.minPositive;

                  final imc = peso / (altura * altura);

                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => 
                      SecondRoute(
                        nome: nomeController.text,
                        peso: double.tryParse(pesoController.text) ?? double.minPositive,
                        altura: double.tryParse(alturaController.text) ?? double.minPositive,
                        imc: imc,
                      )
                    )
                  );
                }
              },
              child: const Text('Calcular IMC'),
            ),
          ),
        ],
      ),
    );
  }
}
