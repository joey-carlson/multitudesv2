import 'package:flutter/material.dart';

import '../data/database.dart';
import '../domain/persona_generator.dart';
import '../domain/survey_options.dart';

/// First-run onboarding: a compact version of the persona-discovery survey.
/// Runs the shared generator on-device and persists the result locally.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    super.key,
    required this.db,
    required this.userId,
    required this.onComplete,
  });

  final AppDatabase db;
  final String userId;
  final VoidCallback onComplete;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _selectedArchetypes = <String>{};
  final _namesController = TextEditingController();
  final _allocationController = TextEditingController();
  String _peak = peakEnergyOptions.first;
  String _dip = energyDipOptions.first;
  String _dipTime = energyDipTimeOptions.first;
  bool _saving = false;

  bool get _hasDip => _dip.contains('Yes') || _dip.contains('Sometimes');

  @override
  void dispose() {
    _namesController.dispose();
    _allocationController.dispose();
    super.dispose();
  }

  Future<void> _complete() async {
    setState(() => _saving = true);
    final responses = <String, dynamic>{
      'archetypes_selection': _selectedArchetypes.toList(),
      'custom_persona_names': _namesController.text,
      'overall_energy_pattern': _peak,
      'energy_dip': _dip,
      if (_hasDip) 'energy_dip_time': _dipTime,
      'weekly_time_allocation': _allocationController.text,
    };
    final personas = generatePersonasFromSurvey(widget.userId, responses);
    await widget.db.savePersonas(personas);
    if (mounted) widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🎭 Welcome to Multitudes')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Discover the multitudes within you',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          _section('Which personas resonate with you?'),
          for (final option in archetypeOptions())
            CheckboxListTile(
              dense: true,
              title: Text(option),
              value: _selectedArchetypes.contains(option),
              onChanged: (v) => setState(() {
                v == true
                    ? _selectedArchetypes.add(option)
                    : _selectedArchetypes.remove(option);
              }),
            ),
          const SizedBox(height: 12),
          _section('Personalize their names (optional, comma-separated)'),
          TextField(
            controller: _namesController,
            decoration: const InputDecoration(
              hintText: 'Executive Emma, Creative Chris',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          _section('When are you most energized for focused work?'),
          _dropdown(peakEnergyOptions, _peak, (v) => setState(() => _peak = v)),
          const SizedBox(height: 16),
          _section('Do you experience an energy dip?'),
          _dropdown(energyDipOptions, _dip, (v) => setState(() => _dip = v)),
          if (_hasDip) ...[
            const SizedBox(height: 12),
            _section('When does it occur?'),
            _dropdown(
                energyDipTimeOptions, _dipTime, (v) => setState(() => _dipTime = v)),
          ],
          const SizedBox(height: 16),
          _section('Rough weekly hours per area (optional)'),
          TextField(
            controller: _allocationController,
            decoration: const InputDecoration(
              hintText: 'Work: 40hrs, Creative: 10hrs',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed:
                _saving || _selectedArchetypes.isEmpty ? null : _complete,
            child: _saving
                ? const CircularProgressIndicator()
                : const Text('✨ Create my personas'),
          ),
        ],
      ),
    );
  }

  Widget _section(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      );

  Widget _dropdown(List<String> items, String value, ValueChanged<String> onChanged) =>
      DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        items: [
          for (final item in items)
            DropdownMenuItem(value: item, child: Text(item, overflow: TextOverflow.ellipsis)),
        ],
        onChanged: (v) => onChanged(v!),
      );
}
