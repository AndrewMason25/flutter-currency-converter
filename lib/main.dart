import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isInputValid = false;
  final TextEditingController _controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  double result = 0;
  String uzerText = '';
  bool showResult = false;
  String selectedCurrency = 'USD';
  Map<String, double> rates = {
    'USD': 90,
    'EUR': 98,
    'KZT': 0.19,
  };
  String getFlag(String currency) {
    switch (currency) {
      case 'USD': return 'assets/flags/us_flag.png';
      case 'EUR': return 'assets/flags/eu_flag.png';
      case 'KZT': return 'assets/flags/kz_flag.png';
      default: return 'assets/flags/us_flag.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(title: const Text('Input Example')),
        body: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Enter amount',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter amount';
                        }
                        final n = num.tryParse(value);
                        if (n == null || n <= 0) {
                          return 'Enter a valid number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          final num? parsed = num.tryParse(value);
                          isInputValid = parsed != null && parsed > 0;
                        });
                      }
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Select currency:'),
                  DropdownButton<String>(
                    value: selectedCurrency,
                    items: rates.keys.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                            Image.asset(getFlag(value), width: 30, height: 30),
                            const SizedBox(width: 10),
                        Text(value),
                       ],
                      ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCurrency = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: isInputValid ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    onPressed: isInputValid
                        ? () async {
                      if (!formKey.currentState!.validate()) return;
                      FocusScope.of(context).unfocus();
                      setState(() {
                        uzerText = _controller.text;
                        result = (double.tryParse(uzerText) ?? 0) * rates[selectedCurrency]!;
                        showResult = true;
                      });
                      await Future.delayed(const Duration(milliseconds: 100));
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.black87,
                          content: Text('Converted successfully ✅'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                        : null,
                    child: const Text('Convert'),
                  ),
                  ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    onPressed: () {
                      setState(() {
                        _controller.clear();
                        result = 0;
                        showResult = false;
                      });
                    },
                    child: const Text('Clear'),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: showResult ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Result: ${result.toStringAsFixed(2)} RUB',
                              style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ),
            );
          },
        ),
      ),
    );
  }
}