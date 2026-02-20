// Level 9 - API & Networking
// Menu: HTTP Request, JSON Parsing, Dio, Error Handling. Navigator.push ke tiap demo.
// Environment: base URL dari --dart-define (aman: tidak ada file env di bundle).

import 'package:flutter/material.dart';

import 'dio_demo.dart';
import 'error_handling.dart';
import 'http_request.dart';
import 'json_parsing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Level 9 - API & Networking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const _MenuScreen(),
    );
  }
}

/// Menu utama: 4 demo (HTTP, JSON, Dio, Error Handling).
class _MenuScreen extends StatelessWidget {
  const _MenuScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 9 - API & Networking'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('1. HTTP Request'),
            subtitle: const Text('GET dengan package http, loading state'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HttpRequestScreen(),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('2. JSON Parsing'),
            subtitle: const Text('Model fromJson/toJson, decode response'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const JsonParsingScreen(),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('3. Dio'),
            subtitle: const Text('Dio baseUrl, GET/POST, interceptor'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DioDemoScreen(),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('4. Error Handling'),
            subtitle: const Text('try/catch, timeout, status code, JSON invalid'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ErrorHandlingScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
