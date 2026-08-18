import 'package:flutter/material.dart';

import '../data/calendar_source.dart';
import '../data/database.dart';
import '../domain/calendar_classification.dart';
import '../domain/calendar_event.dart';
import '../domain/calendar_matcher.dart';
import '../domain/persona.dart';
import '../domain/persona_suggestions.dart';
import '../domain/rebalance_suggestion.dart';
import 'add_persona_screen.dart';

/// Coaching insights (roadmap F5): suggests new personas the user seems to be
/// missing (from clusters of unmatched calendar events) and peak-time
/// adjustments (from energy check-ins). Suggestions require the user's approval.
class InsightsScreen extends StatefulWidget {
  const InsightsScreen({
    super.key,
    required this.personas,
    required this.db,
    required this.userId,
    required this.source,
    this.onChanged,
  });

  final List<Persona> personas;
  final AppDatabase db;
  final String userId;
  final CalendarSource source;
  final VoidCallback? onChanged;

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  late Future<_Insights> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  void _reload() => setState(() => _future = _load());

  Future<_Insights> _load() async {
    final unmatched = <CalendarEvent>[];
    final rebalance = <RebalanceSuggestion>[];
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
        final now = DateTime.now();
        final events = await widget.source
            .eventsInRange(now, now.add(const Duration(days: 7)));

        final visible = <CalendarEvent>[];
        for (final e in events) {
          if (hidden.contains(e.id)) continue;
          final kind = e.calendarId == null
              ? CalendarKind.unset
              : (kinds[e.calendarId] ?? CalendarKind.unset);
          if (kind == CalendarKind.ignore) continue;
          visible.add(e);
          final persona = effectivePersonaForEvent(e, widget.personas, overrides,
              eventKind: kind, learnedByPersona: learned);
          if (persona == null) unmatched.add(e);
        }

        // Actual weekly hours (tasks + calendar) → who is starving.
        final actual =
            Map<String, double>.from(await widget.db.actualWeeklyHours(widget.userId));
        final calHours = calendarHoursByPersona(
          events: events,
          personas: widget.personas,
          overrides: overrides,
          hiddenEventIds: hidden,
          kindByCalendarId: kinds,
          learnedByPersona: learned,
        );
        calHours.forEach((pid, h) => actual[pid] = (actual[pid] ?? 0) + h);
        final starving = widget.personas
            .where((p) =>
                p.id != null && p.fedState(actual[p.id] ?? 0) == FedState.starving)
            .toList();
        rebalance.addAll(
            suggestRebalance(starving: starving, events: visible, from: now));
      }
    } catch (_) {
      // Calendar unavailable — calendar-derived suggestions just won't appear.
    }

    final archetypes = suggestNewArchetypes(
        personas: widget.personas, unmatchedEvents: unmatched);

    final peaks = <PeakAdjustmentSuggestion>[];
    try {
      for (final p in widget.personas) {
        if (p.id == null) continue;
        final readings = await widget.db.recentReadings(p.id!, limit: 200);
        final s = suggestPeakAdjustment(p, readings);
        if (s != null) peaks.add(s);
      }
    } catch (_) {
      // Reading history unavailable — skip peak suggestions rather than fail.
    }

    return _Insights(archetypes: archetypes, peaks: peaks, rebalance: rebalance);
  }

  Future<void> _addArchetype(PersonaArchetype a) async {
    final added = await Navigator.of(context).push<bool>(MaterialPageRoute(
      builder: (_) => AddPersonaScreen(
          db: widget.db, userId: widget.userId, initialArchetype: a),
    ));
    if (added == true) {
      widget.onChanged?.call();
      if (mounted) _reload();
    }
  }

  Future<void> _applyPeak(PeakAdjustmentSuggestion s) async {
    final p = s.persona;
    await widget.db.updatePersona(Persona(
      id: p.id,
      userId: p.userId,
      name: p.name,
      emoji: p.emoji,
      archetype: p.archetype,
      primaryEnergy: p.primaryEnergy,
      strengths: p.strengths,
      weaknesses: p.weaknesses,
      triggerConditions: p.triggerConditions,
      idealTasks: p.idealTasks,
      peakStartTime: s.suggestedStart,
      peakEndTime: s.suggestedEnd,
      troughStartTime: p.troughStartTime,
      troughEndTime: p.troughEndTime,
      recoveryStartTime: p.recoveryStartTime,
      recoveryEndTime: p.recoveryEndTime,
      idealWeeklyHours: p.idealWeeklyHours,
      actualWeeklyHours: p.actualWeeklyHours,
      isActive: p.isActive,
    ));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Updated ${p.name}'s peak window")));
    widget.onChanged?.call();
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insights')),
      body: FutureBuilder<_Insights>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snap.data;
          if (data == null ||
              (data.archetypes.isEmpty &&
                  data.peaks.isEmpty &&
                  data.rebalance.isEmpty)) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  'No suggestions yet.\nKeep assigning events and logging energy — '
                  'suggestions appear as patterns emerge.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (data.archetypes.isNotEmpty) ...[
                const _SectionTitle('Personas to consider'),
                for (final a in data.archetypes)
                  _ArchetypeCard(a, onAdd: () => _addArchetype(a.archetype)),
              ],
              if (data.peaks.isNotEmpty) ...[
                const _SectionTitle('Peak-time adjustments'),
                for (final p in data.peaks)
                  _PeakCard(p, onApply: () => _applyPeak(p)),
              ],
              if (data.rebalance.isNotEmpty) ...[
                const _SectionTitle('Feed a starving persona'),
                for (final r in data.rebalance) _RebalanceCard(r),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _Insights {
  _Insights({
    required this.archetypes,
    required this.peaks,
    required this.rebalance,
  });
  final List<ArchetypeSuggestion> archetypes;
  final List<PeakAdjustmentSuggestion> peaks;
  final List<RebalanceSuggestion> rebalance;
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 6),
        child: Text(text,
            style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      );
}

class _ArchetypeCard extends StatelessWidget {
  const _ArchetypeCard(this.s, {required this.onAdd});
  final ArchetypeSuggestion s;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final t = archetypeTemplates[s.archetype]!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('${t.emoji}  ${t.defaultName}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const Spacer(),
                FilledButton(onPressed: onAdd, child: const Text('Add')),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${s.matchCount} unmatched event${s.matchCount == 1 ? '' : 's'} '
              'look like this — e.g. ${s.sampleTitles.join(", ")}.',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

class _RebalanceCard extends StatelessWidget {
  const _RebalanceCard(this.s);
  final RebalanceSuggestion s;

  @override
  Widget build(BuildContext context) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    String two(int n) => n.toString().padLeft(2, '0');
    final d = s.slotStart;
    final when =
        '${days[d.weekday - 1]} ${two(d.hour)}:${two(d.minute)}–${two(s.slotEnd.hour)}:${two(s.slotEnd.minute)}';
    final acts = s.activities.isEmpty
        ? 'something that recharges them'
        : s.activities.join(', ');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${s.persona.emoji}  ${s.persona.name}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Free in their peak: $when. Try: $acts.',
                style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }
}

class _PeakCard extends StatelessWidget {
  const _PeakCard(this.s, {required this.onApply});
  final PeakAdjustmentSuggestion s;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    final current = (s.persona.peakStartTime != null)
        ? '${s.persona.peakStartTime}–${s.persona.peakEndTime}'
        : 'unset';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('${s.persona.emoji}  ${s.persona.name}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const Spacer(),
                FilledButton(onPressed: onApply, child: const Text('Apply')),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Your check-ins (${s.basedOnReadings}) show high energy around '
              '${s.suggestedStart}. Shift peak $current → '
              '${s.suggestedStart}–${s.suggestedEnd}?',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
