import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/domain/energy_profile.dart';
import 'package:multitudes/domain/energy_reading.dart';

EnergyReading _r(int hour, int level) => EnergyReading(
      personaId: 'p',
      energyLevel: level,
      timestamp: DateTime(2026, 1, 1, hour),
    );

void main() {
  group('buildEnergyProfile', () {
    test('returns null below the minimum sample size', () {
      expect(buildEnergyProfile([_r(9, 8), _r(9, 7)]), isNull);
    });

    test('returns null (no crash) on empty input even if minReadings is 0', () {
      expect(buildEnergyProfile(const [], minReadings: 0), isNull);
    });

    test('averages by hour and finds peak/trough', () {
      final p = buildEnergyProfile([
        _r(9, 8), _r(9, 6), // 09:00 avg 7
        _r(15, 9), _r(15, 9), // 15:00 avg 9  (peak)
        _r(11, 3), // 11:00 avg 3 (trough)
      ])!;
      expect(p.sampleCount, 5);
      expect(p.avgByHour[9], 7.0);
      expect(p.peakHour, 15);
      expect(p.troughHour, 11);
    });
  });
}
