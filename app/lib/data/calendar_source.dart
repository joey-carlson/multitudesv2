/// Where calendar events come from. Abstracted so the app can use the device
/// calendar (native EventKit) where available and fall back to a sample source
/// on platforms/permissions where it isn't — keeping the UI and matching logic
/// source-agnostic.
library;

import '../domain/calendar_event.dart';

abstract class CalendarSource {
  /// Human label shown in the UI (e.g. "Sample calendar", "Device calendar").
  String get label;

  /// Whether this is real user data (vs. demo/sample content).
  bool get isLive;

  /// Request any needed permission. Returns true if events can be read.
  Future<bool> requestAccess();

  /// Events overlapping [start, end].
  Future<List<CalendarEvent>> eventsInRange(DateTime start, DateTime end);
}

/// Demo calendar so the feature is usable on any platform without permissions.
/// Events are anchored to the requested range so they always appear "upcoming".
class SampleCalendarSource implements CalendarSource {
  @override
  String get label => 'Sample calendar';

  @override
  bool get isLive => false;

  @override
  Future<bool> requestAccess() async => true;

  @override
  Future<List<CalendarEvent>> eventsInRange(DateTime start, DateTime end) async {
    final day0 = DateTime(start.year, start.month, start.day);
    DateTime at(int dayOffset, int hour, [int minute = 0]) =>
        day0.add(Duration(days: dayOffset, hours: hour, minutes: minute));

    final samples = <CalendarEvent>[
      CalendarEvent(
        id: 's1',
        title: 'Quarterly financial report review',
        notes: 'Prep numbers and administrative summary for leadership.',
        start: at(0, 8),
        end: at(0, 9, 30),
        calendarName: 'Work',
      ),
      CalendarEvent(
        id: 's2',
        title: 'Creative writing session',
        notes: 'Draft the short story; music and quiet.',
        start: at(0, 9),
        end: at(0, 10, 30),
        calendarName: 'Personal',
      ),
      CalendarEvent(
        id: 's3',
        title: 'Team standup meeting',
        notes: 'Scheduling and planning for the sprint.',
        start: at(1, 10),
        end: at(1, 10, 30),
        calendarName: 'Work',
      ),
      CalendarEvent(
        id: 's4',
        title: 'Fix the deck railing',
        notes: 'Hands-on repairs; tools in the garage.',
        start: at(1, 15),
        end: at(1, 17),
        calendarName: 'Home',
      ),
      CalendarEvent(
        id: 's5',
        title: 'Security audit preparation',
        notes: 'Risk assessment and emergency preparation review.',
        start: at(2, 7),
        end: at(2, 8),
        calendarName: 'Work',
      ),
    ];

    return samples
        .where((e) => e.end.isAfter(start) && e.start.isBefore(end))
        .toList()
      ..sort((a, b) => a.start.compareTo(b.start));
  }
}
