import 'package:flutter/material.dart';

void main() => runApp(const TemperaturApp());

class TemperaturApp extends StatelessWidget {
  const TemperaturApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperaturrechner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const TemperaturSeite(),
    );
  }
}

class TemperaturSeite extends StatefulWidget {
  const TemperaturSeite({super.key});

  @override
  State<TemperaturSeite> createState() => _TemperaturSeiteState();
}

class _TemperaturSeiteState extends State<TemperaturSeite> {
  final _eingabe = TextEditingController(text: '20');
  bool _celsiusNachFahrenheit = true;
  String? _fehler;
  double? _ergebnis = 68;

  String get _von => _celsiusNachFahrenheit ? '°C' : '°F';
  String get _nach => _celsiusNachFahrenheit ? '°F' : '°C';

  void _umrechnen() {
    final wert = double.tryParse(_eingabe.text.trim().replaceAll(',', '.'));
    if (wert == null || !wert.isFinite) {
      setState(() {
        _fehler = 'Bitte eine gültige Zahl eingeben, z. B. 20,5.';
        _ergebnis = null;
      });
      return;
    }

    final ergebnis = _celsiusNachFahrenheit
        ? wert * 9 / 5 + 32
        : (wert - 32) * 5 / 9;

    setState(() {
      _fehler = ergebnis.isFinite ? null : 'Die eingegebene Zahl ist zu groß.';
      _ergebnis = ergebnis.isFinite ? ergebnis : null;
    });
  }

  @override
  void dispose() {
    _eingabe.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final farben = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Temperaturrechner')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.thermostat, size: 64, color: farben.primary),
                  const SizedBox(height: 16),
                  Text(
                    'Wie warm ist es?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Celsius und Fahrenheit einfach umrechnen.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.swap_horiz),
                    label: Text('$_von → $_nach · Richtung wechseln'),
                    onPressed: () {
                      setState(() {
                        _celsiusNachFahrenheit = !_celsiusNachFahrenheit;
                      });
                      _umrechnen();
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _eingabe,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'Temperatur in $_von',
                      suffixText: _von,
                      errorText: _fehler,
                      errorMaxLines: 3,
                    ),
                    onSubmitted: (_) => _umrechnen(),
                    onChanged: (_) => setState(() {
                      _ergebnis = null;
                      _fehler = null;
                    }),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: _umrechnen,
                    icon: const Icon(Icons.calculate_outlined),
                    label: const Text('Umrechnen'),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    color: farben.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Text('Ergebnis'),
                          const SizedBox(height: 8),
                          Semantics(
                            liveRegion: true,
                            child: Text(
                              _ergebnis == null
                                  ? '–'
                                  : '${_ergebnis!.toStringAsFixed(2).replaceAll('.', ',')} $_nach',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(color: farben.onPrimaryContainer),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _celsiusNachFahrenheit
                        ? 'Formel: °F = °C × 9 / 5 + 32'
                        : 'Formel: °C = (°F − 32) × 5 / 9',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
