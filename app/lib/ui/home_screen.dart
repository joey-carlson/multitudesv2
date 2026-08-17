import 'package:flutter/material.dart';

import '../data/database.dart';
import '../domain/persona.dart';
import 'persona_detail_screen.dart';

/// Home: shows the user's personas, highlights who's at peak/trough right now,
/// and opens a detail view on tap.
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.personas,
    required this.db,
    this.onRetake,
  });

  final List<Persona> personas;
  final AppDatabase db;
  final VoidCallback? onRetake;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Multitudes'),
        actions: [
          if (onRetake != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Retake survey',
              onPressed: onRetake,
            ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: personas.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, i) =>
            _PersonaCard(persona: personas[i], now: now, db: db),
      ),
    );
  }
}

class _PersonaCard extends StatelessWidget {
  const _PersonaCard({required this.persona, required this.now, required this.db});

  final Persona persona;
  final DateTime now;
  final AppDatabase db;

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
            builder: (_) => PersonaDetailScreen(persona: persona, db: db),
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
