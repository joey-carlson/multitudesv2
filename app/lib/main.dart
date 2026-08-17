import 'package:flutter/material.dart';

import 'data/database.dart';
import 'domain/persona.dart';
import 'ui/home_screen.dart';
import 'ui/onboarding_screen.dart';

void main() {
  runApp(const MultitudesApp());
}

class MultitudesApp extends StatelessWidget {
  const MultitudesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multitudes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF6B6B)),
        useMaterial3: true,
      ),
      home: const RootScreen(),
    );
  }
}

/// Decides between onboarding and home based on locally stored personas.
/// Single-user, local-first: no auth on-device yet, so we use a fixed user id.
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  static const _userId = 'local-user';
  final _db = AppDatabase();
  late Future<List<Persona>> _personasFuture;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    // Block body (not arrow): an arrow lambda would *return* the assigned
    // Future, and setState rejects a callback that returns a Future.
    setState(() {
      _personasFuture = _db.activePersonas(_userId);
    });
  }

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Persona>>(
      future: _personasFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final personas = snapshot.data ?? const [];
        if (personas.isEmpty) {
          return OnboardingScreen(
            db: _db,
            userId: _userId,
            onComplete: _reload,
          );
        }
        return HomeScreen(personas: personas, onRetake: _reload, db: _db);
      },
    );
  }
}
