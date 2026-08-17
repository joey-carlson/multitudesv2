import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/domain/calendar_event.dart';
import 'package:multitudes/domain/calendar_matcher.dart';
import 'package:multitudes/domain/persona.dart';
import 'package:multitudes/domain/persona_generator.dart';

CalendarEvent _event(String title, {String? notes, DateTime? start}) =>
    CalendarEvent(
      id: 'e',
      title: title,
      notes: notes,
      start: start ?? DateTime(2026, 1, 1, 8),
      end: (start ?? DateTime(2026, 1, 1, 8)).add(const Duration(hours: 1)),
    );

void main() {
  // A Professional (peak 07:00–09:00) and an Artist from the shared generator.
  final personas = generatePersonasFromSurvey('u1', {
    'archetypes_selection': [
      '🧠 The Professional - Responsible, structured, goal-focused',
      '🎨 The Artist - Expressive, introspective, imaginative',
    ],
    'overall_energy_pattern': 'Early morning (7am-9am) - Pre-business hours',
  });

  test('financial/admin event ranks Professional first', () {
    final matches = rankPersonasForEvent(
      _event('Quarterly financial report',
          notes: 'administrative summary and scheduling'),
      personas,
    );
    expect(matches.first.persona.archetype, PersonaArchetype.professional);
  });

  test('creative event ranks Artist first', () {
    final matches = rankPersonasForEvent(
      _event('Creative writing and visual design studio'),
      personas,
    );
    expect(matches.first.persona.archetype, PersonaArchetype.artist);
  });

  test('unmatched event yields no matches', () {
    final matches = rankPersonasForEvent(_event('Dentist appointment'), personas);
    expect(matches, isEmpty);
  });

  test('timing flag reflects the persona peak window', () {
    // Professional peak is 07:00–09:00; an 08:00 event is well-timed.
    final wellTimed = rankPersonasForEvent(
      _event('Financial planning', start: DateTime(2026, 1, 1, 8)),
      personas,
    ).first;
    expect(wellTimed.wellTimed, isTrue);

    // A 20:00 event is outside peak → not well-timed.
    final offPeak = rankPersonasForEvent(
      _event('Financial planning', start: DateTime(2026, 1, 1, 20)),
      personas,
    ).first;
    expect(offPeak.wellTimed, isFalse);
  });
}
