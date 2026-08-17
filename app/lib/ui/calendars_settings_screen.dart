import 'package:flutter/material.dart';

import '../data/calendar_source.dart';
import '../data/database.dart';
import '../domain/calendar_classification.dart';

/// Lets the user tag each calendar as Work / Personal / Ignore. Choices persist
/// locally; an unset calendar shows its inferred classification.
class CalendarsSettingsScreen extends StatefulWidget {
  const CalendarsSettingsScreen({
    super.key,
    required this.source,
    required this.db,
  });

  final CalendarSource source;
  final AppDatabase db;

  @override
  State<CalendarsSettingsScreen> createState() =>
      _CalendarsSettingsScreenState();
}

class _CalendarsSettingsScreenState extends State<CalendarsSettingsScreen> {
  late Future<_Data> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_Data> _load() async {
    await widget.source.requestAccess();
    final calendars = await widget.source.listCalendars();
    final overrides = await widget.db.calendarKinds();
    return _Data(calendars: calendars, overrides: overrides);
  }

  Future<void> _set(CalendarInfo cal, CalendarKind kind) async {
    await widget.db.setCalendarKind(cal.id, kind);
    setState(() => _future = _load());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Classify calendars')),
      body: FutureBuilder<_Data>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snap.data!;
          if (data.calendars.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  'No calendars found.\nAdd accounts (incl. Outlook/Exchange) in '
                  'System Settings → Internet Accounts, then reopen.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (final cal in data.calendars)
                _CalendarTile(
                  cal: cal,
                  effective: effectiveKind(cal, data.overrides),
                  isOverridden: data.overrides[cal.id] != null &&
                      data.overrides[cal.id] != CalendarKind.unset,
                  onSet: (k) => _set(cal, k),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _Data {
  _Data({required this.calendars, required this.overrides});
  final List<CalendarInfo> calendars;
  final Map<String, CalendarKind> overrides;
}

class _CalendarTile extends StatelessWidget {
  const _CalendarTile({
    required this.cal,
    required this.effective,
    required this.isOverridden,
    required this.onSet,
  });

  final CalendarInfo cal;
  final CalendarKind effective;
  final bool isOverridden;
  final ValueChanged<CalendarKind> onSet;

  @override
  Widget build(BuildContext context) {
    final subtitleParts = [
      if (cal.account != null) cal.account!,
      if (cal.type != null) cal.type!,
      if (!isOverridden && effective != CalendarKind.unset) 'inferred',
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cal.title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            if (subtitleParts.isNotEmpty)
              Text(subtitleParts.join(' · '),
                  style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final k in const [
                  CalendarKind.work,
                  CalendarKind.personal,
                  CalendarKind.ignore,
                ])
                  ChoiceChip(
                    label: Text(k.label),
                    selected: effective == k,
                    onSelected: (_) => onSet(k),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
