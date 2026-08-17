import 'package:flutter/material.dart';

import '../domain/persona.dart';

/// Full detail for one persona: energy windows, current state, and the rich
/// attributes (strengths, weaknesses, triggers, ideal tasks) the generator
/// produced.
class PersonaDetailScreen extends StatelessWidget {
  const PersonaDetailScreen({super.key, required this.persona});

  final Persona persona;

  @override
  Widget build(BuildContext context) {
    final state = persona.energyStateAt(DateTime.now());
    return Scaffold(
      appBar: AppBar(title: Text('${persona.emoji}  ${persona.name}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Text(persona.emoji, style: const TextStyle(fontSize: 40)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(persona.name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    Text(persona.primaryEnergy,
                        style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _EnergyStateChip(state: state),
          const SizedBox(height: 20),
          _EnergyWindows(persona: persona),
          if (persona.idealWeeklyHours > 0) ...[
            const SizedBox(height: 8),
            Text('🎯 Target: ${persona.idealWeeklyHours.toStringAsFixed(0)} hrs/week'),
          ],
          const SizedBox(height: 8),
          _ListSection(title: '💪 Strengths', items: persona.strengths),
          _ListSection(title: '🌱 Growth areas', items: persona.weaknesses),
          _ListSection(title: '⚡ Triggers', items: persona.triggerConditions),
          _ListSection(title: '✅ Ideal tasks', items: persona.idealTasks),
        ],
      ),
    );
  }
}

class _EnergyStateChip extends StatelessWidget {
  const _EnergyStateChip({required this.state});

  final EnergyState state;

  @override
  Widget build(BuildContext context) {
    final color = switch (state) {
      EnergyState.peak => Colors.green,
      EnergyState.recovery => Colors.blue,
      EnergyState.neutral => Colors.grey,
      EnergyState.trough => Colors.orange,
    };
    return Chip(
      avatar: CircleAvatar(backgroundColor: color, radius: 6),
      label: Text('Right now: ${state.label} (energy ${state.level}/10)'),
    );
  }
}

class _EnergyWindows extends StatelessWidget {
  const _EnergyWindows({required this.persona});

  final Persona persona;

  @override
  Widget build(BuildContext context) {
    Widget row(String label, String? start, String? end) {
      final value = (start != null && end != null) ? '$start–$end' : '—';
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            SizedBox(width: 110, child: Text(label)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Energy rhythm',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 6),
        row('⚡ Peak', persona.peakStartTime, persona.peakEndTime),
        row('🔋 Recovery', persona.recoveryStartTime, persona.recoveryEndTime),
        row('😴 Trough', persona.troughStartTime, persona.troughEndTime),
      ],
    );
  }
}

class _ListSection extends StatelessWidget {
  const _ListSection({required this.title, required this.items});

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 2),
              child: Text('• $item'),
            ),
        ],
      ),
    );
  }
}
