import 'package:flutter/material.dart';

import '../data/database.dart';
import '../domain/persona.dart';

/// Balance dashboard: ideal vs. actual weekly hours per persona, so you can see
/// which personas are neglected or overworked. "Actual" hours come from tasks
/// completed in the last 7 days (their estimated durations).
class BalanceScreen extends StatelessWidget {
  const BalanceScreen({
    super.key,
    required this.personas,
    required this.db,
    required this.userId,
  });

  final List<Persona> personas;
  final AppDatabase db;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Persona balance')),
      body: FutureBuilder<Map<String, double>>(
        future: db.actualWeeklyHours(userId),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final actualByPersona = snap.data ?? const {};
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Based on tasks completed in the last 7 days.',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 12),
              for (final p in personas)
                _BalanceRow(
                  persona: p,
                  actual: actualByPersona[p.id] ?? 0,
                ),
            ],
          );
        },
      ),
    );
  }
}

class _BalanceRow extends StatelessWidget {
  const _BalanceRow({required this.persona, required this.actual});

  final Persona persona;
  final double actual;

  @override
  Widget build(BuildContext context) {
    final ideal = persona.idealWeeklyHours;
    final (color, label) = _status(ideal, actual);
    final progress = ideal > 0 ? (actual / ideal).clamp(0.0, 1.0) : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('${persona.emoji}  ${persona.name}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(label,
                    style: TextStyle(
                        color: color, fontWeight: FontWeight.w600, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              color: color,
              backgroundColor: color.withValues(alpha: 0.12),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ideal > 0
                ? '${actual.toStringAsFixed(1)} / ${ideal.toStringAsFixed(0)} hrs this week'
                : '${actual.toStringAsFixed(1)} hrs this week · no weekly target set',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
        ],
      ),
    );
  }

  /// Colour + label from the ideal/actual relationship.
  (Color, String) _status(double ideal, double actual) {
    if (ideal <= 0) return (Colors.grey, 'No target');
    final ratio = actual / ideal;
    if (ratio < 0.5) return (Colors.orange, 'Neglected');
    if (ratio <= 1.15) return (Colors.green, 'On track');
    return (Colors.red, 'Overworked');
  }
}
