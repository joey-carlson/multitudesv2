/// Local energy forecasting (depth improvement): from a persona's own energy
/// check-ins, build an average-energy-by-hour profile and forecast the hours it
/// tends to feel highest and lowest. On-device; grounded in estimating peak
/// alertness from the user's own longitudinal data (chronotype research) rather
/// than a fixed clock assumption.
library;

import 'energy_reading.dart';

class EnergyProfile {
  EnergyProfile({
    required this.avgByHour,
    required this.peakHour,
    required this.troughHour,
    required this.sampleCount,
  });

  /// Average energy (1–10) per hour-of-day, only for hours that have check-ins.
  final Map<int, double> avgByHour;

  /// Hour-of-day with the highest / lowest average energy.
  final int peakHour;
  final int troughHour;

  /// Total check-ins the profile is based on.
  final int sampleCount;
}

/// Build an [EnergyProfile] from [readings]; returns null when there aren't at
/// least [minReadings] check-ins to be meaningful.
EnergyProfile? buildEnergyProfile(List<EnergyReading> readings,
    {int minReadings = 4}) {
  if (readings.isEmpty || readings.length < minReadings) return null;

  final sums = <int, int>{};
  final counts = <int, int>{};
  for (final r in readings) {
    final h = r.timestamp.hour;
    sums[h] = (sums[h] ?? 0) + r.energyLevel;
    counts[h] = (counts[h] ?? 0) + 1;
  }
  final avg = {for (final h in sums.keys) h: sums[h]! / counts[h]!};

  var peak = avg.keys.first;
  var trough = avg.keys.first;
  avg.forEach((h, a) {
    if (a > avg[peak]!) peak = h;
    if (a < avg[trough]!) trough = h;
  });

  return EnergyProfile(
    avgByHour: avg,
    peakHour: peak,
    troughHour: trough,
    sampleCount: readings.length,
  );
}
