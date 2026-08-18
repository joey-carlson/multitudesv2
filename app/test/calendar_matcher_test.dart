import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/domain/calendar_classification.dart';
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

  // Personas with ids (as loaded from the DB) for override/attribution tests.
  Persona pid(String id, PersonaArchetype a, List<String> tasks) => Persona(
        id: id,
        userId: 'u',
        name: id,
        emoji: '🧩',
        archetype: a,
        primaryEnergy: '',
        strengths: const [],
        weaknesses: const [],
        triggerConditions: const [],
        idealTasks: tasks,
      );
  final withIds = [
    pid('pa', PersonaArchetype.professional, ['Financial decisions']),
    pid('pb', PersonaArchetype.artist, ['Creative writing']),
  ];

  group('effectivePersonaForEvent', () {
    test('manual override wins over auto-match', () {
      final e = _event('Creative writing'); // auto-matches pb
      expect(effectivePersonaForEvent(e, withIds, const {})!.id, 'pb');
      expect(effectivePersonaForEvent(e, withIds, {e.id: 'pa'})!.id, 'pa');
    });

    test('no match and no override -> null', () {
      expect(effectivePersonaForEvent(_event('Dentist'), withIds, const {}),
          isNull);
    });
  });

  test('calendarHoursByPersona attributes via effective persona, skipping '
      'hidden and ignored', () {
    CalendarEvent ev(String id, String title, int calDayHour,
            {String? calId}) =>
        CalendarEvent(
          id: id,
          title: title,
          start: DateTime(2026, 1, 1, calDayHour),
          end: DateTime(2026, 1, 1, calDayHour + 1), // 1 hour each
          calendarId: calId,
        );

    final events = [
      ev('e1', 'Financial report', 8, calId: 'cal-work'), // auto -> pa
      ev('e2', 'Mystery block', 10, calId: 'cal-work'), // override -> pb
      ev('e3', 'Financial report', 12, calId: 'cal-work'), // hidden
      ev('e4', 'Financial report', 14, calId: 'cal-ignore'), // ignored cal
    ];

    final hours = calendarHoursByPersona(
      events: events,
      personas: withIds,
      overrides: {'e2': 'pb'},
      hiddenEventIds: {'e3'},
      kindByCalendarId: {'cal-ignore': CalendarKind.ignore},
    );

    expect(hours['pa'], closeTo(1.0, 1e-9)); // only e1
    expect(hours['pb'], closeTo(1.0, 1e-9)); // only e2
  });

  group('lexicon + priors', () {
    test('archetype lexicon matches typical work titles', () {
      final personas = [
        pid('pa', PersonaArchetype.professional, const []),
        pid('pb', PersonaArchetype.artist, const []),
      ];
      // "standup"/"meeting" aren't in the persona's own words — lexicon catches.
      final m = rankPersonasForEvent(_event('Team standup meeting'), personas);
      expect(m.first.persona.archetype, PersonaArchetype.professional);
    });

    test('personal lexicon (gym) matches the inner-child persona', () {
      final personas = [
        pid('pa', PersonaArchetype.professional, const []),
        pid('pi', PersonaArchetype.innerChild, const []),
      ];
      final m = rankPersonasForEvent(_event('Morning gym session'), personas);
      expect(m.first.persona.archetype, PersonaArchetype.innerChild);
    });

    test('domain prior: a work calendar favors the work-domain persona', () {
      // "review" is in both professional and historian lexicons.
      final personas = [
        pid('ph', PersonaArchetype.historian, const []),
        pid('pp', PersonaArchetype.professional, const []),
      ];
      final m = rankPersonasForEvent(
        _event('Weekly review'),
        personas,
        eventKind: CalendarKind.work,
      );
      expect(m.first.persona.archetype, PersonaArchetype.professional);
    });
  });
}
