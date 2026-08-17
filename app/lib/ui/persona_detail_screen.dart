import 'package:flutter/material.dart';

import '../data/database.dart';
import '../domain/energy_reading.dart';
import '../domain/persona.dart';

/// Full detail for one persona: energy windows, current state, the rich
/// attributes the generator produced, plus energy check-ins (log + history).
class PersonaDetailScreen extends StatefulWidget {
  const PersonaDetailScreen({super.key, required this.persona, required this.db});

  final Persona persona;
  final AppDatabase db;

  @override
  State<PersonaDetailScreen> createState() => _PersonaDetailScreenState();
}

class _PersonaDetailScreenState extends State<PersonaDetailScreen> {
  Persona get _persona => widget.persona;
  double _level = 5;
  late Future<List<EnergyReading>> _readings;

  @override
  void initState() {
    super.initState();
    _loadReadings();
  }

  void _loadReadings() {
    final id = _persona.id;
    _readings = id == null
        ? Future.value(const [])
        : widget.db.recentReadings(id);
  }

  Future<void> _logEnergy() async {
    final id = _persona.id;
    if (id == null) return;
    await widget.db.logEnergyReading(EnergyReading(
      personaId: id,
      energyLevel: _level.round(),
      timestamp: DateTime.now(),
    ));
    if (!mounted) return;
    setState(_loadReadings);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logged energy ${_level.round()}/10')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = _persona.energyStateAt(DateTime.now());
    return Scaffold(
      appBar: AppBar(title: Text('${_persona.emoji}  ${_persona.name}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Text(_persona.emoji, style: const TextStyle(fontSize: 40)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_persona.name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    Text(_persona.primaryEnergy,
                        style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _EnergyStateChip(state: state),
          const SizedBox(height: 20),
          _checkInCard(),
          const SizedBox(height: 20),
          _EnergyWindows(persona: _persona),
          if (_persona.idealWeeklyHours > 0) ...[
            const SizedBox(height: 8),
            Text('🎯 Target: ${_persona.idealWeeklyHours.toStringAsFixed(0)} hrs/week'),
          ],
          const SizedBox(height: 8),
          _ListSection(title: '💪 Strengths', items: _persona.strengths),
          _ListSection(title: '🌱 Growth areas', items: _persona.weaknesses),
          _ListSection(title: '⚡ Triggers', items: _persona.triggerConditions),
          _ListSection(title: '✅ Ideal tasks', items: _persona.idealTasks),
        ],
      ),
    );
  }

  Widget _checkInCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('How is this persona feeling right now?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Row(
                children: [
                  const Text('1'),
                  Expanded(
                    child: Slider(
                      value: _level,
                      min: 1,
                      max: 10,
                      divisions: 9,
                      label: '${_level.round()}',
                      onChanged: (v) => setState(() => _level = v),
                    ),
                  ),
                  const Text('10'),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  onPressed: _persona.id == null ? null : _logEnergy,
                  icon: const Icon(Icons.bolt),
                  label: Text('Log energy ${_level.round()}/10'),
                ),
              ),
              const SizedBox(height: 8),
              const Text('Recent check-ins',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              FutureBuilder<List<EnergyReading>>(
                future: _readings,
                builder: (context, snap) {
                  final readings = snap.data ?? const [];
                  if (readings.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text('No check-ins yet.',
                          style: TextStyle(color: Colors.grey)),
                    );
                  }
                  return Column(
                    children: [
                      for (final r in readings)
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 14,
                            child: Text('${r.energyLevel}'),
                          ),
                          title: Text(_formatTime(r.timestamp)),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      );

  String _formatTime(DateTime t) {
    final l = t.toLocal();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${l.year}-${two(l.month)}-${two(l.day)}  ${two(l.hour)}:${two(l.minute)}';
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
