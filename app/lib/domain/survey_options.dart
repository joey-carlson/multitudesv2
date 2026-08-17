/// Canonical survey option strings, mirroring src/core/personas/survey_config.py.
///
/// The generator matches on the "(Xam-Ypm)" token and the archetype emoji, so
/// these strings must keep those tokens/emoji intact.
library;

import 'persona.dart';

/// Archetype choices, built from the templates so labels and emoji stay in sync.
List<String> archetypeOptions() => [
      for (final t in archetypeTemplates.values)
        '${t.emoji} ${t.defaultName} - ${t.primaryEnergy}',
      "✨ I'll create my own",
    ];

/// `overall_energy_pattern` options (peak windows).
const List<String> peakEnergyOptions = [
  'Very early morning (5am-7am) - Dawn hours',
  'Early morning (7am-9am) - Pre-business hours',
  'Mid-morning (9am-12pm) - Standard productivity hours',
  'Early afternoon (12pm-3pm) - Post-lunch energy',
  'Late afternoon (3pm-6pm) - End-of-day surge',
  'Early evening (6pm-8pm) - After-work hours',
  'Late evening (8pm-11pm) - Night owl mode',
  'Very late night (11pm-2am) - Deep night focus',
  'It varies significantly by day/season',
  'I have multiple peak periods per day',
];

/// `energy_dip` options.
const List<String> energyDipOptions = [
  'Yes, I notice a definite slump',
  "Sometimes, but it's not consistent",
  "Not really, I'm pretty steady",
  'I can power through with coffee/breaks',
];

/// `energy_dip_time` options (trough windows).
const List<String> energyDipTimeOptions = [
  'Late morning (10am-12pm)',
  'Early afternoon (12pm-2pm)',
  'Mid-afternoon (2pm-4pm)',
  'Early evening (5pm-7pm)',
  'Other time',
];
