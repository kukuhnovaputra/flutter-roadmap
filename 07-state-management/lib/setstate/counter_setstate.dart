// Level 7 - State Management: setState (Counter)
// State lokal di StatefulWidget. Rebuild terjadi saat setState() dipanggil.
// Cukup untuk state sederhana dalam satu layar.

import 'package:flutter/material.dart';

/// Demo counter dengan setState.
/// Nilai _counter disimpan di State; tombol memanggil setState(() => _counter++)
/// sehingga widget di-rebuild dan tampilan terbaru.
class CounterSetStateScreen extends StatefulWidget {
  const CounterSetStateScreen({super.key});

  @override
  State<CounterSetStateScreen> createState() => _CounterSetStateScreenState();
}

class _CounterSetStateScreenState extends State<CounterSetStateScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter - setState'),
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
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _counter++;
                    });
                  },
                  child: const Text('+1'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _counter = 0;
                    });
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
