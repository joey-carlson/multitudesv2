/// A task assigned to a persona — a focused Dart port of the Task concept in
/// src/shared/database/models.py.
library;

class Task {
  Task({
    this.id,
    required this.userId,
    required this.personaId,
    required this.title,
    this.energyRequired = 3,
    this.priority = 3,
    this.estimatedMinutes = 30,
    this.completed = false,
    this.completedAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Local database id — null until stored.
  final String? id;
  final String userId;
  final String personaId;
  final String title;

  /// 1–5 scale.
  final int energyRequired;

  /// 1–5 scale.
  final int priority;

  /// Estimated effort; drives the "actual hours" feeding the balance view.
  final int estimatedMinutes;
  final bool completed;
  final DateTime? completedAt;
  final DateTime createdAt;
}
