// Level 10 - Persistence: File (path_provider + dart:io File)
// Menyimpan dan memuat teks ke/dari file di direktori aplikasi.
// Catatan: dart:io tidak tersedia di web; demo ini untuk Android/iOS/desktop.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// Demo penyimpanan file: path_provider, File write/read.
class FileStorageDemoScreen extends StatefulWidget {
  const FileStorageDemoScreen({super.key});

  @override
  State<FileStorageDemoScreen> createState() => _FileStorageDemoScreenState();
}

class _FileStorageDemoScreenState extends State<FileStorageDemoScreen> {
  final _controller = TextEditingController();
  String _status = '';
  String _loadedContent = '';

  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = path.join(dir.path, 'level10_demo.txt');
    return File(filePath);
  }

  Future<void> _save() async {
    try {
      final file = await _getFile();
      await file.writeAsString(_controller.text);
      setState(() => _status = 'Tersimpan di: ${file.path}');
    } catch (e) {
      setState(() => _status = 'Error: $e');
    }
  }

  Future<void> _load() async {
    try {
      final file = await _getFile();
      if (await file.exists()) {
        final content = await file.readAsString();
        setState(() {
          _loadedContent = content;
          _controller.text = content;
          _status = 'Dimuat dari file';
        });
      } else {
        setState(() {
          _loadedContent = '';
          _status = 'File belum ada. Simpan dulu.';
        });
      }
    } catch (e) {
      setState(() => _status = 'Error: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Storage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Isi file (teks):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Ketik lalu simpan...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(onPressed: _save, child: const Text('Simpan')),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _load, child: const Text('Muat')),
              ],
            ),
            if (_status.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                _status,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
