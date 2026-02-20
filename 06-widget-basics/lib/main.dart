// Level 6 - Widget Basics
// MaterialApp dengan daftar demo: Stateless/Stateful, Layout, User Input.

import 'package:flutter/material.dart';

import 'layout_widgets.dart';
import 'stateless_stateful.dart';
import 'user_input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Level 6 - Widget Basics',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DemoListScreen(),
    );
  }
}

/// Layar utama: daftar demo. Tap untuk membuka tiap layar.
class DemoListScreen extends StatelessWidget {
  const DemoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 6 - Widget Basics'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('1. Stateless vs Stateful'),
            subtitle: const Text('Contoh StatelessWidget dan StatefulWidget'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const StatelessStatefulDemo(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('2. Layout (Scaffold, Container, Row/Column, …)'),
            subtitle: const Text('Scaffold, Container, Row, Column, Padding, Center'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const LayoutDemo(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('3. User Input'),
            subtitle: const Text('GestureDetector, TextField, Form, Button'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const UserInputDemo(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
