/// Persona domain model — Dart port of src/core/personas/persona_models.py.
///
/// This is a faithful port of the Python reference implementation, verified
/// against the shared fixtures in tests/fixtures/persona_generation_cases.json
/// (see docs/ARCHITECTURE.md §0.4). Keep the template data and archetype values
/// identical to the Python source; drift is caught by the fixture-contract test.
library;

/// Common persona archetypes. `value` matches the Python enum string.
enum PersonaArchetype {
  professional('professional'),
  innerChild('inner_child'),
  artist('artist'),
  builder('builder'),
  guardian('guardian'),
  architect('architect'),
  historian('historian'),
  optimizer('optimizer'),
  custom('custom');

  const PersonaArchetype(this.value);
  final String value;
}

/// A persona's energy state at a point in time (mirrors the Python
/// Peak-Trough-Recovery model in persona_models.py).
enum EnergyState {
  peak('Peak', 10),
  recovery('Recovery', 7),
  neutral('Neutral', 5),
  trough('Trough', 3);

  const EnergyState(this.label, this.level);

  /// Short human label.
  final String label;

  /// Predicted energy level (1-10) for this state.
  final int level;
}

/// Template for a common archetype, mirroring PersonaArchetypeTemplate.
/// Energy times are stored as "HH:MM" strings (matching the DB representation).
class PersonaArchetypeTemplate {
  const PersonaArchetypeTemplate({
    required this.archetype,
    required this.defaultName,
    required this.emoji,
    required this.primaryEnergy,
    required this.commonStrengths,
    required this.commonWeaknesses,
    required this.typicalTriggers,
    required this.idealTaskCategories,
    this.typicalPeakStart,
    this.typicalPeakEnd,
  });

  final PersonaArchetype archetype;
  final String defaultName;
  final String emoji;
  final String primaryEnergy;
  final List<String> commonStrengths;
  final List<String> commonWeaknesses;
  final List<String> typicalTriggers;
  final List<String> idealTaskCategories;
  final String? typicalPeakStart;
  final String? typicalPeakEnd;
}

/// One aspect of a user's multitudes. Energy times are "HH:MM" strings or null.
class Persona {
  Persona({
    required this.userId,
    required this.name,
    required this.emoji,
    required this.archetype,
    required this.primaryEnergy,
    required this.strengths,
    required this.weaknesses,
    required this.triggerConditions,
    required this.idealTasks,
    this.peakStartTime,
    this.peakEndTime,
    this.troughStartTime,
    this.troughEndTime,
    this.recoveryStartTime,
    this.recoveryEndTime,
    this.idealWeeklyHours = 0.0,
    this.actualWeeklyHours = 0.0,
    this.isActive = true,
  });

  final String userId;
  final String name;
  final String emoji;
  final PersonaArchetype archetype;
  final String primaryEnergy;
  final List<String> strengths;
  final List<String> weaknesses;
  final List<String> triggerConditions;
  final List<String> idealTasks;
  final String? peakStartTime;
  final String? peakEndTime;
  final String? troughStartTime;
  final String? troughEndTime;
  final String? recoveryStartTime;
  final String? recoveryEndTime;
  final double idealWeeklyHours;
  final double actualWeeklyHours;
  final bool isActive;

  /// Energy state at [now] (defaults to the current time). Checks peak, then
  /// trough, then recovery windows; neutral otherwise — matching the Python
  /// `get_energy_level` precedence.
  EnergyState energyStateAt(DateTime now) {
    final minutes = now.hour * 60 + now.minute;
    if (_inWindow(peakStartTime, peakEndTime, minutes)) return EnergyState.peak;
    if (_inWindow(troughStartTime, troughEndTime, minutes)) return EnergyState.trough;
    if (_inWindow(recoveryStartTime, recoveryEndTime, minutes)) {
      return EnergyState.recovery;
    }
    return EnergyState.neutral;
  }

  /// Whether [now] falls in this persona's peak window.
  bool isAtPeak(DateTime now) => energyStateAt(now) == EnergyState.peak;

  /// True if [minutes] (since midnight) is within [start]–[end] ("HH:MM"),
  /// handling windows that cross midnight (e.g. 23:00–02:00).
  static bool _inWindow(String? start, String? end, int minutes) {
    if (start == null || end == null) return false;
    final s = _toMinutes(start);
    final e = _toMinutes(end);
    if (s <= e) return minutes >= s && minutes <= e;
    return minutes >= s || minutes <= e; // crosses midnight
  }

  static int _toMinutes(String hhmm) {
    final parts = hhmm.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  /// Language-neutral view matching scripts/export_persona_fixtures.py
  /// `_persona_to_dict` (id/timestamps excluded — not stable across runs).
  Map<String, dynamic> toFixtureMap() => {
        'name': name,
        'emoji': emoji,
        'archetype': archetype.value,
        'primary_energy': primaryEnergy,
        'strengths': strengths,
        'weaknesses': weaknesses,
        'trigger_conditions': triggerConditions,
        'ideal_tasks': idealTasks,
        'peak_start_time': peakStartTime,
        'peak_end_time': peakEndTime,
        'trough_start_time': troughStartTime,
        'trough_end_time': troughEndTime,
        'recovery_start_time': recoveryStartTime,
        'recovery_end_time': recoveryEndTime,
        'ideal_weekly_hours': idealWeeklyHours,
      };
}

/// Predefined archetype templates — values must stay identical to the Python
/// ARCHETYPE_TEMPLATES in src/core/personas/persona_models.py.
const Map<PersonaArchetype, PersonaArchetypeTemplate> archetypeTemplates = {
  PersonaArchetype.professional: PersonaArchetypeTemplate(
    archetype: PersonaArchetype.professional,
    defaultName: 'The Professional',
    emoji: '🧠',
    primaryEnergy: 'Responsible, structured, goal-focused',
    commonStrengths: [
      'Manages deadlines effectively',
      'Strong prioritization skills',
      'Excellent under time pressure',
      'Tracks open loops and executes cleanly',
    ],
    commonWeaknesses: [
      'Easily overloaded by emotional ambiguity',
      'Can suppress personal needs',
      'Struggles with creative sprawl',
      'May burn out without boundaries',
    ],
    typicalTriggers: ['Weekday mornings', 'Deadlines', 'Meetings', 'Email inbox'],
    idealTaskCategories: [
      'Administrative tasks',
      'Scheduling and planning',
      'Financial decisions',
      'High-stakes communication',
    ],
    typicalPeakStart: '07:00',
    typicalPeakEnd: '11:00',
  ),
  PersonaArchetype.innerChild: PersonaArchetypeTemplate(
    archetype: PersonaArchetype.innerChild,
    defaultName: 'The Little Kid',
    emoji: '🌈',
    primaryEnergy: 'Emotional, playful, relational',
    commonStrengths: [
      'Strong empathy and emotional intelligence',
      'Excellent at reading social cues',
      'Craves joy and authentic connection',
      'Great with unstructured play time',
    ],
    commonWeaknesses: [
      'Sensitive to emotional overwhelm',
      'Avoids complex decision-making',
      'Easily derailed by negative emotions',
      'Struggles with sustained focus',
    ],
    typicalTriggers: ['Spontaneous messages', 'Music', 'Safe creative space', 'Nature'],
    idealTaskCategories: [
      'Messaging loved ones',
      'Light journaling',
      'Aesthetic decisions',
      'Mood tracking and self-care',
    ],
    typicalPeakStart: '10:00',
    typicalPeakEnd: '14:00',
  ),
  PersonaArchetype.artist: PersonaArchetypeTemplate(
    archetype: PersonaArchetype.artist,
    defaultName: 'The Artist',
    emoji: '🎨',
    primaryEnergy: 'Expressive, introspective, imaginative',
    commonStrengths: [
      'Recharges through creative expression',
      'Connects ideas across domains',
      'Thrives in immersive flow states',
      'Values solitude and reflection',
    ],
    commonWeaknesses: [
      'Prone to overcommitment',
      'Romanticizes unfinished work',
      'Dislikes administrative overhead',
      'Can get lost in perfectionism',
    ],
    typicalTriggers: ['Long drives', 'Ambient music', 'Open calendar blocks', 'Nature walks'],
    idealTaskCategories: [
      'Creative writing',
      'Music and art',
      'Visual design',
      'System ideation',
    ],
    typicalPeakStart: '14:00',
    typicalPeakEnd: '18:00',
  ),
  PersonaArchetype.builder: PersonaArchetypeTemplate(
    archetype: PersonaArchetype.builder,
    defaultName: 'The Tinkerer',
    emoji: '🛠',
    primaryEnergy: 'Physical, iterative, curious',
    commonStrengths: [
      'Excellent with trial-and-error',
      'Builds solutions through hands-on work',
      'Thrives with tactile tools',
      'Natural problem-solver',
    ],
    commonWeaknesses: [
      'Can get stuck refining without shipping',
      'Hates repetitive manual tasks',
      'May over-engineer solutions',
      'Struggles with abstract planning',
    ],
    typicalTriggers: ['New hardware', 'Broken things', 'Tools on table', 'Physical workspace'],
    idealTaskCategories: [
      'Building and assembly',
      'Debugging and repairs',
      'Prototyping',
      'Equipment setup',
    ],
    typicalPeakStart: '09:00',
    typicalPeakEnd: '13:00',
  ),
  PersonaArchetype.guardian: PersonaArchetypeTemplate(
    archetype: PersonaArchetype.guardian,
    defaultName: 'The Protector',
    emoji: '🛡',
    primaryEnergy: 'Defensive, vigilant, cautious',
    commonStrengths: [
      'Excellent risk detection',
      'Strong threat prevention instincts',
      'Thinks through edge cases',
      'Values preparedness',
    ],
    commonWeaknesses: [
      'Can be overly pessimistic',
      'May retreat from growth opportunities',
      'Avoids emotional vulnerability',
      'Paralysis by analysis',
    ],
    typicalTriggers: ['Missed sleep', 'High-anxiety situations', 'Upcoming travel', 'Deadlines'],
    idealTaskCategories: [
      'Scenario planning',
      'Security audits',
      'Emergency preparation',
      'Risk assessment',
    ],
    typicalPeakStart: '06:00',
    typicalPeakEnd: '10:00',
  ),
  PersonaArchetype.architect: PersonaArchetypeTemplate(
    archetype: PersonaArchetype.architect,
    defaultName: 'The Organizer',
    emoji: '📐',
    primaryEnergy: 'Configurational, orderly, systemic',
    commonStrengths: [
      'Plans and optimizes effectively',
      'Excellent at workflow design',
      'Loves templates and structure',
      'Reshuffles priorities skillfully',
    ],
    commonWeaknesses: [
      'Can lose sight of emotional needs',
      'Struggles with chaos or rapid pivots',
      'Over-optimizes at times',
      'May delay action for perfection',
    ],
    typicalTriggers: ['System breakdowns', 'Clutter', 'Big events coming', 'Calendar chaos'],
    idealTaskCategories: [
      'Calendar planning',
      'File organization',
      'Infrastructure design',
      'Workflow optimization',
    ],
    typicalPeakStart: '08:00',
    typicalPeakEnd: '12:00',
  ),
  PersonaArchetype.historian: PersonaArchetypeTemplate(
    archetype: PersonaArchetype.historian,
    defaultName: 'The Archivist',
    emoji: '🗃',
    primaryEnergy: 'Retrospective, curious, meticulous',
    commonStrengths: [
      'Keeps excellent records',
      'Surfaces forgotten details',
      'Reconstructs timelines accurately',
      'Values completeness',
    ],
    commonWeaknesses: [
      'May fixate on past data',
      'Can over-document',
      'Delays forward motion',
      'Perfectionist tendencies',
    ],
    typicalTriggers: ['End-of-week', 'Tagging sessions', 'Postmortems', 'Review time'],
    idealTaskCategories: [
      'Documentation',
      'Summaries and reports',
      'Narrative logs',
      'Data archiving',
    ],
    typicalPeakStart: '15:00',
    typicalPeakEnd: '19:00',
  ),
  PersonaArchetype.optimizer: PersonaArchetypeTemplate(
    archetype: PersonaArchetype.optimizer,
    defaultName: 'The Assistant',
    emoji: '🤖',
    primaryEnergy: 'Automation, precision, support-focused',
    commonStrengths: [
      'Helps others work smarter',
      'Eliminates busywork efficiently',
      'Bridges systems together',
      'Delegates effectively',
    ],
    commonWeaknesses: [
      "Doesn't initiate independently",
      'Relies on others for goals',
      'Frustrated by analog processes',
      'May over-automate',
    ],
    typicalTriggers: ['Repeat tasks', 'Friction points', 'File formatting', 'Tool setup'],
    idealTaskCategories: [
      'Scripting and automation',
      'Data cleaning',
      'Tool integration',
      'Process optimization',
    ],
    typicalPeakStart: '13:00',
    typicalPeakEnd: '17:00',
  ),
};
