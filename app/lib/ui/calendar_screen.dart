import 'package:flutter/material.dart';

import '../data/calendar_source.dart';
import '../domain/calendar_event.dart';
import '../domain/calendar_matcher.dart';
import '../domain/persona.dart';

/// Shows upcoming calendar events, each matched to the best-fit persona(s) and
/// flagged for whether it's scheduled during that persona's strong hours.
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({
    super.key,
    required this.source,
    required this.personas,
  });

  final CalendarSource source;
  final List<Persona> personas;

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Future<_CalendarData> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_CalendarData> _load() async {
    final granted = await widget.source.requestAccess();
    if (!granted) return _CalendarData(granted: false, events: const []);
    final now = DateTime.now();
    final events = await widget.source
        .eventsInRange(now, now.add(const Duration(days: 7)));
    return _CalendarData(granted: true, events: events);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
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
          if (data.events.isEmpty) {
            return const _Message('No events in the next 7 days.');
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (!widget.source.isLive)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Showing ${widget.source.label.toLowerCase()} — connect your '
                    'device calendar to see real events.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ),
              for (final e in data.events)
                _EventCard(
                  event: e,
                  matches: rankPersonasForEvent(e, widget.personas),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _CalendarData {
  _CalendarData({required this.granted, required this.events});
  final bool granted;
  final List<CalendarEvent> events;
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event, required this.matches});

  final CalendarEvent event;
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
            Text(event.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
          child: Text('$icon $note',
              style: TextStyle(color: color, fontSize: 13)),
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
