import 'package:flutter/material.dart';

import '../data/database.dart';
import '../domain/persona.dart';

/// Persona feeding dashboard: which personas are fed, over-fed, or starving.
/// "Actual" hours currently come from tasks completed in the last 7 days;
/// calendar time will feed in once calendar integration (F1) lands.
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
      appBar: AppBar(title: const Text('Are your personas fed?')),
      body: FutureBuilder<Map<String, double>>(
        future: db.actualWeeklyHours(userId),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final actualByPersona = snap.data ?? const {};

          // Build + sort attention-first: starving, then over-fed, fed, none.
          final rows = [
            for (final p in personas)
              (persona: p, actual: actualByPersona[p.id] ?? 0.0)
          ]..sort((a, b) => _priority(a.persona.fedState(a.actual))
              .compareTo(_priority(b.persona.fedState(b.actual))));

          final counts = <FedState, int>{};
          for (final r in rows) {
            final s = r.persona.fedState(r.actual);
            counts[s] = (counts[s] ?? 0) + 1;
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _SummaryCard(counts: counts),
              const SizedBox(height: 8),
              Text(
                'Based on tasks completed in the last 7 days. '
                'Calendar time will count too once calendar sync is added.',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              const SizedBox(height: 8),
              for (final r in rows)
                _BalanceRow(persona: r.persona, actual: r.actual),
            ],
          );
        },
      ),
    );
  }

  static int _priority(FedState s) => switch (s) {
        FedState.starving => 0,
        FedState.overFed => 1,
        FedState.fed => 2,
        FedState.noTarget => 3,
      };
}

Color _colorFor(FedState s) => switch (s) {
      FedState.starving => Colors.red,
      FedState.overFed => Colors.orange,
      FedState.fed => Colors.green,
      FedState.noTarget => Colors.grey,
    };

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.counts});

  final Map<FedState, int> counts;

  @override
  Widget build(BuildContext context) {
    final starving = counts[FedState.starving] ?? 0;
    final headline = starving > 0
        ? '🍽️ $starving persona${starving == 1 ? '' : 's'} starving'
        : '🎉 Your personas are in balance';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(headline,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final s in FedState.values)
                  if ((counts[s] ?? 0) > 0)
                    Chip(
                      visualDensity: VisualDensity.compact,
                      avatar: CircleAvatar(
                          backgroundColor: _colorFor(s), radius: 6),
                      label: Text('${counts[s]} ${s.label}'),
                    ),
              ],
            ),
          ],
        ),
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
    final state = persona.fedState(actual);
    final color = _colorFor(state);
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
                child: Text(state.label,
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
}
