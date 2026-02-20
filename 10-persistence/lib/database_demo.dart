// Level 10 - Persistence: Database lokal (SQLite via sqflite)
// Create table, insert, query, delete. Demo daftar catatan sederhana.

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

/// Model catatan untuk tabel SQLite.
class Catatan {
  final int? id;
  final String title;
  final String body;

  Catatan({this.id, required this.title, required this.body});

  Map<String, dynamic> toMap() => {'id': id, 'title': title, 'body': body};

  static Catatan fromMap(Map<String, dynamic> map) => Catatan(
        id: map['id'] as int?,
        title: map['title'] as String,
        body: map['body'] as String,
      );
}

/// Demo SQLite: openDatabase, CREATE TABLE, INSERT, SELECT, DELETE.
class DatabaseDemoScreen extends StatefulWidget {
  const DatabaseDemoScreen({super.key});

  @override
  State<DatabaseDemoScreen> createState() => _DatabaseDemoScreenState();
}

class _DatabaseDemoScreenState extends State<DatabaseDemoScreen> {
  Database? _db;
  List<Catatan> _items = [];
  String? _error;

  Future<void> _initDb() async {
    final dbPath = await getDatabasesPath();
    final filePath = path.join(dbPath, 'level10_notes.db');
    _db = await openDatabase(
      filePath,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, body TEXT)',
        );
      },
    );
    await _loadNotes();
  }

  Future<void> _loadNotes() async {
    if (_db == null) return;
    final maps = await _db!.query('notes', orderBy: 'id DESC');
    setState(() {
      _items = maps.map((m) => Catatan.fromMap(m)).toList();
      _error = null;
    });
  }

  Future<void> _addNote(String title, String body) async {
    if (_db == null) return;
    await _db!.insert('notes', {'title': title, 'body': body});
    await _loadNotes();
  }

  Future<void> _deleteNote(int id) async {
    if (_db == null) return;
    await _db!.delete('notes', where: 'id = ?', whereArgs: [id]);
    await _loadNotes();
  }

  @override
  void initState() {
    super.initState();
    _initDb().catchError((e) {
      setState(() => _error = e.toString());
    });
  }

  @override
  void dispose() {
    _db?.close();
    super.dispose();
  }

  void _showAddDialog() {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Catatan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(labelText: 'Isi'),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              _addNote(titleController.text, bodyController.text);
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('SQLite')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Error: $_error'),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite (sqflite)'),
      ),
      body: _items.isEmpty
          ? const Center(child: Text('Belum ada catatan. Tekan + untuk tambah.'))
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, i) {
                final n = _items[i];
                return ListTile(
                  title: Text(n.title),
                  subtitle: Text(n.body),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _deleteNote(n.id!),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
