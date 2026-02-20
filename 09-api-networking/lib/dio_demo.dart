// Level 9 - API & Networking: Dio
// Dio dengan baseUrl dari --dart-define (String.fromEnvironment). GET/POST, optional interceptor (logging).

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

/// Base URL dari dart-define; default JSONPlaceholder. Contoh: flutter run --dart-define=BASE_URL=https://api.example.com
const _defaultBaseUrl = 'https://jsonplaceholder.typicode.com';

/// Demo Dio: baseUrl dari dart-define, GET, POST, interceptor logging.
class DioDemoScreen extends StatefulWidget {
  const DioDemoScreen({super.key});

  @override
  State<DioDemoScreen> createState() => _DioDemoScreenState();
}

class _DioDemoScreenState extends State<DioDemoScreen> {
  late final Dio _dio;
  bool _loading = false;
  String _result = '';
  String? _error;

  @override
  void initState() {
    super.initState();
    final baseUrl = String.fromEnvironment('BASE_URL', defaultValue: _defaultBaseUrl);
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl.isNotEmpty ? baseUrl : _defaultBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('Dio REQUEST: ${options.method} ${options.uri}');
        handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('Dio RESPONSE: ${response.statusCode}');
        handler.next(response);
      },
    ));
  }

  Future<void> _getPost() async {
    setState(() {
      _loading = true;
      _error = null;
      _result = '';
    });
    try {
      final response = await _dio.get('/posts/1');
      setState(() {
        _result = response.data.toString();
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _postCreate() async {
    setState(() {
      _loading = true;
      _error = null;
      _result = '';
    });
    try {
      final response = await _dio.post(
        '/posts',
        data: {
          'title': 'Flutter Dio Demo',
          'body': 'Ini body dari POST request.',
          'userId': 1,
        },
      );
      setState(() {
        _result = 'Created: ${response.data}';
        _loading = false;
      });
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
        title: const Text('Dio Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _loading ? null : _getPost,
                    child: const Text('GET /posts/1'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _loading ? null : _postCreate,
                    child: const Text('POST /posts'),
                  ),
                ),
              ],
            ),
            if (_loading) const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Center(child: CircularProgressIndicator()),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Error: $_error',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            if (_result.isNotEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: SingleChildScrollView(
                    child: SelectableText(
                      _result,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
