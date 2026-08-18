import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/domain/correlation.dart';

void main() {
  group('averageImpactByKey', () {
    test('averages per key and sorts most-energizing first', () {
      final rows = averageImpactByKey<String>([
        ('Artist', 2),
        ('Artist', 1),
        ('Pro', -1),
        ('Pro', -1),
      ]);
      expect(rows.first.key, 'Artist');
      expect(rows.first.avg, 1.5);
      expect(rows.first.count, 2);
      expect(rows.last.key, 'Pro');
      expect(rows.last.avg, -1.0);
    });

    test('drops groups below minCount', () {
      final rows = averageImpactByKey<String>([
        ('A', 2),
        ('B', 1),
        ('B', 1),
      ], minCount: 2);
      expect(rows.map((r) => r.key), ['B']);
    });
  });

  group('partOfDay', () {
    test('buckets hours', () {
      expect(partOfDay(8), 'Morning');
      expect(partOfDay(14), 'Afternoon');
      expect(partOfDay(19), 'Evening');
      expect(partOfDay(2), 'Night');
    });
  });
}
