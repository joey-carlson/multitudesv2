/// Habits (engagement layer): small recurring actions that nourish a persona,
/// with a daily check-off and a streak. On-device.
library;

class Habit {
  Habit({
    this.id,
    required this.userId,
    required this.personaId,
    required this.title,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  final String? id;
  final String userId;
  final String personaId;
  final String title;
  final DateTime createdAt;
}

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// Consecutive-day streak of [completedDays], ending today (or yesterday if
/// today isn't checked off yet, so a streak doesn't reset mid-day). 0 if the
/// most recent completion is older than yesterday.
int currentStreak(Set<DateTime> completedDays, {required DateTime today}) {
  final days = completedDays.map(_dateOnly).toSet();
  final t = _dateOnly(today);
  // Step by calendar day (DateTime normalizes day-1), not a fixed 24h, so the
  // walk stays on date-only midnights across DST transitions.
  final yesterday = DateTime(t.year, t.month, t.day - 1);

  DateTime? anchor;
  if (days.contains(t)) {
    anchor = t;
  } else if (days.contains(yesterday)) {
    anchor = yesterday;
  }
  if (anchor == null) return 0;

  var streak = 0;
  var cur = anchor;
  while (days.contains(cur)) {
    streak++;
    cur = DateTime(cur.year, cur.month, cur.day - 1);
  }
  return streak;
}

/// Whether the habit is checked off for [today].
bool doneToday(Set<DateTime> completedDays, {required DateTime today}) =>
    completedDays.map(_dateOnly).contains(_dateOnly(today));
