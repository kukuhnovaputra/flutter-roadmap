// Level 8 - Navigation & Routing: Named Routes
// MaterialApp routes map + Navigator.pushNamed. Route diberi nama string (mis. '/detail').

import 'package:flutter/material.dart';

/// Demo Named Routes: navigasi dengan nama route, bukan builder.
class NamedRoutesScreen extends StatelessWidget {
  const NamedRoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Named Routes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Navigasi pakai nama route. Route didefinisikan di MaterialApp.',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/named-routes/detail');
              },
              child: const Text('Ke Detail (pushNamed)'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Halaman detail yang diakses lewat route '/named-routes/detail'.
class NamedRoutesDetailScreen extends StatelessWidget {
  const NamedRoutesDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail - Named Route'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ini halaman detail lewat pushNamed.'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
