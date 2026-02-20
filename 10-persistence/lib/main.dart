// Level 10 - Persistence (Penyimpanan Lokal)
// Menu: SharedPreferences, File Storage, SQLite. Navigator.push ke tiap demo.

import 'package:flutter/material.dart';

import 'database_demo.dart';
import 'file_storage.dart';
import 'shared_preferences_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Level 10 - Persistence',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const _MenuScreen(),
    );
  }
}

/// Menu utama: 3 demo (Key-value, File, SQLite).
class _MenuScreen extends StatelessWidget {
  const _MenuScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 10 - Persistence'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('1. Key-value (SharedPreferences)'),
            subtitle: const Text('Simpan preferensi: nama, counter, bool'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SharedPreferencesDemoScreen(),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('2. File (path_provider + File)'),
            subtitle: const Text('Tulis/baca teks ke file di direktori app'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FileStorageDemoScreen(),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('3. Database (SQLite / sqflite)'),
            subtitle: const Text('Tabel catatan: insert, query, delete'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DatabaseDemoScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
