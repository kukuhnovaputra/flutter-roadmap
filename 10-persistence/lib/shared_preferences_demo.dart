// Level 10 - Persistence: Key-value (SharedPreferences)
// Menyimpan dan memuat data sederhana: int, String, bool, List<String>.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Demo SharedPreferences: simpan/load nama, counter, preferensi.
class SharedPreferencesDemoScreen extends StatefulWidget {
  const SharedPreferencesDemoScreen({super.key});

  @override
  State<SharedPreferencesDemoScreen> createState() =>
      _SharedPreferencesDemoScreenState();
}

class _SharedPreferencesDemoScreenState extends State<SharedPreferencesDemoScreen> {
  static const _keyNama = 'nama';
  static const _keyCounter = 'counter';
  static const _keyDarkMode = 'dark_mode';

  final _namaController = TextEditingController();
  int _counter = 0;
  bool _darkMode = false;
  String _status = '';

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  Future<void> _loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _namaController.text = prefs.getString(_keyNama) ?? '';
      _counter = prefs.getInt(_keyCounter) ?? 0;
      _darkMode = prefs.getBool(_keyDarkMode) ?? false;
      _status = 'Data dimuat dari SharedPreferences';
    });
  }

  Future<void> _saveNama() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyNama, _namaController.text);
    setState(() => _status = 'Nama disimpan');
  }

  Future<void> _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    _counter = (prefs.getInt(_keyCounter) ?? 0) + 1;
    await prefs.setInt(_keyCounter, _counter);
    setState(() => _status = 'Counter: $_counter disimpan');
  }

  Future<void> _toggleDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    _darkMode = !_darkMode;
    await prefs.setBool(_keyDarkMode, _darkMode);
    setState(() => _status = 'Dark mode: $_darkMode');
  }

  Future<void> _clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _namaController.clear();
    setState(() {
      _counter = 0;
      _darkMode = false;
      _status = 'Semua data dihapus';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _saveNama,
              child: const Text('Simpan Nama'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Counter: $_counter'),
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: const Text('+1'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Dark mode (preferensi)'),
              value: _darkMode,
              onChanged: (_) => _toggleDarkMode(),
            ),
            const SizedBox(height: 16),
            if (_status.isNotEmpty)
              Text(_status, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: _clearAll,
              child: const Text('Hapus Semua Data'),
            ),
          ],
        ),
      ),
    );
  }
}
