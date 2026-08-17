/// A point-in-time energy reading for a persona — Dart port of the
/// EnergyReading concept in src/core/personas/persona_models.py.
library;

class EnergyReading {
  EnergyReading({
    required this.personaId,
    required this.energyLevel,
    required this.timestamp,
    this.source = 'manual',
    this.notes,
  }) : assert(energyLevel >= 1 && energyLevel <= 10, 'energy 1-10');

  final String personaId;

  /// 1–10 scale.
  final int energyLevel;
  final DateTime timestamp;

  /// How the reading was captured: 'manual', 'inferred', etc.
  final String source;
  final String? notes;
}
