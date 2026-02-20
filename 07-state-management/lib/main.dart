// Level 7 - State Management
// Menu utama: pilih pendekatan (setState, Provider, Riverpod, Bloc) lalu Counter atau Todo.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bloc/counter_bloc.dart';
import 'bloc/todo_bloc.dart';
import 'provider/counter_provider.dart';
import 'provider/todo_provider.dart';
import 'riverpod/counter_riverpod.dart';
import 'riverpod/todo_riverpod.dart';
import 'setstate/counter_setstate.dart';
import 'setstate/todo_setstate.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Level 7 - State Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StateManagementMenu(),
    );
  }
}

/// Layar utama: daftar demo per pendekatan (setState, Provider, Riverpod, Bloc).
class StateManagementMenu extends StatelessWidget {
  const StateManagementMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 7 - State Management'),
      ),
      body: ListView(
        children: [
          _sectionHeader(context, '1. setState (state lokal)'),
          _tile(context, 'Counter - setState', const CounterSetStateScreen()),
          _tile(context, 'Todo List - setState', const TodoSetStateScreen()),
          const Divider(height: 24),
          _sectionHeader(context, '2. Provider'),
          _tile(context, 'Counter - Provider', const CounterProviderScreen()),
          _tile(context, 'Todo List - Provider', const TodoProviderScreen()),
          const Divider(height: 24),
          _sectionHeader(context, '3. Riverpod'),
          _tile(context, 'Counter - Riverpod', const CounterRiverpodScreen()),
          _tile(context, 'Todo List - Riverpod', const TodoRiverpodScreen()),
          const Divider(height: 24),
          _sectionHeader(context, '4. Bloc/Cubit'),
          _tile(context, 'Counter - Bloc/Cubit', const CounterBlocScreen()),
          _tile(context, 'Todo List - Bloc/Cubit', const TodoBlocScreen()),
        ],
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _tile(BuildContext context, String title, Widget screen) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => screen,
          ),
        );
      },
    );
  }
}
