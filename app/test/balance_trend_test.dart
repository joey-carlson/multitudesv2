import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/domain/balance_trend.dart';

void main() {
  group('classifyTrend', () {
    test('rising when recent clearly exceeds prior', () {
      expect(classifyTrend(10, 5), TrendDirection.rising);
    });

    test('falling when recent clearly below prior', () {
      expect(classifyTrend(3, 10), TrendDirection.falling);
    });

    test('steady within the dead-band', () {
      expect(classifyTrend(10.5, 10), TrendDirection.steady); // +5%
    });

    test('both zero -> steady', () {
      expect(classifyTrend(0, 0), TrendDirection.steady);
    });

    test('new activity from zero prior -> rising', () {
      expect(classifyTrend(4, 0), TrendDirection.rising);
    });

    test('dropped to zero -> falling', () {
      expect(classifyTrend(0, 6), TrendDirection.falling);
    });
  });
}
