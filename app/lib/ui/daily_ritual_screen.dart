import 'dart:convert';

import 'package:flutter/material.dart';

import '../data/database.dart';
import '../domain/persona.dart';

/// Daily ritual (engagement layer): a morning plan — an intention and which
/// selves to feed today — and an evening reflection. One row per day, local.
class DailyRitualScreen extends StatefulWidget {
  const DailyRitualScreen({
    super.key,
    required this.db,
    required this.userId,
    required this.personas,
  });

  final AppDatabase db;
  final String userId;
  final List<Persona> personas;

  @override
  State<DailyRitualScreen> createState() => _DailyRitualScreenState();
}

class _DailyRitualScreenState extends State<DailyRitualScreen> {
  final _intention = TextEditingController();
  final _reflection = TextEditingController();
  final _intended = <String>{}; // persona ids
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _intention.dispose();
    _reflection.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final log = await widget.db.dayLog(DateTime.now());
    if (!mounted) return; // don't touch disposed controllers
    if (log != null) {
      _intention.text = log.intention ?? '';
      _reflection.text = log.reflection ?? '';
      if (log.intendedPersonaIds != null) {
        _intended.addAll(
            (jsonDecode(log.intendedPersonaIds!) as List).cast<String>());
      }
    }
    setState(() => _loading = false);
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    await widget.db.saveDayLog(
      DateTime.now(),
      intention: _intention.text.trim().isEmpty ? null : _intention.text.trim(),
      reflection:
          _reflection.text.trim().isEmpty ? null : _reflection.text.trim(),
      intendedPersonaIds: _intended.toList(),
    );
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Saved today')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
        actions: [
          TextButton(
            onPressed: _saving || _loading ? null : _save,
            child: const Text('Save'),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text('Plan',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 8),
                const Text('Which selves need feeding today?'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final p in widget.personas)
                      if (p.id != null)
                        FilterChip(
                          label: Text('${p.emoji} ${p.name}'),
                          selected: _intended.contains(p.id),
                          onSelected: (sel) => setState(() =>
                              sel ? _intended.add(p.id!) : _intended.remove(p.id)),
                        ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _intention,
                  minLines: 2,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: "Today's intention",
                    hintText: 'What matters most today?',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                const Text('Reflect',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 8),
                const Text('At day\'s end — how did it go?'),
                const SizedBox(height: 8),
                TextField(
                  controller: _reflection,
                  minLines: 3,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText:
                        'A win, what got fed, what got neglected, how you feel…',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Come back this evening to reflect. Private and on-device.',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
    );
  }
}
