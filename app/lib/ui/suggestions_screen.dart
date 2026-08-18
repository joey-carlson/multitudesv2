import 'package:flutter/material.dart';

import '../domain/persona.dart';
import '../domain/timing_suggestion.dart';

/// Aggregated timing suggestions for the week (roadmap F2): events scheduled
/// outside their persona's strong hours, with the persona's peak proposed.
/// Informational — the user reschedules in their own calendar.
class SuggestionsScreen extends StatelessWidget {
  const SuggestionsScreen({super.key, required this.suggestions});

  final List<TimingSuggestion> suggestions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timing suggestions')),
      body: suggestions.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  '✅ Nothing to adjust — your matched events fall in good windows.',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Events scheduled outside a persona’s strong hours. Move them '
                  'in your calendar if it helps.',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                const SizedBox(height: 8),
                for (final s in suggestions) _SuggestionCard(s),
              ],
            ),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard(this.s);

  final TimingSuggestion s;

  @override
  Widget build(BuildContext context) {
    final high = s.severity == SuggestionSeverity.high;
    final color = high ? Colors.orange : Colors.blueGrey;
    final reason = s.currentState == EnergyState.trough
        ? "in ${s.persona.name}'s low-energy trough"
        : "outside ${s.persona.name}'s peak hours";
    String two(int n) => n.toString().padLeft(2, '0');
    final when = s.event.allDay
        ? 'All day'
        : '${two(s.event.start.hour)}:${two(s.event.start.minute)}';

    return Card(
      child: ListTile(
        leading: Text(s.persona.emoji, style: const TextStyle(fontSize: 24)),
        title: Text(s.event.title,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('$when · $reason'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text('try ${s.peakStart}–${s.peakEnd}',
              style: TextStyle(
                  color: color, fontWeight: FontWeight.w600, fontSize: 12)),
        ),
      ),
    );
  }
}
