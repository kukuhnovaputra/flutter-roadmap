// Level 8 - Navigation & Routing
// Menu utama: Navigator basics, Named Routes, GoRouter. Pakai Named Routes untuk akses dari menu.

import 'package:flutter/material.dart';

import 'gorouter_screen.dart';
import 'named_routes.dart';
import 'navigator_basics.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Level 8 - Navigation & Routing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const _MenuScreen(),
        '/navigator-basics': (context) => const NavigatorBasicsScreen(),
        '/named-routes': (context) => const NamedRoutesScreen(),
        '/named-routes/detail': (context) => const NamedRoutesDetailScreen(),
        '/gorouter': (context) => const GoRouterDemoApp(),
      },
    );
  }
}

/// Layar menu: navigasi ke tiga demo pakai pushNamed.
class _MenuScreen extends StatelessWidget {
  const _MenuScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 8 - Navigation & Routing'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('1. Navigator (push / pop)'),
            subtitle: const Text('Navigator.push, pop, pushReplacement'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.pushNamed(context, '/navigator-basics'),
          ),
          const Divider(),
          ListTile(
            title: const Text('2. Named Routes'),
            subtitle: const Text('MaterialApp routes + pushNamed'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.pushNamed(context, '/named-routes'),
          ),
          const Divider(),
          ListTile(
            title: const Text('3. GoRouter'),
            subtitle: const Text('Declarative routing dengan go_router'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.pushNamed(context, '/gorouter'),
          ),
        ],
      ),
    );
  }
}
