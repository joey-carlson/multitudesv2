import 'package:flutter/material.dart';

import '../data/calendar_source.dart';
import '../data/database.dart';
import '../domain/calendar_classification.dart';
import '../domain/calendar_event.dart';
import '../domain/calendar_matcher.dart';
import '../domain/energy_impact.dart';
import '../domain/persona.dart';
import '../domain/timing_suggestion.dart';
import 'calendars_settings_screen.dart';
import 'suggestions_screen.dart';

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
  final Map<String, String> _overrides = {}; // eventId -> personaId
  final Map<String, int> _impacts = {}; // eventId -> energy impact (-2..2)
  final Map<String, Set<String>> _learned = {}; // personaId -> learned tokens

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
    final kindOverrides = await widget.db.calendarKinds();
    final kinds = {
      for (final c in calendars) c.id: effectiveKind(c, kindOverrides)
    };
    final hidden = await widget.db.hiddenEventIds();
    final personaOverrides = await widget.db.eventPersonaMap();
    final impacts = await widget.db.energyImpactMap();
    final learned = await widget.db.learnedTokensByPersona();
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
      _overrides
        ..clear()
        ..addAll(personaOverrides);
      _impacts
        ..clear()
        ..addAll(impacts);
      _learned
        ..clear()
        ..addAll(learned);
      _loading = false;
    });
  }

  // Optimistic: update the visible list immediately, then persist.
  Future<void> _setHidden(CalendarEvent e, bool hidden) async {
    setState(() => hidden ? _hidden.add(e.id) : _hidden.remove(e.id));
    await widget.db.setEventHidden(e.id, hidden);
  }

  Future<void> _setPersona(CalendarEvent e, String? personaId) async {
    // Learn from the assignment: associate the event's title/notes tokens with
    // the chosen persona so similar future events auto-match.
    final tokens = {...matchTokens(e.title), ...matchTokens(e.notes)};
    setState(() {
      if (personaId == null) {
        _overrides.remove(e.id);
      } else {
        _overrides[e.id] = personaId;
        if (tokens.isNotEmpty) (_learned[personaId] ??= {}).addAll(tokens);
      }
    });
    await widget.db.setEventPersona(e.id, personaId);
    if (personaId != null) {
      await widget.db.recordAssignmentTokens(personaId, tokens);
    }
  }

  Future<void> _setImpact(CalendarEvent e, int? value) async {
    setState(() {
      if (value == null) {
        _impacts.remove(e.id);
      } else {
        _impacts[e.id] = value;
      }
    });
    await widget.db.setEventEnergyImpact(e.id, value);
  }

  void _openImpactPicker(CalendarEvent e) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('How does "${e.title}" affect your energy?',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            for (final imp in EnergyImpact.values.reversed) // energizing first
              ListTile(
                title: Text(imp.label),
                onTap: () {
                  Navigator.pop(ctx);
                  _setImpact(e, imp.value);
                },
              ),
            if (_impacts.containsKey(e.id))
              ListTile(
                leading: const Icon(Icons.auto_awesome),
                title: const Text('Use auto estimate'),
                onTap: () {
                  Navigator.pop(ctx);
                  _setImpact(e, null);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _openAssign(CalendarEvent e) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Assign a persona to "${e.title}"',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            for (final p in widget.personas)
              if (p.id != null)
                ListTile(
                  leading: Text(p.emoji, style: const TextStyle(fontSize: 22)),
                  title: Text(p.name),
                  onTap: () {
                    Navigator.pop(ctx);
                    _setPersona(e, p.id);
                  },
                ),
            if (_overrides.containsKey(e.id))
              ListTile(
                leading: const Icon(Icons.clear),
                title: const Text('Clear assignment'),
                onTap: () {
                  Navigator.pop(ctx);
                  _setPersona(e, null);
                },
              ),
          ],
        ),
      ),
    );
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
          if (!_loading && _granted) _suggestionsAction(),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: _loading ? null : _load,
          ),
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

  Widget _suggestionsAction() {
    final count = _suggestions().length;
    final button = IconButton(
      icon: const Icon(Icons.lightbulb_outline),
      tooltip: 'Timing suggestions',
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => SuggestionsScreen(suggestions: _suggestions()),
        ),
      ),
    );
    return count == 0
        ? button
        : Badge(label: Text('$count'), offset: const Offset(-6, 6), child: button);
  }

  CalendarKind _kindOf(CalendarEvent e) => e.calendarId == null
      ? CalendarKind.unset
      : (_kinds[e.calendarId] ?? CalendarKind.unset);

  Persona? _personaOf(CalendarEvent e) => effectivePersonaForEvent(
      e, widget.personas, _overrides,
      eventKind: _kindOf(e), learnedByPersona: _learned);

  EnergyImpact _impactOf(CalendarEvent e) => _impacts.containsKey(e.id)
      ? EnergyImpact.fromValue(_impacts[e.id]!)
      : estimateEnergyImpact(_personaOf(e), e.start);

  /// Timing suggestions across non-hidden, non-ignored events, strongest first.
  List<TimingSuggestion> _suggestions() {
    final out = <TimingSuggestion>[];
    for (final e in _events) {
      if (_hidden.contains(e.id)) continue;
      if (_kindOf(e) == CalendarKind.ignore) continue;
      final s = suggestTimingForEvent(e, _personaOf(e));
      if (s != null) out.add(s);
    }
    out.sort((a, b) {
      final bySeverity = a.severity.index.compareTo(b.severity.index);
      return bySeverity != 0 ? bySeverity : a.event.start.compareTo(b.event.start);
    });
    return out;
  }

  Widget _buildBody() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (!_granted) {
      return const _Message(
          '🔒 Calendar access was denied.\nEnable it in system settings to see your events.');
    }

    // Hide ignored calendars, apply the work/personal filter, and drop hidden
    // events unless the user is reviewing them. Sorted by start time.
    final visible = _events.where((e) {
      final k = _kindOf(e);
      if (k == CalendarKind.ignore) return false;
      if (!_showHidden && _hidden.contains(e.id)) return false;
      if (_filter == null) return true;
      return k == _filter;
    }).toList()
      ..sort((a, b) => a.start.compareTo(b.start));

    // Summary counts over the visible set.
    final assigned = visible.where((e) => _overrides.containsKey(e.id)).length;
    final unmatched =
        visible.where((e) => !_hidden.contains(e.id) && _personaOf(e) == null).length;
    final hiddenCount = _events.where((e) => _hidden.contains(e.id)).length;
    final netEnergy = visible
        .where((e) => !_hidden.contains(e.id))
        .fold<int>(0, (s, e) => s + _impactOf(e).value);

    return Column(
      children: [
        _FilterBar(
          filter: _filter,
          onChanged: (f) => setState(() => _filter = f),
        ),
        if (visible.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                [
                  '${visible.length} event${visible.length == 1 ? '' : 's'}',
                  if (assigned > 0) '$assigned assigned',
                  if (unmatched > 0) '$unmatched unmatched',
                  if (hiddenCount > 0) '$hiddenCount hidden',
                  'net energy ${netEnergy >= 0 ? '+' : ''}$netEnergy',
                ].join(' · '),
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ),
          ),
        Expanded(
          child: visible.isEmpty
              ? const _Message('No matching events in the next 7 days.')
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: _eventList(visible, unmatched),
                ),
        ),
      ],
    );
  }

  /// Builds the scrollable list: source note, empty-match guidance, then events
  /// grouped under day headers (Today / Tomorrow / weekday).
  List<Widget> _eventList(List<CalendarEvent> visible, int unmatched) {
    final children = <Widget>[];

    if (!widget.source.isLive) {
      children.add(Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          'Showing ${widget.source.label.toLowerCase()} — '
          'connect your device calendar to see real events.',
          style: TextStyle(color: Colors.grey[600], fontSize: 13),
        ),
      ));
    }

    // Guidance when nothing matched any persona.
    if (unmatched == visible.length && !_showHidden) {
      children.add(Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            "None of these events matched a persona yet. Use an event's menu to "
            'assign one — assignments feed that persona in your balance.',
          ),
        ),
      ));
    }

    String? currentDay;
    for (final e in visible) {
      final label = _dayLabel(e.start);
      if (label != currentDay) {
        currentDay = label;
        children.add(Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 4),
          child: Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.3)),
        ));
      }
      children.add(_EventCard(
        event: e,
        kind: _kindOf(e),
        hidden: _hidden.contains(e.id),
        persona: _personaOf(e),
        isManual: _overrides.containsKey(e.id),
        impact: _impactOf(e),
        isManualImpact: _impacts.containsKey(e.id),
        onToggleHidden: (h) => _setHidden(e, h),
        onAssign: () => _openAssign(e),
        onSetImpact: () => _openImpactPicker(e),
      ));
    }
    return children;
  }

  /// "Today" / "Tomorrow" / "Wed, Jan 3" for a day header.
  String _dayLabel(DateTime d) {
    final now = DateTime.now();
    final day = DateTime(d.year, d.month, d.day);
    final today = DateTime(now.year, now.month, now.day);
    final delta = day.difference(today).inDays;
    if (delta == 0) return 'Today';
    if (delta == 1) return 'Tomorrow';
    const wd = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const mo = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${wd[d.weekday - 1]}, ${mo[d.month - 1]} ${d.day}';
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
    required this.persona,
    required this.isManual,
    required this.impact,
    required this.isManualImpact,
    required this.onToggleHidden,
    required this.onAssign,
    required this.onSetImpact,
  });

  final CalendarEvent event;
  final CalendarKind kind;
  final bool hidden;
  final Persona? persona;
  final bool isManual;
  final EnergyImpact impact;
  final bool isManualImpact;
  final ValueChanged<bool> onToggleHidden;
  final VoidCallback onAssign;
  final VoidCallback onSetImpact;

  @override
  Widget build(BuildContext context) {
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
                PopupMenuButton<String>(
                  tooltip: 'Event options',
                  icon: const Icon(Icons.more_vert, size: 20),
                  onSelected: (v) {
                    switch (v) {
                      case 'assign':
                        onAssign();
                      case 'impact':
                        onSetImpact();
                      case 'hide':
                        onToggleHidden(true);
                      case 'unhide':
                        onToggleHidden(false);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'assign',
                      child: Text(persona == null
                          ? 'Assign persona…'
                          : 'Change persona…'),
                    ),
                    const PopupMenuItem(
                      value: 'impact',
                      child: Text('Set energy impact…'),
                    ),
                    PopupMenuItem(
                      value: hidden ? 'unhide' : 'hide',
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
                  else if (persona == null)
                    Row(
                      children: [
                        const Text('No persona matched',
                            style: TextStyle(color: Colors.grey)),
                        const Spacer(),
                        TextButton(
                            onPressed: onAssign,
                            child: const Text('Assign')),
                      ],
                    )
                  else
                    _PersonaLine(
                        persona: persona!, event: event, isManual: isManual),
                  if (!hidden) ...[
                    const SizedBox(height: 6),
                    _ImpactChip(
                        impact: impact,
                        isAuto: !isManualImpact,
                        onTap: onSetImpact),
                  ],
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

  // Day is shown in the section header, so this is just time (or "All day")
  // plus the source calendar name.
  static String _when(CalendarEvent e) {
    String two(int n) => n.toString().padLeft(2, '0');
    final time = e.allDay
        ? 'All day'
        : '${two(e.start.hour)}:${two(e.start.minute)}'
            '–${two(e.end.hour)}:${two(e.end.minute)}';
    return e.calendarName == null ? time : '$time · ${e.calendarName}';
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

/// Tappable chip showing an event's energy impact (draining↔energizing).
class _ImpactChip extends StatelessWidget {
  const _ImpactChip(
      {required this.impact, required this.isAuto, required this.onTap});

  final EnergyImpact impact;
  final bool isAuto;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = switch (impact) {
      EnergyImpact.energizing => Colors.green,
      EnergyImpact.somewhatEnergizing => Colors.teal,
      EnergyImpact.neutral => Colors.grey,
      EnergyImpact.somewhatDraining => Colors.orange,
      EnergyImpact.draining => Colors.deepOrange,
    };
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          isAuto ? '${impact.label} · auto' : impact.label,
          style: TextStyle(
              color: color, fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

/// The persona in effect for an event, with a timing note and (for manual
/// assignments) an "assigned" tag.
class _PersonaLine extends StatelessWidget {
  const _PersonaLine({
    required this.persona,
    required this.event,
    required this.isManual,
  });

  final Persona persona;
  final CalendarEvent event;
  final bool isManual;

  @override
  Widget build(BuildContext context) {
    final state = persona.energyStateAt(event.start);
    var (icon, note, color) = switch (state) {
      EnergyState.peak => ('✅', 'during their peak', Colors.green),
      EnergyState.trough => ('⚠️', 'during their low-energy trough', Colors.orange),
      EnergyState.recovery => ('🔋', 'during their recovery window', Colors.blue),
      EnergyState.neutral => ('•', 'outside their peak hours', Colors.grey),
    };
    // Inline timing hint: for a trough event, suggest the persona's peak window.
    if (state == EnergyState.trough &&
        persona.peakStartTime != null &&
        persona.peakEndTime != null) {
      note = '$note — better ${persona.peakStartTime}–${persona.peakEndTime}';
    }
    return Row(
      children: [
        Chip(
          visualDensity: VisualDensity.compact,
          avatar: isManual ? const Icon(Icons.push_pin, size: 14) : null,
          label: Text('${persona.emoji} ${persona.name}'),
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
