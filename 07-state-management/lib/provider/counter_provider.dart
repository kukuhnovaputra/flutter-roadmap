// Level 7 - State Management: Provider (Counter)
// State global dengan ChangeNotifier. notifyListeners() memicu rebuild widget yang listen.
// Cocok untuk aplikasi kecil-menengah; state bisa diakses dari banyak layar.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Notifier untuk counter. Extends ChangeNotifier agar bisa dipakai dengan Provider.
class CounterNotifier extends ChangeNotifier {
  int _value = 0;
  int get value => _value;

  void increment() {
    _value++;
    notifyListeners();
  }

  void reset() {
    _value = 0;
    notifyListeners();
  }
}

/// Layar counter yang dibungkus ChangeNotifierProvider.
/// Consumer (atau context.watch) mendengarkan perubahan dan rebuild saat notifyListeners().
class CounterProviderScreen extends StatelessWidget {
  const CounterProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterNotifier(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Counter - Provider'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Klik tombol untuk menambah:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Consumer<CounterNotifier>(
                builder: (context, counter, _) {
                  return Text(
                    '${counter.value}',
                    style: Theme.of(context).textTheme.displayLarge,
                  );
                },
              ),
              const SizedBox(height: 24),
              Consumer<CounterNotifier>(
                builder: (context, counter, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: counter.increment,
                        child: const Text('+1'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: counter.reset,
                        child: const Text('Reset'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
