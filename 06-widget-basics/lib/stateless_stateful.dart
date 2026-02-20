// Level 6 - Widget Basics: Stateless vs Stateful
// StatelessWidget: UI tidak berubah. StatefulWidget: UI bisa berubah (state).

import 'package:flutter/material.dart';

/// Demo layar yang menampilkan contoh StatelessWidget dan StatefulWidget.
class StatelessStatefulDemo extends StatelessWidget {
  const StatelessStatefulDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateless vs Stateful'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _StatelessExample(),
            SizedBox(height: 24),
            _StatefulExample(),
          ],
        ),
      ),
    );
  }
}

/// 1. StatelessWidget: widget yang tidak menyimpan state.
/// Build hanya bergantung pada input (constructor/properties).
class _StatelessExample extends StatelessWidget {
  const _StatelessExample();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'StatelessWidget',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Text(
              'Widget ini tidak punya state. Setiap build hasilnya sama.',
            ),
            const SizedBox(height: 8),
            const Icon(Icons.star, color: Colors.amber, size: 32),
          ],
        ),
      ),
    );
  }
}

/// 2. StatefulWidget: widget yang punya state (data yang bisa berubah).
/// State disimpan di State<T>; saat setState() dipanggil, build ulang.
class _StatefulExample extends StatefulWidget {
  const _StatefulExample();

  @override
  State<_StatefulExample> createState() => _StatefulExampleState();
}

class _StatefulExampleState extends State<_StatefulExample> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'StatefulWidget',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text('Counter: $_counter'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('Tambah'),
            ),
          ],
        ),
      ),
    );
  }
}
