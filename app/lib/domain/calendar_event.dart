/// A calendar event, independent of where it came from (device EventKit, an
/// imported file, or a sample source).
library;

class CalendarEvent {
  CalendarEvent({
    required this.id,
    required this.title,
    required this.start,
    required this.end,
    this.notes,
    this.calendarName,
    this.allDay = false,
  });

  final String id;
  final String title;
  final DateTime start;
  final DateTime end;
  final String? notes;
  final String? calendarName;
  final bool allDay;

  Duration get duration => end.difference(start);
}
