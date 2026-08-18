import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/domain/calendar_event.dart';
import 'package:multitudes/domain/persona.dart';
import 'package:multitudes/domain/rebalance_suggestion.dart';

Persona _p({String? peakStart, String? peakEnd, List<String> tasks = const []}) =>
    Persona(
      id: 'p',
      userId: 'u',
      name: 'Chris',
      emoji: '🎨',
      archetype: PersonaArchetype.artist,
      primaryEnergy: '',
      strengths: const [],
      weaknesses: const [],
      triggerConditions: const [],
      idealTasks: tasks,
      peakStartTime: peakStart,
      peakEndTime: peakEnd,
    );

CalendarEvent _ev(DateTime start, DateTime end) =>
    CalendarEvent(id: 'e', title: 'busy', start: start, end: end);

void main() {
  final from = DateTime(2026, 1, 1, 6); // 6am, before the peak window

  test('suggests an open peak slot with the persona activities', () {
    final chris = _p(peakStart: '14:00', peakEnd: '18:00', tasks: ['Paint', 'Write', 'Music', 'Extra']);
    final s = suggestRebalance(starving: [chris], events: const [], from: from);
    expect(s.length, 1);
    expect(s.first.slotStart, DateTime(2026, 1, 1, 14));
    expect(s.first.slotEnd, DateTime(2026, 1, 1, 18));
    expect(s.first.activities, ['Paint', 'Write', 'Music']); // capped at 3
  });

  test('skips a day whose peak is busy, picks the next free day', () {
    final chris = _p(peakStart: '14:00', peakEnd: '18:00');
    final events = [_ev(DateTime(2026, 1, 1, 15), DateTime(2026, 1, 1, 16))];
    final s = suggestRebalance(starving: [chris], events: events, from: from);
    expect(s.first.slotStart, DateTime(2026, 1, 2, 14)); // day 0 busy → day 1
  });

  test('no suggestion when the persona has no peak window', () {
    final s = suggestRebalance(starving: [_p()], events: const [], from: from);
    expect(s, isEmpty);
  });

  test('no personas → no suggestions', () {
    expect(suggestRebalance(starving: const [], events: const [], from: from),
        isEmpty);
  });

  test('handles a midnight-crossing peak window', () {
    final nightOwl = _p(peakStart: '23:00', peakEnd: '02:00');
    final s = suggestRebalance(starving: [nightOwl], events: const [], from: from);
    expect(s.single.slotStart, DateTime(2026, 1, 1, 23));
    expect(s.single.slotEnd, DateTime(2026, 1, 2, 2)); // wraps to next day
  });
}
