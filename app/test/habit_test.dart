import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/domain/habit.dart';

DateTime d(int day) => DateTime(2026, 1, day);

void main() {
  final today = d(10);

  group('currentStreak', () {
    test('consecutive days ending today', () {
      expect(currentStreak({d(10), d(9), d(8)}, today: today), 3);
    });

    test('grace: counts a run ending yesterday when today not done', () {
      expect(currentStreak({d(9), d(8)}, today: today), 2);
    });

    test('resets when the last completion is older than yesterday', () {
      expect(currentStreak({d(7), d(6)}, today: today), 0);
    });

    test('a gap breaks the streak', () {
      expect(currentStreak({d(10), d(9), d(7)}, today: today), 2);
    });

    test('empty → 0', () {
      expect(currentStreak(const {}, today: today), 0);
    });

    test('walks correctly across a month boundary (calendar-day stepping)', () {
      final streak = currentStreak({
        DateTime(2026, 1, 1),
        DateTime(2025, 12, 31),
        DateTime(2025, 12, 30),
      }, today: DateTime(2026, 1, 1));
      expect(streak, 3);
    });
  });

  group('doneToday', () {
    test('true only when today is in the set (date-only)', () {
      expect(doneToday({DateTime(2026, 1, 10, 15)}, today: today), isTrue);
      expect(doneToday({d(9)}, today: today), isFalse);
    });
  });
}
