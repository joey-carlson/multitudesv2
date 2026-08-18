/// Where calendar events come from. Abstracted so the app can use the device
/// calendar (native EventKit) where available and fall back to a sample source
/// on platforms/permissions where it isn't — keeping the UI and matching logic
/// source-agnostic.
library;

import 'dart:io' show Platform;

import 'package:flutter/services.dart';

import '../domain/calendar_classification.dart';
import '../domain/calendar_event.dart';

/// Picks the best available calendar source for the current platform: the
/// device calendar where a native binding exists (macOS today), otherwise the
/// sample source so the feature is always usable.
CalendarSource resolveCalendarSource() {
  try {
    if (Platform.isMacOS) return DeviceCalendarSource();
  } catch (_) {
    // Platform unavailable (e.g. tests/web) — fall through to sample.
  }
  return SampleCalendarSource();
}

abstract class CalendarSource {
  /// Human label shown in the UI (e.g. "Sample calendar", "Device calendar").
  String get label;

  /// Whether this is real user data (vs. demo/sample content).
  bool get isLive;

  /// Request any needed permission. Returns true if events can be read.
  Future<bool> requestAccess();

  /// The calendars available from this source.
  Future<List<CalendarInfo>> listCalendars();

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
  Future<List<CalendarInfo>> listCalendars() async => [
        CalendarInfo(
            id: 'cal-work',
            title: 'Work',
            account: 'work@example.com',
            type: 'exchange'),
        CalendarInfo(
            id: 'cal-personal',
            title: 'Personal',
            account: 'iCloud',
            type: 'calDAV'),
        CalendarInfo(
            id: 'cal-home', title: 'Home', account: 'iCloud', type: 'calDAV'),
      ];

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
        calendarId: 'cal-work',
      ),
      CalendarEvent(
        id: 's2',
        title: 'Creative writing session',
        notes: 'Draft the short story; music and quiet.',
        start: at(0, 9),
        end: at(0, 10, 30),
        calendarName: 'Personal',
        calendarId: 'cal-personal',
      ),
      CalendarEvent(
        id: 's3',
        title: 'Team standup meeting',
        notes: 'Scheduling and planning for the sprint.',
        start: at(1, 10),
        end: at(1, 10, 30),
        calendarName: 'Work',
        calendarId: 'cal-work',
      ),
      CalendarEvent(
        id: 's4',
        title: 'Fix the deck railing',
        notes: 'Hands-on repairs; tools in the garage.',
        start: at(1, 15),
        end: at(1, 17),
        calendarName: 'Home',
        calendarId: 'cal-home',
      ),
      CalendarEvent(
        id: 's5',
        title: 'Security audit preparation',
        notes: 'Risk assessment and emergency preparation review.',
        start: at(2, 7),
        end: at(2, 8),
        calendarName: 'Work',
        calendarId: 'cal-work',
      ),
    ];

    return samples
        .where((e) => e.end.isAfter(start) && e.start.isBefore(end))
        .toList()
      ..sort((a, b) => a.start.compareTo(b.start));
  }
}

/// Reads the OS calendar via a native EventKit method channel (macOS).
/// Fails safe: returns false/empty if the channel is missing or access denied.
class DeviceCalendarSource implements CalendarSource {
  static const _channel = MethodChannel('multitudes/calendar');

  @override
  String get label => 'Device calendar';

  @override
  bool get isLive => true;

  @override
  Future<bool> requestAccess() async {
    try {
      return await _channel.invokeMethod<bool>('requestAccess') ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<CalendarInfo>> listCalendars() async {
    try {
      final raw = await _channel.invokeMethod<List<dynamic>>('listCalendars');
      final out = <CalendarInfo>[];
      for (final item in raw ?? const []) {
        // Skip a malformed item rather than dropping the whole list.
        try {
          final m = (item as Map).cast<String, dynamic>();
          final id = m['id'] as String?;
          if (id == null) continue;
          out.add(CalendarInfo(
            id: id,
            title: (m['title'] as String?) ?? '(untitled)',
            account: m['account'] as String?,
            type: m['type'] as String?,
          ));
        } catch (_) {
          continue;
        }
      }
      return out;
    } catch (_) {
      return const [];
    }
  }

  @override
  Future<List<CalendarEvent>> eventsInRange(DateTime start, DateTime end) async {
    try {
      final raw = await _channel.invokeMethod<List<dynamic>>('eventsInRange', {
        'startMs': start.millisecondsSinceEpoch,
        'endMs': end.millisecondsSinceEpoch,
      });
      final out = <CalendarEvent>[];
      for (final item in raw ?? const []) {
        // One malformed event (missing id/times) shouldn't blank the calendar.
        try {
          final m = (item as Map).cast<String, dynamic>();
          final id = m['id'] as String?;
          final startMs = m['startMs'] as int?;
          final endMs = m['endMs'] as int?;
          if (id == null || startMs == null || endMs == null) continue;
          final title = m['title'] as String?;
          out.add(CalendarEvent(
            id: id,
            title: (title != null && title.isNotEmpty) ? title : '(untitled)',
            notes: m['notes'] as String?,
            start: DateTime.fromMillisecondsSinceEpoch(startMs),
            end: DateTime.fromMillisecondsSinceEpoch(endMs),
            allDay: (m['allDay'] as bool?) ?? false,
            calendarName: m['calendar'] as String?,
            calendarId: m['calendarId'] as String?,
          ));
        } catch (_) {
          continue;
        }
      }
      return out;
    } catch (_) {
      return const [];
    }
  }
}
