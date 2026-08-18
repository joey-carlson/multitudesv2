/// Energy impact of an activity/event — whether it drains or energizes.
///
/// Grounded in Russell's circumplex model of affect (the arousal/activation
/// axis: energized ↔ deactivated) and Self-Determination Theory's subjective
/// vitality (activity aligned with a persona's strong hours is more likely to
/// be vitalizing). See docs/ARCHITECTURE.md §0.1a and PARKING_LOT.md.
library;

import 'persona.dart';

/// Bipolar −2..+2 scale.
enum EnergyImpact {
  draining(-2, '🪫 Draining'),
  somewhatDraining(-1, 'Somewhat draining'),
  neutral(0, 'Neutral'),
  somewhatEnergizing(1, 'Somewhat energizing'),
  energizing(2, '⚡ Energizing');

  const EnergyImpact(this.value, this.label);

  final int value;
  final String label;

  static EnergyImpact fromValue(int v) =>
      values.firstWhere((e) => e.value == v, orElse: () => neutral);
}

/// Heuristic seed for an event's energy impact from the effective persona's
/// energy state at the event's start time. The user can override this.
/// No persona → neutral.
EnergyImpact estimateEnergyImpact(Persona? persona, DateTime start) {
  if (persona == null) return EnergyImpact.neutral;
  return switch (persona.energyStateAt(start)) {
    EnergyState.peak => EnergyImpact.energizing,
    EnergyState.recovery => EnergyImpact.somewhatEnergizing,
    EnergyState.neutral => EnergyImpact.neutral,
    EnergyState.trough => EnergyImpact.somewhatDraining,
  };
}
