import 'package:flutter/material.dart';

import '../domain/persona.dart';

/// Home: shows the user's personas with their energy windows and balance target.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.personas, this.onRetake});

  final List<Persona> personas;
  final VoidCallback? onRetake;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Multitudes'),
        actions: [
          if (onRetake != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Retake survey',
              onPressed: onRetake,
            ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: personas.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, i) => _PersonaCard(personas[i]),
      ),
    );
  }
}

class _PersonaCard extends StatelessWidget {
  const _PersonaCard(this.persona);

  final Persona persona;

  @override
  Widget build(BuildContext context) {
    final peak = (persona.peakStartTime != null && persona.peakEndTime != null)
        ? '${persona.peakStartTime}–${persona.peakEndTime}'
        : 'not set';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(persona.emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(persona.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(persona.primaryEnergy,
                      style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 8),
                  Text('⚡ Peak energy: $peak'),
                  if (persona.idealWeeklyHours > 0)
                    Text('🎯 Target: ${persona.idealWeeklyHours.toStringAsFixed(0)} hrs/week'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
