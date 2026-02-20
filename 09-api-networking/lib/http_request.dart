// Level 9 - API & Networking: HTTP Request
// GET dengan package http. Async/await, loading state, tampilkan response.

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Demo GET request dengan package http.
/// Tombol Fetch memanggil API; loading saat request; tampilkan body.
class HttpRequestScreen extends StatefulWidget {
  const HttpRequestScreen({super.key});

  @override
  State<HttpRequestScreen> createState() => _HttpRequestScreenState();
}

class _HttpRequestScreenState extends State<HttpRequestScreen> {
  bool _loading = false;
  String _result = 'Tekan Fetch untuk mengambil data.';
  String? _error;

  Future<void> _fetch() async {
    setState(() {
      _loading = true;
      _error = null;
      _result = '';
    });
    try {
      final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        setState(() {
          _result = response.body;
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Status: ${response.statusCode}';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _loading ? null : _fetch,
              child: Text(_loading ? 'Loading...' : 'Fetch'),
            ),
            const SizedBox(height: 16),
            if (_error != null)
              Text(
                'Error: $_error',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            if (_result.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: SelectableText(
                    _result,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
