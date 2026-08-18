import 'package:flutter/material.dart';

import '../data/database.dart';
import '../domain/persona.dart';

/// Edit an existing persona's fields and energy windows (peak/recovery/trough).
/// Returns the updated [Persona] on save, or null if cancelled.
class EditPersonaScreen extends StatefulWidget {
  const EditPersonaScreen({super.key, required this.db, required this.persona});

  final AppDatabase db;
  final Persona persona;

  @override
  State<EditPersonaScreen> createState() => _EditPersonaScreenState();
}

class _EditPersonaScreenState extends State<EditPersonaScreen> {
  late final TextEditingController _name =
      TextEditingController(text: widget.persona.name);
  late final TextEditingController _emoji =
      TextEditingController(text: widget.persona.emoji);
  late final TextEditingController _energy =
      TextEditingController(text: widget.persona.primaryEnergy);
  late final TextEditingController _hours = TextEditingController(
      text: widget.persona.idealWeeklyHours.toStringAsFixed(
          widget.persona.idealWeeklyHours == widget.persona.idealWeeklyHours.roundToDouble()
              ? 0
              : 1));

  late TimeOfDay? _peakStart = _parse(widget.persona.peakStartTime);
  late TimeOfDay? _peakEnd = _parse(widget.persona.peakEndTime);
  late TimeOfDay? _recStart = _parse(widget.persona.recoveryStartTime);
  late TimeOfDay? _recEnd = _parse(widget.persona.recoveryEndTime);
  late TimeOfDay? _troughStart = _parse(widget.persona.troughStartTime);
  late TimeOfDay? _troughEnd = _parse(widget.persona.troughEndTime);
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _emoji.dispose();
    _energy.dispose();
    _hours.dispose();
    super.dispose();
  }

  static TimeOfDay? _parse(String? hhmm) {
    if (hhmm == null) return null;
    final p = hhmm.split(':');
    if (p.length != 2) return null;
    final h = int.tryParse(p[0]);
    final m = int.tryParse(p[1]);
    if (h == null || m == null) return null;
    return TimeOfDay(hour: h, minute: m);
  }

  static String? _fmt(TimeOfDay? t) => t == null
      ? null
      : '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please enter a name')));
      return;
    }
    setState(() => _saving = true);
    final updated = Persona(
      id: widget.persona.id,
      userId: widget.persona.userId,
      name: name,
      emoji: _emoji.text.trim().isEmpty ? widget.persona.emoji : _emoji.text.trim(),
      archetype: widget.persona.archetype,
      primaryEnergy: _energy.text.trim(),
      strengths: widget.persona.strengths,
      weaknesses: widget.persona.weaknesses,
      triggerConditions: widget.persona.triggerConditions,
      idealTasks: widget.persona.idealTasks,
      peakStartTime: _fmt(_peakStart),
      peakEndTime: _fmt(_peakEnd),
      recoveryStartTime: _fmt(_recStart),
      recoveryEndTime: _fmt(_recEnd),
      troughStartTime: _fmt(_troughStart),
      troughEndTime: _fmt(_troughEnd),
      idealWeeklyHours: double.tryParse(_hours.text.trim()) ?? 0,
      actualWeeklyHours: widget.persona.actualWeeklyHours,
      isActive: widget.persona.isActive,
    );
    await widget.db.updatePersona(updated);
    if (mounted) Navigator.pop(context, updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit ${widget.persona.name}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _field('Name', _name),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 90, child: _field('Emoji', _emoji)),
              const SizedBox(width: 12),
              Expanded(child: _field('Primary energy', _energy)),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Energy windows',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Text('Tap to set; Clear to leave unset.',
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          _WindowRow(
            label: '⚡ Peak',
            start: _peakStart,
            end: _peakEnd,
            onPick: (isStart) => _pick(isStart, (v) => isStart ? _peakStart = v : _peakEnd = v),
            onClear: () => setState(() {
              _peakStart = null;
              _peakEnd = null;
            }),
          ),
          _WindowRow(
            label: '🔋 Recovery',
            start: _recStart,
            end: _recEnd,
            onPick: (isStart) => _pick(isStart, (v) => isStart ? _recStart = v : _recEnd = v),
            onClear: () => setState(() {
              _recStart = null;
              _recEnd = null;
            }),
          ),
          _WindowRow(
            label: '😴 Trough',
            start: _troughStart,
            end: _troughEnd,
            onPick: (isStart) =>
                _pick(isStart, (v) => isStart ? _troughStart = v : _troughEnd = v),
            onClear: () => setState(() {
              _troughStart = null;
              _troughEnd = null;
            }),
          ),
          const SizedBox(height: 16),
          _field('Weekly target (hours)', _hours,
              keyboard: TextInputType.number),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Save changes'),
          ),
        ],
      ),
    );
  }

  Future<void> _pick(bool isStart, void Function(TimeOfDay) assign) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => assign(picked));
  }

  Widget _field(String label, TextEditingController c,
          {TextInputType? keyboard}) =>
      TextField(
        controller: c,
        keyboardType: keyboard,
        decoration: InputDecoration(
            labelText: label, border: const OutlineInputBorder()),
      );
}

class _WindowRow extends StatelessWidget {
  const _WindowRow({
    required this.label,
    required this.start,
    required this.end,
    required this.onPick,
    required this.onClear,
  });

  final String label;
  final TimeOfDay? start;
  final TimeOfDay? end;
  final void Function(bool isStart) onPick;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    String t(TimeOfDay? v) => v == null ? '—' : v.format(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 96, child: Text(label)),
          Expanded(
            child: OutlinedButton(
                onPressed: () => onPick(true), child: Text('Start ${t(start)}')),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton(
                onPressed: () => onPick(false), child: Text('End ${t(end)}')),
          ),
          IconButton(
            tooltip: 'Clear',
            icon: const Icon(Icons.clear, size: 18),
            onPressed: (start == null && end == null) ? null : onClear,
          ),
        ],
      ),
    );
  }
}
