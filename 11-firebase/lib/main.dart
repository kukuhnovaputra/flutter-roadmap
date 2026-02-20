// Level 11 - Firebase (BaaS)
// Menu: Auth demo, Firestore demo. Butuh konfigurasi Firebase (FlutterFire CLI / google-services).

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth_demo.dart';
import 'firestore_demo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Level 11 - Firebase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const _MenuScreen(),
    );
  }
}

/// Menu utama: Auth demo, Firestore demo.
class _MenuScreen extends StatelessWidget {
  const _MenuScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 11 - Firebase'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('1. Firebase Auth'),
            subtitle: const Text('Register, Login (email/password), Logout, auth state'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AuthDemoScreen(),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('2. Cloud Firestore'),
            subtitle: const Text('CRUD: koleksi, dokumen, baca/tulis, rules dasar'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FirestoreDemoScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
