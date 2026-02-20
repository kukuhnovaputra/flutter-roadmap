// Level 11 - Cloud Firestore: CRUD (tambah, baca, update, hapus) pada koleksi.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreDemoScreen extends StatefulWidget {
  const FirestoreDemoScreen({super.key});

  @override
  State<FirestoreDemoScreen> createState() => _FirestoreDemoScreenState();
}

class _FirestoreDemoScreenState extends State<FirestoreDemoScreen> {
  final _textController = TextEditingController();
  final _collection = FirebaseFirestore.instance.collection('items');
  String? _message;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _add() async {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      setState(() => _message = 'Isi teks dulu');
      return;
    }
    try {
      await _collection.add({
        'text': text,
        'createdAt': FieldValue.serverTimestamp(),
      });
      _textController.clear();
      if (mounted) setState(() => _message = 'Ditambah');
    } catch (e) {
      if (mounted) setState(() => _message = 'Error: $e');
    }
  }

  Future<void> _delete(String id) async {
    try {
      await _collection.doc(id).delete();
      if (mounted) setState(() => _message = 'Dihapus');
    } catch (e) {
      if (mounted) setState(() => _message = 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Firestore'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'Teks item',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _add(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _add,
                  child: const Text('Tambah'),
                ),
              ],
            ),
          ),
          if (_message != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _message!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          const SizedBox(height: 8),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _collection.orderBy('createdAt', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data?.docs ?? [];
                if (docs.isEmpty) {
                  return const Center(
                    child: Text('Belum ada item. Tambah di atas.'),
                  );
                }
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final data = doc.data();
                    final text = data['text'] as String? ?? '(kosong)';
                    return ListTile(
                      title: Text(text),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _delete(doc.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
