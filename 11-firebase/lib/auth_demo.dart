// Level 11 - Firebase Auth: register, login (email/password), logout, auth state stream.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthDemoScreen extends StatefulWidget {
  const AuthDemoScreen({super.key});

  @override
  State<AuthDemoScreen> createState() => _AuthDemoScreenState();
}

class _AuthDemoScreenState extends State<AuthDemoScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _message;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    // Dengarkan perubahan auth state (login/logout).
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (mounted) {
        setState(() {
          _message = user == null
              ? 'Belum login'
              : 'Login sebagai: ${user.email}';
        });
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      setState(() => _message = 'Email dan password wajib diisi');
      return;
    }
    setState(() {
      _loading = true;
      _message = null;
    });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (mounted) setState(() => _message = 'Registrasi berhasil');
    } on FirebaseAuthException catch (e) {
      if (mounted) setState(() => _message = 'Error: ${e.message}');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      setState(() => _message = 'Email dan password wajib diisi');
      return;
    }
    setState(() {
      _loading = true;
      _message = null;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (mounted) setState(() => _message = 'Login berhasil');
    } on FirebaseAuthException catch (e) {
      if (mounted) setState(() => _message = 'Error: ${e.message}');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) setState(() => _message = 'Sudah logout');
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Auth'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_message != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  _message!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            if (_loading)
              const Center(child: CircularProgressIndicator())
            else ...[
              FilledButton(
                onPressed: _register,
                child: const Text('Register'),
              ),
              const SizedBox(height: 8),
              FilledButton.tonal(
                onPressed: _login,
                child: const Text('Login'),
              ),
            ],
            if (user != null) ...[
              const SizedBox(height: 24),
              const Divider(),
              OutlinedButton(
                onPressed: _logout,
                child: const Text('Logout'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
