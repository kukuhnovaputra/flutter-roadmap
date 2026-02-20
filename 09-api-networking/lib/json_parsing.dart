// Level 9 - API & Networking: JSON Parsing
// Model class dengan fromJson/toJson. Decode JSON ke object, tampilkan title/body.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Model Post (sesuai JSONPlaceholder).
class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'title': title,
        'body': body,
      };
}

/// Demo: fetch JSON, decode ke Post, tampilkan field title & body.
class JsonParsingScreen extends StatefulWidget {
  const JsonParsingScreen({super.key});

  @override
  State<JsonParsingScreen> createState() => _JsonParsingScreenState();
}

class _JsonParsingScreenState extends State<JsonParsingScreen> {
  bool _loading = false;
  Post? _post;
  String? _error;

  Future<void> _fetchPost() async {
    setState(() {
      _loading = true;
      _error = null;
      _post = null;
    });
    try {
      final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final post = Post.fromJson(json);
        setState(() {
          _post = post;
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
        title: const Text('JSON Parsing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _loading ? null : _fetchPost,
              child: Text(_loading ? 'Loading...' : 'Fetch Post'),
            ),
            const SizedBox(height: 16),
            if (_error != null)
              Text(
                'Error: $_error',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            if (_post != null) ...[
              Text(
                'Title',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(_post!.title),
              const SizedBox(height: 12),
              Text(
                'Body',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(_post!.body),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
