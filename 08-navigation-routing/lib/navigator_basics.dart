// Level 8 - Navigation & Routing: Navigator basics
// Navigator.push, pop, pushReplacement. Imperatif: panggil method untuk ganti layar.

import 'package:flutter/material.dart';

/// Demo layar pertama: tombol "Ke Halaman 2" memakai Navigator.push.
class NavigatorBasicsScreen extends StatelessWidget {
  const NavigatorBasicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigator - Push / Pop'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Halaman 1',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const _Halaman2Screen(),
                  ),
                );
              },
              child: const Text('Ke Halaman 2 (push)'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Halaman 2: Back (pop) dan Ganti halaman (pushReplacement).
class _Halaman2Screen extends StatelessWidget {
  const _Halaman2Screen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Halaman 2',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back (pop)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const _HalamanGantiScreen(),
                  ),
                );
              },
              child: const Text('Ganti halaman (pushReplacement)'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Layar pengganti setelah pushReplacement; hanya punya Back.
class _HalamanGantiScreen extends StatelessWidget {
  const _HalamanGantiScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Pengganti'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ini tampil setelah pushReplacement.\nStack sebelumnya diganti.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back ke Halaman 1'),
            ),
          ],
        ),
      ),
    );
  }
}
