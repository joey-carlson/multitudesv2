import 'package:flutter/material.dart';

import '../data/database.dart';
import '../domain/persona.dart';

/// Create a new persona — either from a preset archetype template (prefilled)
/// or fully custom. Persists via the existing personas store.
class AddPersonaScreen extends StatefulWidget {
  const AddPersonaScreen({
    super.key,
    required this.db,
    required this.userId,
    this.initialArchetype,
  });

  final AppDatabase db;
  final String userId;

  /// Preselects a template archetype (e.g. when opened from a suggestion).
  final PersonaArchetype? initialArchetype;

  @override
  State<AddPersonaScreen> createState() => _AddPersonaScreenState();
}

class _AddPersonaScreenState extends State<AddPersonaScreen> {
  bool _custom = false;
  late PersonaArchetype _archetype =
      widget.initialArchetype ?? PersonaArchetype.professional;

  final _name = TextEditingController();
  final _emoji = TextEditingController();
  final _energy = TextEditingController();
  final _hours = TextEditingController(text: '0');
  TimeOfDay? _peakStart;
  TimeOfDay? _peakEnd;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _applyTemplate(_archetype);
  }

  @override
  void dispose() {
    _name.dispose();
    _emoji.dispose();
    _energy.dispose();
    _hours.dispose();
    super.dispose();
  }

  void _applyTemplate(PersonaArchetype a) {
    final t = archetypeTemplates[a]!;
    _name.text = t.defaultName;
    _emoji.text = t.emoji;
    _energy.text = t.primaryEnergy;
    _peakStart = _parse(t.typicalPeakStart);
    _peakEnd = _parse(t.typicalPeakEnd);
  }

  static TimeOfDay? _parse(String? hhmm) {
    if (hhmm == null) return null;
    final p = hhmm.split(':');
    return TimeOfDay(hour: int.parse(p[0]), minute: int.parse(p[1]));
  }

  static String? _fmt(TimeOfDay? t) => t == null
      ? null
      : '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  Future<void> _pickTime(bool start) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: (start ? _peakStart : _peakEnd) ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => start ? _peakStart = picked : _peakEnd = picked);
    }
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please enter a name')));
      return;
    }
    setState(() => _saving = true);
    final hours = double.tryParse(_hours.text.trim()) ?? 0;
    final persona = _custom
        ? personaCustom(
            userId: widget.userId,
            name: name,
            emoji: _emoji.text,
            primaryEnergy: _energy.text,
            peakStart: _fmt(_peakStart),
            peakEnd: _fmt(_peakEnd),
            idealWeeklyHours: hours,
          )
        : personaFromTemplate(
            _archetype,
            userId: widget.userId,
            name: name,
            emoji: _emoji.text,
            peakStart: _fmt(_peakStart),
            peakEnd: _fmt(_peakEnd),
            idealWeeklyHours: hours,
          );
    await widget.db.savePersonas([persona]);
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a persona')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: false, label: Text('From template')),
              ButtonSegment(value: true, label: Text('Custom')),
            ],
            selected: {_custom},
            onSelectionChanged: (s) => setState(() => _custom = s.first),
          ),
          const SizedBox(height: 16),
          if (!_custom) ...[
            const Text('Archetype', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            DropdownButtonFormField<PersonaArchetype>(
              initialValue: _archetype,
              isExpanded: true,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: [
                for (final a in archetypeTemplates.keys)
                  DropdownMenuItem(
                    value: a,
                    child: Text(
                        '${archetypeTemplates[a]!.emoji}  ${archetypeTemplates[a]!.defaultName}'),
                  ),
              ],
              onChanged: (a) {
                if (a != null) {
                  setState(() {
                    _archetype = a;
                    _applyTemplate(a);
                  });
                }
              },
            ),
            const SizedBox(height: 16),
          ],
          _field('Name', _name, hint: 'e.g. Executive Emma'),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 90, child: _field('Emoji', _emoji, hint: '✨')),
              const SizedBox(width: 12),
              Expanded(
                child: _custom
                    ? _field('Primary energy', _energy,
                        hint: 'e.g. Calm, focused, reflective')
                    : const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Peak energy window',
              style: TextStyle(fontWeight: FontWeight.w600)),
          Row(
            children: [
              Expanded(child: _timeTile('Start', _peakStart, () => _pickTime(true))),
              const SizedBox(width: 12),
              Expanded(child: _timeTile('End', _peakEnd, () => _pickTime(false))),
            ],
          ),
          const SizedBox(height: 16),
          _field('Weekly target (hours)', _hours,
              hint: '0', keyboard: TextInputType.number),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Create persona'),
          ),
        ],
      ),
    );
  }

  Widget _field(String label, TextEditingController c,
          {String? hint, TextInputType? keyboard}) =>
      TextField(
        controller: c,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      );

  Widget _timeTile(String label, TimeOfDay? value, VoidCallback onTap) =>
      OutlinedButton(
        onPressed: onTap,
        child: Text(
            '$label: ${value == null ? '—' : value.format(context)}'),
      );
}
