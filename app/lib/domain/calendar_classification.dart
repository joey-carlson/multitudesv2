/// Work vs. personal calendar classification (heuristics-first).
library;

/// Metadata about a calendar exposed by a source.
class CalendarInfo {
  CalendarInfo({
    required this.id,
    required this.title,
    this.account,
    this.type,
  });

  final String id;
  final String title;

  /// Account/source name (e.g. an email, "iCloud", "Google").
  final String? account;

  /// Backend type (e.g. "exchange", "calDAV", "local", "birthday").
  final String? type;
}

/// How a calendar should be treated.
enum CalendarKind {
  work('Work'),
  personal('Personal'),
  ignore('Ignore'),
  unset('Unset');

  const CalendarKind(this.label);
  final String label;
}

const _workHints = ['work', 'outlook', 'office', 'exchange', 'corp', 'o365'];
const _personalHints = [
  'personal', 'home', 'family', 'icloud', 'gmail', 'birthday', 'holiday'
];

/// Best-guess classification for a calendar when the user hasn't set one.
/// Exchange-type calendars are treated as work; otherwise infer from the
/// account/title text; fall back to [CalendarKind.unset].
CalendarKind inferCalendarKind(CalendarInfo cal) {
  final type = cal.type?.toLowerCase() ?? '';
  if (type == 'exchange') return CalendarKind.work;
  if (type == 'birthday') return CalendarKind.personal;

  final haystack = '${cal.title} ${cal.account ?? ''}'.toLowerCase();
  if (_workHints.any(haystack.contains)) return CalendarKind.work;
  if (_personalHints.any(haystack.contains)) return CalendarKind.personal;
  return CalendarKind.unset;
}

/// The kind actually in effect: a user override wins, else the inference.
CalendarKind effectiveKind(CalendarInfo cal, Map<String, CalendarKind> overrides) {
  final override = overrides[cal.id];
  if (override != null && override != CalendarKind.unset) return override;
  return inferCalendarKind(cal);
}
