// Level 8 - Navigation & Routing: GoRouter
// Declarative routing dengan go_router. Route didefinisikan di config; navigasi pakai context.go() / context.push().

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Demo app dengan GoRouter: MaterialApp.router + GoRouter config.
/// Ditampilkan sebagai satu layar penuh dari menu (nested app).
class GoRouterDemoApp extends StatelessWidget {
  const GoRouterDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => _GoRouterHomePage(parentContext: context),
        ),
        GoRoute(
          path: '/settings',
          builder: (_, __) => const _GoRouterSettingsPage(),
        ),
      ],
    );
    return MaterialApp.router(
      title: 'GoRouter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

class _GoRouterHomePage extends StatelessWidget {
  const _GoRouterHomePage({this.parentContext});

  final BuildContext? parentContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoRouter - Home'),
        leading: parentContext != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(parentContext!),
                tooltip: 'Back to menu',
              )
            : null,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ini halaman utama (path: /)',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.push('/settings'),
              child: const Text('Ke Settings (context.push)'),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoRouterSettingsPage extends StatelessWidget {
  const _GoRouterSettingsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoRouter - Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ini halaman settings (path: /settings)',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Back (context.pop)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Ke Home (context.go)'),
            ),
          ],
        ),
      ),
    );
  }
}
