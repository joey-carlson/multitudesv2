import 'package:flutter/material.dart';

import '../data/calendar_source.dart';
import '../data/database.dart';
import '../domain/calendar_classification.dart';
import '../domain/correlation.dart';
import '../domain/energy_impact.dart';
import '../domain/calendar_matcher.dart';
import '../domain/persona.dart';

/// Correlation analytics (depth): shows what energizes vs. drains — average
/// energy impact grouped by persona, calendar type, and time of day, over a
/// window of recent + upcoming events. On-device.
class PatternsScreen extends StatefulWidget {
  const PatternsScreen({
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
  State<PatternsScreen> createState() => _PatternsScreenState();
}

class _PatternsScreenState extends State<PatternsScreen> {
  late final Future<_Patterns> _future = _load();

  Future<_Patterns> _load() async {
    final byPersona = <(String, int)>[];
    final byKind = <(String, int)>[];
    final byDaypart = <(String, int)>[];

    try {
      if (await widget.source.requestAccess()) {
        final calendars = await widget.source.listCalendars();
        final kindOverrides = await widget.db.calendarKinds();
        final kinds = {
          for (final c in calendars) c.id: effectiveKind(c, kindOverrides)
        };
        final hidden = await widget.db.hiddenEventIds();
        final overrides = await widget.db.eventPersonaMap();
        final learned = await widget.db.learnedTokensByPersona();
        final impacts = await widget.db.energyImpactMap();
        final now = DateTime.now();
        final events = await widget.source.eventsInRange(
            now.subtract(const Duration(days: 14)), now.add(const Duration(days: 7)));

        for (final e in events) {
          if (hidden.contains(e.id)) continue;
          final kind = e.calendarId == null
              ? CalendarKind.unset
              : (kinds[e.calendarId] ?? CalendarKind.unset);
          if (kind == CalendarKind.ignore) continue;

          final persona = effectivePersonaForEvent(e, widget.personas, overrides,
              eventKind: kind, learnedByPersona: learned);
          final impact = impacts.containsKey(e.id)
              ? EnergyImpact.fromValue(impacts[e.id]!).value
              : estimateEnergyImpact(persona, e.start).value;

          if (persona != null) {
            byPersona.add(('${persona.emoji} ${persona.name}', impact));
          }
          if (kind == CalendarKind.work) {
            byKind.add(('Work', impact));
          } else if (kind == CalendarKind.personal) {
            byKind.add(('Personal', impact));
          }
          byDaypart.add((partOfDay(e.start.hour), impact));
        }
      }
    } catch (_) {
      // Calendar unavailable — sections just won't have data.
    }

    return _Patterns(
      persona: averageImpactByKey(byPersona, minCount: 2),
      kind: averageImpactByKey(byKind, minCount: 2),
      daypart: averageImpactByKey(byDaypart, minCount: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patterns')),
      body: FutureBuilder<_Patterns>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final p = snap.data!;
          if (p.persona.isEmpty && p.kind.isEmpty && p.daypart.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  'Not enough data yet.\nRate a few events energizing/draining and '
                  'check back — patterns appear as data builds.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Average energy impact (−2 draining … +2 energizing) over the '
                'last 2 weeks and the week ahead.',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              _section('By persona', p.persona),
              _section('By calendar', p.kind),
              _section('By time of day', p.daypart),
            ],
          );
        },
      ),
    );
  }

  Widget _section(String title, List<ImpactAverage<String>> rows) {
    if (rows.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          for (final r in rows) _ImpactRow(r),
        ],
      ),
    );
  }
}

class _Patterns {
  _Patterns({required this.persona, required this.kind, required this.daypart});
  final List<ImpactAverage<String>> persona;
  final List<ImpactAverage<String>> kind;
  final List<ImpactAverage<String>> daypart;
}

class _ImpactRow extends StatelessWidget {
  const _ImpactRow(this.r);
  final ImpactAverage<String> r;

  @override
  Widget build(BuildContext context) {
    final color = r.avg > 0.25
        ? Colors.green
        : r.avg < -0.25
            ? Colors.deepOrange
            : Colors.blueGrey;
    final sign = r.avg >= 0 ? '+' : '';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(r.key)),
          Text('$sign${r.avg.toStringAsFixed(1)}',
              style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Text('(${r.count})',
              style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        ],
      ),
    );
  }
}
