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
  CalendarKind? _filter; // null = all (work + personal + unset)
  bool _showHidden = false;

  bool _loading = true;
  bool _granted = true;
  List<CalendarEvent> _events = const [];
  Map<String, CalendarKind> _kinds = const {};
  final Set<String> _hidden = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final granted = await widget.source.requestAccess();
    if (!granted) {
      if (mounted) {
        setState(() {
          _granted = false;
          _loading = false;
        });
      }
      return;
    }

    final calendars = await widget.source.listCalendars();
    final overrides = await widget.db.calendarKinds();
    final kinds = {
      for (final c in calendars) c.id: effectiveKind(c, overrides)
    };
    final hidden = await widget.db.hiddenEventIds();
    final now = DateTime.now();
    final events = await widget.source
        .eventsInRange(now, now.add(const Duration(days: 7)));

    if (!mounted) return;
    setState(() {
      _granted = true;
      _events = events;
      _kinds = kinds;
      _hidden
        ..clear()
        ..addAll(hidden);
      _loading = false;
    });
  }

  // Optimistic: update the visible list immediately, then persist.
  Future<void> _setHidden(CalendarEvent e, bool hidden) async {
    setState(() => hidden ? _hidden.add(e.id) : _hidden.remove(e.id));
    await widget.db.setEventHidden(e.id, hidden);
  }

  Future<void> _openSettings() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) =>
          CalendarsSettingsScreen(source: widget.source, db: widget.db),
    ));
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          IconButton(
            icon: Icon(_showHidden ? Icons.visibility : Icons.visibility_off),
            tooltip: _showHidden ? 'Hide hidden events' : 'Show hidden events',
            onPressed: () => setState(() => _showHidden = !_showHidden),
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Classify calendars',
            onPressed: _openSettings,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (!_granted) {
      return const _Message(
          '🔒 Calendar access was denied.\nEnable it in system settings to see your events.');
    }

    CalendarKind kindOf(CalendarEvent e) => e.calendarId == null
        ? CalendarKind.unset
        : (_kinds[e.calendarId] ?? CalendarKind.unset);

    // Hide ignored calendars, apply the work/personal filter, and drop hidden
    // events unless the user is reviewing them.
    final visible = _events.where((e) {
      final k = kindOf(e);
      if (k == CalendarKind.ignore) return false;
      if (!_showHidden && _hidden.contains(e.id)) return false;
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
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                      ),
                    for (final e in visible)
                      _EventCard(
                        event: e,
                        kind: kindOf(e),
                        hidden: _hidden.contains(e.id),
                        onToggleHidden: (h) => _setHidden(e, h),
                        matches: rankPersonasForEvent(e, widget.personas),
                      ),
                  ],
                ),
        ),
      ],
    );
  }
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
  const _EventCard({
    required this.event,
    required this.kind,
    required this.hidden,
    required this.onToggleHidden,
    required this.matches,
  });

  final CalendarEvent event;
  final CalendarKind kind;
  final bool hidden;
  final ValueChanged<bool> onToggleHidden;
  final List<PersonaMatch> matches;

  @override
  Widget build(BuildContext context) {
    final top = matches.isNotEmpty ? matches.first : null;
    final card = Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 4, 12),
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
                PopupMenuButton<bool>(
                  tooltip: 'Event options',
                  icon: const Icon(Icons.more_vert, size: 20),
                  onSelected: onToggleHidden,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: !hidden,
                      child: Text(hidden
                          ? 'Unhide — consider in Multitudes'
                          : 'Hide from Multitudes'),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_when(event), style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 8),
                  if (hidden)
                    const Text('Hidden — not considered',
                        style: TextStyle(
                            color: Colors.grey, fontStyle: FontStyle.italic))
                  else if (top == null)
                    const Text('No persona matched',
                        style: TextStyle(color: Colors.grey))
                  else
                    _MatchLine(match: top),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // Dim hidden events when they're being reviewed.
    return hidden ? Opacity(opacity: 0.55, child: card) : card;
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
