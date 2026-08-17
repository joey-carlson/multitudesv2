/// Persona generation — Dart port of src/core/personas/persona_generator.py.
///
/// Verified against tests/fixtures/persona_generation_cases.json. Any change to
/// this logic must keep the fixture-contract test green (regenerate the
/// fixtures from the Python spec if the change is intentional).
library;

import 'persona.dart';

/// Peak-energy windows keyed on the unique "(Xam-Ypm)" token in each
/// `overall_energy_pattern` option. Options with no single peak
/// ("It varies", "multiple peaks") are absent by design.
const Map<String, List<String>> _peakRanges = {
  '(5am-7am)': ['05:00', '07:00'],
  '(7am-9am)': ['07:00', '09:00'],
  '(9am-12pm)': ['09:00', '12:00'],
  '(12pm-3pm)': ['12:00', '15:00'],
  '(3pm-6pm)': ['15:00', '18:00'],
  '(6pm-8pm)': ['18:00', '20:00'],
  '(8pm-11pm)': ['20:00', '23:00'],
  '(11pm-2am)': ['23:00', '02:00'],
};

/// Trough windows keyed on the "(Xam-Ypm)" token in each `energy_dip_time`
/// option. "Other time" has no defined range and is intentionally absent.
const Map<String, List<String>> _troughRanges = {
  '(10am-12pm)': ['10:00', '12:00'],
  '(12pm-2pm)': ['12:00', '14:00'],
  '(2pm-4pm)': ['14:00', '16:00'],
  '(5pm-7pm)': ['17:00', '19:00'],
};

class _EnergyConfig {
  String? peakStart;
  String? peakEnd;
  String? troughStart;
  String? troughEnd;
  String? recoveryStart;
  String? recoveryEnd;
}

/// Convenience entry point mirroring the Python module-level function.
List<Persona> generatePersonasFromSurvey(
  String userId,
  Map<String, dynamic> surveyResponses,
) =>
    PersonaGenerator(userId).generateFromSurvey(surveyResponses);

/// Generates [Persona] objects from onboarding survey responses.
class PersonaGenerator {
  PersonaGenerator(this.userId);

  final String userId;

  List<Persona> generateFromSurvey(Map<String, dynamic> responses) {
    final selected = _parseArchetypeSelection(
      (responses['archetypes_selection'] as List?)?.cast<String>() ?? const [],
    );
    final customNames = _parseCustomNames(
      (responses['custom_persona_names'] as String?) ?? '',
    );
    final energy = _extractEnergyConfig(responses);
    final allocation = _parseTimeAllocation(
      (responses['weekly_time_allocation'] as String?) ?? '',
    );

    final personas = <Persona>[];
    for (var idx = 0; idx < selected.length; idx++) {
      final archetype = selected[idx];
      final template = archetypeTemplates[archetype];
      if (template == null) continue; // e.g. CUSTOM has no template

      final personaName =
          idx < customNames.length ? customNames[idx] : template.defaultName;

      var idealHours = allocation[personaName] ?? 0.0;
      if (idealHours == 0.0) idealHours = allocation[template.defaultName] ?? 0.0;
      if (idealHours == 0.0) {
        for (final entry in allocation.entries) {
          final key = entry.key.toLowerCase();
          if (key.contains('work') && archetype == PersonaArchetype.professional) {
            idealHours = entry.value;
            break;
          } else if (key.contains('creat') && archetype == PersonaArchetype.artist) {
            idealHours = entry.value;
            break;
          }
        }
      }

      personas.add(_createPersonaFromTemplate(template, personaName, energy, idealHours));
    }
    return personas;
  }

  List<PersonaArchetype> _parseArchetypeSelection(List<String> selections) {
    const emojiToArchetype = {
      '🧠': PersonaArchetype.professional,
      '🌈': PersonaArchetype.innerChild,
      '🎨': PersonaArchetype.artist,
      '🛠': PersonaArchetype.builder,
      '🛡': PersonaArchetype.guardian,
      '📐': PersonaArchetype.architect,
      '🗃': PersonaArchetype.historian,
      '🤖': PersonaArchetype.optimizer,
      '✨': PersonaArchetype.custom,
    };
    final result = <PersonaArchetype>[];
    for (final selection in selections) {
      for (final entry in emojiToArchetype.entries) {
        if (selection.contains(entry.key)) {
          result.add(entry.value);
          break;
        }
      }
    }
    return result;
  }

  List<String> _parseCustomNames(String text) {
    if (text.trim().isEmpty) return const [];
    return text
        .split(',')
        .map((n) => n.trim())
        .where((n) => n.isNotEmpty)
        .toList();
  }

  _EnergyConfig _extractEnergyConfig(Map<String, dynamic> responses) {
    final config = _EnergyConfig();

    final energyPattern = (responses['overall_energy_pattern'] as String?) ?? '';
    for (final entry in _peakRanges.entries) {
      if (energyPattern.contains(entry.key)) {
        config.peakStart = entry.value[0];
        config.peakEnd = entry.value[1];
        break;
      }
    }

    final hasDip = (responses['energy_dip'] as String?) ?? '';
    if (hasDip.contains('Yes') || hasDip.contains('Sometimes')) {
      final dipTime = (responses['energy_dip_time'] as String?) ?? '';
      for (final entry in _troughRanges.entries) {
        if (dipTime.contains(entry.key)) {
          config.troughStart = entry.value[0];
          config.troughEnd = entry.value[1];
          break;
        }
      }
    }

    if (config.troughEnd != null) {
      final troughEndHour = int.parse(config.troughEnd!.split(':')[0]);
      config.recoveryStart = config.troughEnd;
      config.recoveryEnd = '${((troughEndHour + 2) % 24).toString().padLeft(2, '0')}:00';
    }

    return config;
  }

  Map<String, double> _parseTimeAllocation(String text) {
    final allocation = <String, double>{};
    if (text.trim().isEmpty) return allocation;

    final pattern = RegExp(
      r'([^:,]+):\s*(\d+(?:\.\d+)?)\s*(?:hrs?)?',
      caseSensitive: false,
    );
    for (final match in pattern.allMatches(text)) {
      final name = match.group(1)!.trim();
      final hours = double.tryParse(match.group(2)!);
      if (hours != null) allocation[name] = hours;
    }
    return allocation;
  }

  Persona _createPersonaFromTemplate(
    PersonaArchetypeTemplate template,
    String customName,
    _EnergyConfig energy,
    double idealWeeklyHours,
  ) {
    return Persona(
      userId: userId,
      name: customName,
      emoji: template.emoji,
      archetype: template.archetype,
      primaryEnergy: template.primaryEnergy,
      strengths: List.of(template.commonStrengths),
      weaknesses: List.of(template.commonWeaknesses),
      triggerConditions: List.of(template.typicalTriggers),
      idealTasks: List.of(template.idealTaskCategories),
      peakStartTime: energy.peakStart ?? template.typicalPeakStart,
      peakEndTime: energy.peakEnd ?? template.typicalPeakEnd,
      troughStartTime: energy.troughStart,
      troughEndTime: energy.troughEnd,
      recoveryStartTime: energy.recoveryStart,
      recoveryEndTime: energy.recoveryEnd,
      idealWeeklyHours: idealWeeklyHours,
      actualWeeklyHours: 0.0,
      isActive: true,
    );
  }
}
