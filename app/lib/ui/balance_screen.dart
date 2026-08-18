import 'package:flutter/material.dart';

import '../data/calendar_source.dart';
import '../data/database.dart';
import '../domain/balance_trend.dart';
import '../domain/calendar_classification.dart';
import '../domain/calendar_event.dart';
import '../domain/calendar_matcher.dart';
import '../domain/persona.dart';

/// Persona feeding dashboard: which personas are fed, over-fed, or starving.
/// "Actual" hours combine tasks completed in the last 7 days with calendar time
/// attributed to each persona (auto-matched or manually assigned) over the next
/// 7 days — so assigning a persona to an event visibly feeds it.
class BalanceScreen extends StatefulWidget {
  const BalanceScreen({
    super.key,
    required this.personas,
    required this.db,
    required this.userId,
    required this.source,
  });

  final List<Persona> personas;
  final AppDatabase db;
  final String userId;
  final CalendarSource source;

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  late Future<_BalanceData> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  /// Computes both the current "actual" hours per persona (tasks last 7d +
  /// calendar next 7d, drives fed/starving) and a trend per persona (recent 7d
  /// vs prior 7d, from completed tasks + past calendar).
  Future<_BalanceData> _load() async {
    final now = DateTime.now();

    // Current actual (drives fed/starving): tasks last 7d + upcoming calendar.
    final actual =
        Map<String, double>.from(await widget.db.actualWeeklyHours(widget.userId));

    // Trend windows from completed tasks (recent = last 7d, prior = 8–14d ago).
    final taskRecent = await widget.db.actualWeeklyHours(widget.userId);
    final taskLast14 = await widget.db
        .actualWeeklyHours(widget.userId, since: now.subtract(const Duration(days: 14)));
    final recent = Map<String, double>.from(taskRecent);
    final prior = <String, double>{};
    for (final e in taskLast14.entries) {
      prior[e.key] = (e.value - (taskRecent[e.key] ?? 0)).clamp(0, double.infinity);
    }

    try {
      if (await widget.source.requestAccess()) {
        final calendars = await widget.source.listCalendars();
        final overrides = await widget.db.calendarKinds();
        final kinds = {
          for (final c in calendars) c.id: effectiveKind(c, overrides)
        };
        final hidden = await widget.db.hiddenEventIds();
        final assignments = await widget.db.eventPersonaMap();
        final learned = await widget.db.learnedTokensByPersona();

        Map<String, double> attribute(List<CalendarEvent> events) =>
            calendarHoursByPersona(
              events: events,
              personas: widget.personas,
              overrides: assignments,
              hiddenEventIds: hidden,
              kindByCalendarId: kinds,
              learnedByPersona: learned,
            );

        // Upcoming calendar → current actual.
        final upcoming =
            await widget.source.eventsInRange(now, now.add(const Duration(days: 7)));
        attribute(upcoming).forEach((pid, h) => actual[pid] = (actual[pid] ?? 0) + h);

        // Past 14 days → split into recent / prior for the trend.
        final past = await widget.source
            .eventsInRange(now.subtract(const Duration(days: 14)), now);
        final cutoff = now.subtract(const Duration(days: 7));
        attribute(past.where((e) => !e.start.isBefore(cutoff)).toList())
            .forEach((pid, h) => recent[pid] = (recent[pid] ?? 0) + h);
        attribute(past.where((e) => e.start.isBefore(cutoff)).toList())
            .forEach((pid, h) => prior[pid] = (prior[pid] ?? 0) + h);
      }
    } catch (_) {
      // Calendar unavailable — task-only hours/trends.
    }

    final trend = <String, TrendDirection>{};
    for (final p in widget.personas) {
      if (p.id == null) continue;
      trend[p.id!] =
          classifyTrend(recent[p.id] ?? 0, prior[p.id] ?? 0);
    }
    return _BalanceData(actual: actual, trend: trend);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Are your personas fed?')),
      body: FutureBuilder<_BalanceData>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snap.data;
          final actualByPersona = data?.actual ?? const {};
          final trendByPersona = data?.trend ?? const {};

          // Attention-first: starving, then over-fed, fed, none.
          final rows = [
            for (final p in widget.personas)
              (persona: p, actual: actualByPersona[p.id] ?? 0.0)
          ]..sort((a, b) => _priority(a.persona.fedState(a.actual))
              .compareTo(_priority(b.persona.fedState(b.actual))));

          final counts = <FedState, int>{};
          for (final r in rows) {
            final s = r.persona.fedState(r.actual);
            counts[s] = (counts[s] ?? 0) + 1;
          }
          final fallingWhileLow = rows
              .where((r) =>
                  trendByPersona[r.persona.id] == TrendDirection.falling &&
                  r.persona.fedState(r.actual) != FedState.overFed)
              .length;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _SummaryCard(counts: counts),
              const SizedBox(height: 8),
              Text(
                'Combines tasks completed in the last 7 days with calendar time '
                'assigned to each persona over the next 7 days. The trend arrow '
                'compares the last 7 days to the 7 before.',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              if (fallingWhileLow > 0) ...[
                const SizedBox(height: 6),
                Text(
                  '↓ $fallingWhileLow persona${fallingWhileLow == 1 ? '' : 's'} '
                  'getting less attention than before.',
                  style: const TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ],
              const SizedBox(height: 8),
              for (final r in rows)
                _BalanceRow(
                    persona: r.persona,
                    actual: r.actual,
                    trend: trendByPersona[r.persona.id] ?? TrendDirection.steady),
            ],
          );
        },
      ),
    );
  }

  static int _priority(FedState s) => switch (s) {
        FedState.starving => 0,
        FedState.overFed => 1,
        FedState.fed => 2,
        FedState.noTarget => 3,
      };
}

Color _colorFor(FedState s) => switch (s) {
      FedState.starving => Colors.red,
      FedState.overFed => Colors.orange,
      FedState.fed => Colors.green,
      FedState.noTarget => Colors.grey,
    };

class _BalanceData {
  _BalanceData({required this.actual, required this.trend});
  final Map<String, double> actual;
  final Map<String, TrendDirection> trend;
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.counts});

  final Map<FedState, int> counts;

  @override
  Widget build(BuildContext context) {
    final starving = counts[FedState.starving] ?? 0;
    final headline = starving > 0
        ? '🍽️ $starving persona${starving == 1 ? '' : 's'} starving'
        : '🎉 Your personas are in balance';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(headline,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final s in FedState.values)
                  if ((counts[s] ?? 0) > 0)
                    Chip(
                      visualDensity: VisualDensity.compact,
                      avatar: CircleAvatar(
                          backgroundColor: _colorFor(s), radius: 6),
                      label: Text('${counts[s]} ${s.label}'),
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceRow extends StatelessWidget {
  const _BalanceRow(
      {required this.persona, required this.actual, required this.trend});

  final Persona persona;
  final double actual;
  final TrendDirection trend;

  @override
  Widget build(BuildContext context) {
    final ideal = persona.idealWeeklyHours;
    final state = persona.fedState(actual);
    final color = _colorFor(state);
    final progress = ideal > 0 ? (actual / ideal).clamp(0.0, 1.0) : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('${persona.emoji}  ${persona.name}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(width: 6),
              Tooltip(
                message: 'Attention ${trend.label} vs. the prior week',
                child: Text(trend.arrow,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: switch (trend) {
                          TrendDirection.rising => Colors.green,
                          TrendDirection.falling => Colors.orange,
                          TrendDirection.steady => Colors.grey,
                        })),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(state.label,
                    style: TextStyle(
                        color: color, fontWeight: FontWeight.w600, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              color: color,
              backgroundColor: color.withValues(alpha: 0.12),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ideal > 0
                ? '${actual.toStringAsFixed(1)} / ${ideal.toStringAsFixed(0)} hrs this week'
                : '${actual.toStringAsFixed(1)} hrs this week · no weekly target set',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
        ],
      ),
    );
  }
}
