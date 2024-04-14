import 'package:flutter/material.dart';

main() => {
      runApp(const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AppHome(),
      ))
    };

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  String? _weightError;
  String? _heightError;
  String _result = 'Informe seus dados!';

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: _clearFields,
              icon: const Icon(
                Icons.refresh_sharp,
                size: 27,
              ),
              color: Colors.white,
            )
          ],
          title: const Text(
            'Calculadora de IMC',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            child: Center(
              child: Column(
                children: [
                  const Icon(Icons.person_outlined,
                      size: 200, color: Colors.green),
                  TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: _weightController,
                    style: const TextStyle(color: Colors.green, fontSize: 25),
                    decoration: InputDecoration(
                      errorText: _weightError,
                      labelText: 'Peso (kg)',
                      labelStyle:
                          const TextStyle(fontSize: 20, color: Colors.green),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Icon(Icons.add, size: 23, color: Colors.green),
                  TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: _heightController,
                    decoration: InputDecoration(
                      errorText: _heightError,
                      labelText: 'Altura (cm)',
                      labelStyle:
                          const TextStyle(fontSize: 20, color: Colors.green),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _calculateIMC,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Calcular',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _result,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _calculateIMC() {
    int? height = int.tryParse(_heightController.text);
    if (height == null) {
      setState(() {
        _heightError = 'Altura é um campo obrigatório!';
        _weightError = null;
      });
      return;
    }

    int? weight = int.tryParse(_weightController.text);
    if (weight == null) {
      setState(() {
        _weightError = 'Peso é um campo obrigatório!';
        _heightError = null;
      });
      return;
    }

    final double imc = weight / (height * 2) * 100;

    _setResult(imc);
  }

  _clearFields() {
    setState(() {
      _heightController.text = '';
      _weightController.text = '';
      _result = 'Informe seus dados!';
    });
  }

  _setResult(double imc) {
    final String result;
    if (imc < 16) {
      result = 'IMC: ${imc.toStringAsFixed(2)} = Magreza grave!';
    } else if (imc < 17) {
      result = 'IMC: ${imc.toStringAsFixed(2)} = Magreza moderada!';
    } else if (imc < 18.6) {
      result = 'IMC: ${imc.toStringAsFixed(2)} = Magreza leve!';
    } else if (imc < 25) {
      result = 'IMC: ${imc.toStringAsFixed(2)} = Peso ideal!';
    } else if (imc < 30) {
      result = 'IMC: ${imc.toStringAsFixed(2)} = Sobrepeso!';
    } else if (imc < 35) {
      result = 'IMC: ${imc.toStringAsFixed(2)} = Obesidade grau 1!';
    } else if (imc < 40) {
      result = 'IMC: ${imc.toStringAsFixed(2)} = Obesidade grau 2!';
    } else {
      result = 'IMC: ${imc.toStringAsFixed(2)} = Obesidade grau 3!';
    }

    setState(() {
      _weightError = null;
      _heightError = null;
      _result = result;
    });
  }
}
