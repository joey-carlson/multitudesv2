# Multitudes — Competitive Landscape & Improvement Ideas

**Created:** 2026-08-18 (from a research pass over comparable products)
**Purpose:** depth (improve what exists) + breadth (new roadmap) ideas, grounded
in what comparable tools do. Tags: `[local-first OK]` fits the on-device,
privacy-first model; `[needs online/integration]` crosses the enrichment
boundary and must be explicit opt-in.

## Products surveyed (standout features)

- **AI time-blocking / calendar:** Motion (auto-scheduler, Do-Date vs Due-Date,
  at-risk warnings), Reclaim.ai (auto-schedule tasks/habits, defended focus
  time, preview-before-write-back, buffers, no training on user data), Sunsama
  (daily intention + **shutdown/reflection ritual**, planned-vs-actual),
  Clockwise (auto focus time, flexible meetings — shutting down Mar 2026),
  Akiflow (**Universal Inbox**, voice capture, daily briefings), SkedPal
  (**Time Maps** — when categories may be scheduled; a direct analog to persona
  peak windows; a plan "realism" tracker).
- **Energy / chronotype:** RISE Science (**circadian energy schedule** of daily
  peak-focus windows from phone data, sleep-debt), TimeTune (local routines).
- **Mood / parts-of-self:** How We Feel (**Mood Meter**: energy × pleasantness
  quadrants, emotion granularity, matched strategies), Finch (**gamified
  self-care pet**), Stoic (AI journaling, AM/PM check-ins, on-device), Daylio
  (2-tap mood+activity, **correlation stats**, CSV/PDF export, local), IFS apps
  (parts mapping, Self-vs-blended — conceptual cousin; mixed evidence, needs
  guardrails).
- **Coaching / habits / journaling:** Habitica (RPG habits/dailies), Coach.me
  (streaks + human coaching), Day One (encrypted journaling), Reflectly (guided
  AI journal), Wheel of Life (life-domain balance visualization).

## A) DEPTH — improve existing features

1. **Time Maps per persona** — allow multiple/preferred scheduling windows, not
   just one peak. `[local-first OK]`
2. **Confidence-scored matching + "why matched"** — show lexicon/time/domain
   contributions; only ask to confirm low-confidence matches. `[local-first OK]`
3. **On-device semantic matching** — a bundled small model to catch synonyms
   keyword lexicons miss ("Sync w/ Dana"). `[local-first OK]`
4. **Correlation analytics (Daylio-style)** — which event types/times/personas
   correlate with energizing vs draining. `[local-first OK]`
5. **Local energy forecasting (RISE-style)** — predict today's peak/trough per
   persona from check-in history; auto-refine windows. `[local-first OK]`
6. **Two-axis mood check-ins** — energy × pleasantness (Mood Meter) instead of a
   single draining↔energizing scale. `[local-first OK]`
7. **Smarter timing suggestions** — batch/relocate multiple events; respect
   buffers/travel/breaks; rank by balance impact. `[local-first OK]`
8. **Balance decay + trends** — fed/starving should decay and show 7/30-day
   trajectories; flag personas trending toward starvation early. `[local-first OK]`
9. **Wheel-of-Life view** — one radial "are my selves in balance?" visualization.
   `[local-first OK]`
10. **Realism indicator** — warn when a persona is structurally over-committed
    vs available calendar time before the week starts. `[local-first OK]`

## B) BREADTH — new capabilities

1. **Calendar write-back / auto-scheduling** — create/move events to a persona's
   peak with **preview-and-approve**. `[needs integration]` (device-local write,
   but a real mutation — gate per change)
2. **Focus mode + notifications** — persona-aware focus sessions, "your Creator
   peak starts in 15 min", quiet hours. `[local-first OK]`
3. **Streaks / habits / dailies** — recurring persona-nourishing habits feeding
   the balance model. `[local-first OK]`
4. **Journaling per persona** — reflective entries tagged to personas/check-ins,
   with prompts; optional encryption. `[local-first OK]`
5. **Daily planning + shutdown ritual (Sunsama)** — morning "which selves need
   feeding today?" + evening reflection (wins, planned-vs-actual). `[local-first OK]`
6. **Weekly review / reporting + export** — balance/energy/time-per-persona,
   CSV/PDF. `[local-first OK]`
7. **IFS-inspired "parts dialogue"** — guided persona check-in, Self-vs-blended,
   persona relationship mapping — with explicit "not a substitute for care"
   guardrails. `[local-first OK]`
8. **Companion / gamification (Finch)** — light optional engagement tied to
   feeding neglected personas. `[local-first OK]`
9. **Wearable / health signals** — optional Apple Health / Health Connect
   (sleep, HRV, steps) to ground energy forecasts. `[needs integration]`
   (HealthKit is on-device; vendor cloud is not)
10. **Voice / quick capture** — log a check-in or task by voice / widget /
    Cmd-K; on-device speech-to-text. `[local-first OK]`
11. **External task-tool inbox** — pull ideal-tasks from Todoist/Notion/etc.
    `[needs integration]` (opt-in, leaves the local boundary)
12. **Optional human coaching / accountability** — bridge to a real coach.
    `[needs online]` (explicit opt-in add-on)

## Recommended priority (privacy-native, high payoff)

Best next wins that need **no server**: DEPTH #8 (balance trends/decay), #4
(correlation analytics), #5 (local energy forecasting) → these deepen the
coaching signal; BREADTH #2 (focus/notifications), #5 (daily/shutdown ritual),
#3 (habits/streaks), #4 (journaling) → these drive daily engagement. The one
high-value item that crosses the boundary and is worth doing carefully: BREADTH #1
(calendar write-back with preview/approve), since it turns suggestions into
action. Health signals (#9) and semantic matching (DEPTH #3) are strong but
heavier lifts. (See PARKING_LOT.md for the existing roadmap these fold into.)
