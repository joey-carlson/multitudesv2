import 'package:flutter/material.dart';

import '../data/calendar_source.dart';
import '../data/database.dart';
import '../domain/calendar_classification.dart';
import '../domain/calendar_event.dart';
import '../domain/calendar_matcher.dart';
import '../domain/persona.dart';
import 'calendars_settings_screen.dart';

/// Upcoming calendar events matched to the best-fit persona, with work/personal
/// labels. Ignored calendars are hidden; a filter narrows to Work or Personal.
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({
    super.key,
    required this.source,
    required this.personas,
    required this.db,
  });

  final CalendarSource source;
  final List<Persona> personas;
  final AppDatabase db;

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Future<_CalendarData> _future;
  CalendarKind? _filter; // null = all (work + personal + unset)

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_CalendarData> _load() async {
    final granted = await widget.source.requestAccess();
    if (!granted) return _CalendarData(granted: false, events: const [], kinds: const {});

    final calendars = await widget.source.listCalendars();
    final overrides = await widget.db.calendarKinds();
    final kinds = {
      for (final c in calendars) c.id: effectiveKind(c, overrides)
    };

    final now = DateTime.now();
    final events = await widget.source
        .eventsInRange(now, now.add(const Duration(days: 7)));
    return _CalendarData(granted: true, events: events, kinds: kinds);
  }

  Future<void> _openSettings() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => CalendarsSettingsScreen(source: widget.source, db: widget.db),
    ));
    setState(() => _future = _load());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Classify calendars',
            onPressed: _openSettings,
          ),
        ],
      ),
      body: FutureBuilder<_CalendarData>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snap.data!;
          if (!data.granted) {
            return const _Message(
                '🔒 Calendar access was denied.\nEnable it in system settings to see your events.');
          }

          CalendarKind kindOf(CalendarEvent e) => e.calendarId == null
              ? CalendarKind.unset
              : (data.kinds[e.calendarId] ?? CalendarKind.unset);

          // Hide ignored calendars, then apply the work/personal filter.
          final visible = data.events.where((e) {
            final k = kindOf(e);
            if (k == CalendarKind.ignore) return false;
            if (_filter == null) return true;
            return k == _filter;
          }).toList();

          return Column(
            children: [
              _FilterBar(
                filter: _filter,
                onChanged: (f) => setState(() => _filter = f),
              ),
              Expanded(
                child: visible.isEmpty
                    ? const _Message('No matching events in the next 7 days.')
                    : ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          if (!widget.source.isLive)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                'Showing ${widget.source.label.toLowerCase()} — '
                                'connect your device calendar to see real events.',
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 13),
                              ),
                            ),
                          for (final e in visible)
                            _EventCard(
                              event: e,
                              kind: kindOf(e),
                              matches:
                                  rankPersonasForEvent(e, widget.personas),
                            ),
                        ],
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CalendarData {
  _CalendarData({required this.granted, required this.events, required this.kinds});
  final bool granted;
  final List<CalendarEvent> events;
  final Map<String, CalendarKind> kinds;
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.filter, required this.onChanged});

  final CalendarKind? filter;
  final ValueChanged<CalendarKind?> onChanged;

  @override
  Widget build(BuildContext context) {
    Widget chip(String label, CalendarKind? value) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: FilterChip(
            label: Text(label),
            selected: filter == value,
            onSelected: (_) => onChanged(value),
          ),
        );
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          chip('All', null),
          chip('Work', CalendarKind.work),
          chip('Personal', CalendarKind.personal),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event, required this.kind, required this.matches});

  final CalendarEvent event;
  final CalendarKind kind;
  final List<PersonaMatch> matches;

  @override
  Widget build(BuildContext context) {
    final top = matches.isNotEmpty ? matches.first : null;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(event.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                if (kind == CalendarKind.work || kind == CalendarKind.personal)
                  _KindChip(kind: kind),
              ],
            ),
            const SizedBox(height: 2),
            Text(_when(event), style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 8),
            if (top == null)
              const Text('No persona matched',
                  style: TextStyle(color: Colors.grey))
            else
              _MatchLine(match: top),
          ],
        ),
      ),
    );
  }

  static String _when(CalendarEvent e) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    String two(int n) => n.toString().padLeft(2, '0');
    final d = e.start;
    return '${days[d.weekday - 1]} ${two(d.hour)}:${two(d.minute)}'
        '–${two(e.end.hour)}:${two(e.end.minute)}';
  }
}

class _KindChip extends StatelessWidget {
  const _KindChip({required this.kind});

  final CalendarKind kind;

  @override
  Widget build(BuildContext context) {
    final color = kind == CalendarKind.work ? Colors.indigo : Colors.teal;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(kind.label,
          style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}

class _MatchLine extends StatelessWidget {
  const _MatchLine({required this.match});

  final PersonaMatch match;

  @override
  Widget build(BuildContext context) {
    final (icon, note, color) = switch (match.stateAtEvent) {
      EnergyState.peak => ('✅', 'during their peak', Colors.green),
      EnergyState.trough => ('⚠️', 'during their low-energy trough', Colors.orange),
      EnergyState.recovery => ('🔋', 'during their recovery window', Colors.blue),
      EnergyState.neutral => ('•', 'outside their peak hours', Colors.grey),
    };
    return Row(
      children: [
        Chip(
          visualDensity: VisualDensity.compact,
          label: Text('${match.persona.emoji} ${match.persona.name}'),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text('$icon $note', style: TextStyle(color: color, fontSize: 13)),
        ),
      ],
    );
  }
}

class _Message extends StatelessWidget {
  const _Message(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(text, textAlign: TextAlign.center),
        ),
      );
}
