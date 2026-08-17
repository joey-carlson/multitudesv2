import 'package:flutter/material.dart';

import '../data/calendar_source.dart';
import '../data/database.dart';
import '../domain/persona.dart';
import 'balance_screen.dart';
import 'calendar_screen.dart';
import 'persona_detail_screen.dart';

/// Home: shows the user's personas, highlights who's at peak/trough right now,
/// and opens a detail view on tap.
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.personas,
    required this.db,
    required this.userId,
    this.onRetake,
  });

  final List<Persona> personas;
  final AppDatabase db;
  final String userId;
  final VoidCallback? onRetake;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Multitudes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            tooltip: 'Calendar',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CalendarScreen(
                  source: SampleCalendarSource(),
                  personas: personas,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.balance),
            tooltip: 'Balance',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BalanceScreen(
                  personas: personas,
                  db: db,
                  userId: userId,
                ),
              ),
            ),
          ),
          if (onRetake != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Retake survey',
              onPressed: onRetake,
            ),
        ],
      ),
      body: FutureBuilder<Map<String, double>>(
        future: db.actualWeeklyHours(userId),
        builder: (context, snap) {
          final actual = snap.data ?? const {};
          final starving = personas
              .where((p) =>
                  p.fedState(actual[p.id] ?? 0) == FedState.starving)
              .length;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (starving > 0) ...[
                _StarvingBanner(
                  count: starving,
                  onTap: () => _openBalance(context),
                ),
                const SizedBox(height: 12),
              ],
              for (final p in personas) ...[
                _PersonaCard(persona: p, now: now, db: db, userId: userId),
                const SizedBox(height: 12),
              ],
            ],
          );
        },
      ),
    );
  }

  void _openBalance(BuildContext context) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) =>
              BalanceScreen(personas: personas, db: db, userId: userId),
        ),
      );
}

/// Home banner surfacing starving personas, tappable into the dashboard.
class _StarvingBanner extends StatelessWidget {
  const _StarvingBanner({required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red.withValues(alpha: 0.08),
      child: ListTile(
        leading: const Text('🍽️', style: TextStyle(fontSize: 24)),
        title: Text('$count persona${count == 1 ? '' : 's'} starving'),
        subtitle: const Text('Tap to see who needs feeding'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class _PersonaCard extends StatelessWidget {
  const _PersonaCard({
    required this.persona,
    required this.now,
    required this.db,
    required this.userId,
  });

  final Persona persona;
  final DateTime now;
  final AppDatabase db;
  final String userId;

  @override
  Widget build(BuildContext context) {
    final peak = (persona.peakStartTime != null && persona.peakEndTime != null)
        ? '${persona.peakStartTime}–${persona.peakEndTime}'
        : 'not set';
    final state = persona.energyStateAt(now);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) =>
              PersonaDetailScreen(persona: persona, db: db, userId: userId),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(persona.emoji, style: const TextStyle(fontSize: 32)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(persona.name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        _StateBadge(state: state),
                      ],
                    ),
                    Text(persona.primaryEnergy,
                        style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(height: 8),
                    Text('⚡ Peak energy: $peak'),
                    if (persona.idealWeeklyHours > 0)
                      Text('🎯 Target: ${persona.idealWeeklyHours.toStringAsFixed(0)} hrs/week'),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small colored badge showing the persona's current energy state.
class _StateBadge extends StatelessWidget {
  const _StateBadge({required this.state});

  final EnergyState state;

  @override
  Widget build(BuildContext context) {
    final (color, text) = switch (state) {
      EnergyState.peak => (Colors.green, 'PEAK now'),
      EnergyState.recovery => (Colors.blue, 'recovering'),
      EnergyState.trough => (Colors.orange, 'low energy'),
      EnergyState.neutral => (Colors.grey, 'steady'),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(backgroundColor: color, radius: 4),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12)),
        ],
      ),
    );
  }
}
