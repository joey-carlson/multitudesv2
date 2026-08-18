import 'package:flutter/material.dart';

import '../data/database.dart';
import '../domain/energy_profile.dart';
import '../domain/energy_reading.dart';
import '../domain/persona.dart';
import '../domain/task.dart';
import 'edit_persona_screen.dart';

/// Full detail for one persona: energy windows, current state, the rich
/// attributes the generator produced, energy check-ins, and tasks.
class PersonaDetailScreen extends StatefulWidget {
  const PersonaDetailScreen({
    super.key,
    required this.persona,
    required this.db,
    required this.userId,
    this.onChanged,
  });

  final Persona persona;
  final AppDatabase db;
  final String userId;

  /// Called after the persona is edited, so callers can refresh their lists.
  final VoidCallback? onChanged;

  @override
  State<PersonaDetailScreen> createState() => _PersonaDetailScreenState();
}

class _PersonaDetailScreenState extends State<PersonaDetailScreen> {
  late Persona _persona = widget.persona;
  double _level = 5;
  late Future<List<EnergyReading>> _readings;
  late Future<List<Task>> _tasks;

  @override
  void initState() {
    super.initState();
    _loadReadings();
    _loadTasks();
  }

  Future<void> _edit() async {
    final updated = await Navigator.of(context).push<Persona>(
      MaterialPageRoute(
        builder: (_) => EditPersonaScreen(db: widget.db, persona: _persona),
      ),
    );
    if (updated != null) {
      setState(() => _persona = updated);
      widget.onChanged?.call();
    }
  }

  void _loadReadings() {
    final id = _persona.id;
    // Fetch a wider history: the newest few show as the check-in list, the full
    // set feeds the observed-energy profile.
    _readings = id == null
        ? Future.value(const [])
        : widget.db.recentReadings(id, limit: 200);
  }

  void _loadTasks() {
    final id = _persona.id;
    _tasks =
        id == null ? Future.value(const []) : widget.db.tasksForPersona(id);
  }

  Future<void> _toggleTask(Task task, bool completed) async {
    if (task.id == null) return;
    await widget.db.setTaskCompleted(task.id!, completed);
    if (mounted) setState(_loadTasks);
  }

  Future<void> _addTaskDialog() async {
    final id = _persona.id;
    if (id == null) return;
    final titleController = TextEditingController();
    var energy = 3.0;
    var minutes = 30.0;

    final created = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => AlertDialog(
          title: Text('New task for ${_persona.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                autofocus: true,
                decoration: const InputDecoration(
                    labelText: 'Task', hintText: 'e.g. Review Q3 report'),
              ),
              const SizedBox(height: 12),
              Text('Energy required: ${energy.round()}/5'),
              Slider(
                value: energy,
                min: 1,
                max: 5,
                divisions: 4,
                label: '${energy.round()}',
                onChanged: (v) => setLocal(() => energy = v),
              ),
              Text('Estimated: ${minutes.round()} min'),
              Slider(
                value: minutes,
                min: 15,
                max: 180,
                divisions: 11,
                label: '${minutes.round()} min',
                onChanged: (v) => setLocal(() => minutes = v),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );

    if (created == true && titleController.text.trim().isNotEmpty) {
      await widget.db.addTask(Task(
        userId: widget.userId,
        personaId: id,
        title: titleController.text.trim(),
        energyRequired: energy.round(),
        estimatedMinutes: minutes.round(),
      ));
      if (mounted) setState(_loadTasks);
    }
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
      appBar: AppBar(
        title: Text('${_persona.emoji}  ${_persona.name}'),
        actions: [
          if (_persona.id != null)
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Edit persona',
              onPressed: _edit,
            ),
        ],
      ),
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
          _tasksCard(),
          const SizedBox(height: 20),
          _checkInCard(),
          const SizedBox(height: 20),
          _energyProfileCard(),
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

  Widget _tasksCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text('Tasks',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  TextButton.icon(
                    onPressed: _persona.id == null ? null : _addTaskDialog,
                    icon: const Icon(Icons.add),
                    label: const Text('Add'),
                  ),
                ],
              ),
              FutureBuilder<List<Task>>(
                future: _tasks,
                builder: (context, snap) {
                  final tasks = snap.data ?? const [];
                  if (tasks.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text('No tasks yet. Add one above.',
                          style: TextStyle(color: Colors.grey)),
                    );
                  }
                  return Column(
                    children: [
                      for (final t in tasks)
                        CheckboxListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          value: t.completed,
                          onChanged: (v) => _toggleTask(t, v ?? false),
                          title: Text(
                            t.title,
                            style: t.completed
                                ? const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey)
                                : null,
                          ),
                          subtitle: Text(
                              '⚡${t.energyRequired}/5 · ${t.estimatedMinutes} min'),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      );

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
                      for (final r in readings.take(8))
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 14,
                            child: Text('${r.energyLevel}'),
                          ),
                          title: Text(_formatTime(r.timestamp)),
                        ),
                      if (readings.length > 8)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text('+ ${readings.length - 8} more',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12)),
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

  /// Observed energy pattern from this persona's own check-ins (local forecast).
  /// Hidden until there are enough check-ins to be meaningful.
  Widget _energyProfileCard() => FutureBuilder<List<EnergyReading>>(
        future: _readings,
        builder: (context, snap) {
          final profile = buildEnergyProfile(snap.data ?? const []);
          if (profile == null) return const SizedBox.shrink();
          String hh(int h) => '${h.toString().padLeft(2, '0')}:00';
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Observed energy pattern',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(
                      'From ${profile.sampleCount} check-ins: highest around '
                      '${hh(profile.peakHour)}, lowest around ${hh(profile.troughHour)}.',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    _HourlyEnergyChart(profile: profile),
                  ],
                ),
              ),
            ),
          );
        },
      );
}

/// Compact bar chart of average energy by hour-of-day (only hours with data).
class _HourlyEnergyChart extends StatelessWidget {
  const _HourlyEnergyChart({required this.profile});

  final EnergyProfile profile;

  @override
  Widget build(BuildContext context) {
    final hours = profile.avgByHour.keys.toList()..sort();
    return SizedBox(
      height: 84,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final h in hours)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: (profile.avgByHour[h]! / 10.0) * 56,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: h == profile.peakHour
                          ? Colors.green
                          : h == profile.troughHour
                              ? Colors.orange
                              : Colors.blueGrey.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(h.toString().padLeft(2, '0'),
                      style: const TextStyle(fontSize: 9, color: Colors.grey)),
                ],
              ),
            ),
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
