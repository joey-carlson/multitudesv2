/// Reflective journaling prompts (engagement layer), grounded in established
/// techniques and a research pass (see docs/ARCHITECTURE.md §0.1a):
/// gratitude / "Three Good Things" (Emmons & McCullough; Seligman),
/// Best-Possible-Self / possible-selves (King 2001), values / self-affirmation
/// (Steele), WOOP wish→obstacle→if-then (Oettingen & Gollwitzer),
/// self-distancing (Kross & Ayduk), and brief expressive writing (Pennebaker).
///
/// Prompts are short, non-clinical, and avoid rumination/trauma-digging: hard
/// experiences use a self-distancing "caring friend / your own name" framing,
/// and wish prompts pair optimism with an obstacle + if-then plan.
library;

class JournalPrompt {
  const JournalPrompt(this.text, this.technique);
  final String text;
  final String technique;
}

/// Persona-tailored prompts (using the persona's [name]). The user can also
/// free-write with no prompt.
List<JournalPrompt> journalPromptsFor(String name) => [
      // Gratitude — favor a "because" clause; a few times a week beats daily.
      JournalPrompt(
          'Name a few things $name was glad about lately — and why each happened.',
          'gratitude'),
      JournalPrompt('What did $name enjoy or feel proud of recently?',
          'gratitude'),
      // Best possible self — future-focused, specific.
      JournalPrompt(
          'Imagine a future where $name has flourished. Describe an ordinary '
          'day — be specific.',
          'bestPossibleSelf'),
      JournalPrompt('A year from now, what has $name grown into?',
          'bestPossibleSelf'),
      // Values / self-affirmation — brief grounding.
      JournalPrompt(
          'What value matters most to $name right now, and why does it matter '
          'to you?',
          'values'),
      JournalPrompt(
          'When did $name act in line with what you care about recently?',
          'values'),
      // WOOP — wish + obstacle + if-then (not pure positive fantasy).
      JournalPrompt("One wish $name has this week — picture it going well.",
          'woop'),
      JournalPrompt(
          "What's the one obstacle in you most likely to get in $name's way?",
          'woop'),
      JournalPrompt('Finish: "If that obstacle shows up, then $name will ___."',
          'woop'),
      // Self-distancing — for something hard, observer/named framing.
      JournalPrompt(
          'Something felt off for $name recently. Watching like a caring '
          'friend, what do you notice — and what would help next time?',
          'selfDistancing'),
      // Brief expressive writing — short and bounded.
      JournalPrompt(
          "Take 10 minutes: what's on $name's mind today? Write freely, no "
          'editing.',
          'expressive'),
    ];
