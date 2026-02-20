// Level 9 - API & Networking: Error Handling
// try/catch, timeout, status code, JSON invalid. Tampilkan pesan error ke user.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

/// Demo error handling: timeout, status != 200, JSON invalid.
/// Pesan error ditampilkan ke user (SnackBar / Text).
class ErrorHandlingScreen extends StatefulWidget {
  const ErrorHandlingScreen({super.key});

  @override
  State<ErrorHandlingScreen> createState() => _ErrorHandlingScreenState();
}

class _ErrorHandlingScreenState extends State<ErrorHandlingScreen> {
  bool _loading = false;
  String _result = '';
  String _lastError = '';

  Future<void> _requestOk() async {
    await _doRequest('https://jsonplaceholder.typicode.com/posts/1');
  }

  Future<void> _request404() async {
    await _doRequest('https://jsonplaceholder.typicode.com/posts/99999');
  }

  Future<void> _requestTimeout() async {
    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(milliseconds: 1),
      receiveTimeout: const Duration(milliseconds: 1),
    ));
    setState(() {
      _loading = true;
      _lastError = '';
      _result = '';
    });
    try {
      await dio.get('https://jsonplaceholder.typicode.com/posts/1');
      setState(() {
        _result = 'OK';
        _loading = false;
      });
    } on DioException catch (e) {
      String msg = 'Error: ';
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        msg += 'Timeout';
      } else {
        msg += e.message ?? e.type.name;
      }
      setState(() {
        _lastError = msg;
        _loading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      }
    } catch (e) {
      setState(() {
        _lastError = e.toString();
        _loading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _parseInvalidJson() async {
    setState(() {
      _loading = true;
      _lastError = '';
      _result = '';
    });
    try {
      final decoded = jsonDecode('{ invalid json }') as Map<String, dynamic>;
      setState(() {
        _result = decoded.toString();
        _loading = false;
      });
    } catch (e) {
      final msg = 'JSON invalid: $e';
      setState(() {
        _lastError = msg;
        _loading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      }
    }
  }

  Future<void> _doRequest(String url) async {
    setState(() {
      _loading = true;
      _lastError = '';
      _result = '';
    });
    try {
      final dio = Dio();
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _result = response.data.toString();
          _loading = false;
        });
      } else {
        final msg = 'Server error: status ${response.statusCode}';
        setState(() {
          _lastError = msg;
          _loading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
        }
      }
    } on DioException catch (e) {
      String msg = 'No connection / network error';
      if (e.response != null) {
        msg = 'Status: ${e.response?.statusCode}';
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        msg = 'Timeout';
      }
      setState(() {
        _lastError = msg;
        _loading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      }
    } catch (e) {
      setState(() {
        _lastError = e.toString();
        _loading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Handling'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _loading ? null : _requestOk,
                  child: const Text('Request OK'),
                ),
                ElevatedButton(
                  onPressed: _loading ? null : _request404,
                  child: const Text('404'),
                ),
                ElevatedButton(
                  onPressed: _loading ? null : _requestTimeout,
                  child: const Text('Timeout'),
                ),
                ElevatedButton(
                  onPressed: _loading ? null : _parseInvalidJson,
                  child: const Text('Invalid JSON'),
                ),
              ],
            ),
            if (_loading)
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Center(child: CircularProgressIndicator()),
              ),
            if (_lastError.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  _lastError,
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
