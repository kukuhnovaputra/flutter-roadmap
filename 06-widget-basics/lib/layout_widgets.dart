// Level 6 - Widget Basics: Layout
// Scaffold, Container, Row, Column, Padding, Center.

import 'package:flutter/material.dart';

/// Demo layar untuk widget layout: Scaffold, Container, Row, Column, Padding, Center.
class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Widgets'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCenterSection(context),
            const SizedBox(height: 16),
            _buildPaddingSection(context),
            const SizedBox(height: 16),
            _buildContainerSection(context),
            const SizedBox(height: 16),
            _buildRowSection(context),
            const SizedBox(height: 16),
            _buildColumnSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Center', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Center(
              child: Icon(Icons.center_focus_strong, size: 48),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaddingSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Padding', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Container(
              color: Colors.blue.shade100,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: const Text('Teks dengan padding 24'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainerSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Container', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: const Text('Container dengan padding, margin, decoration'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Row', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.star),
                const Icon(Icons.favorite),
                const Icon(Icons.thumb_up),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumnSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Column', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Baris 1'),
                const Text('Baris 2'),
                const Text('Baris 3'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
