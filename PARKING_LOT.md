# Multitudes v2.0 - Parking Lot / Future Enhancements

This document tracks future improvements and features that are planned but not yet implemented.

---

## Persona Intelligence Roadmap (v2.1+) — CURRENT DIRECTION

**Added:** 2026-08-17
**Theme:** Move from a persona *tracker* to a persona *coach* — use the user's
real calendar and usage data to keep their personas balanced. Everything below
must respect the local-first, privacy-by-default architecture (ARCHITECTURE §0):
on-device by default, offline-capable, network only for clearly-gated optional
enrichment.

### Feature list (not in priority order)

**F1 — Read the device calendar and map events to personas.**
- On-device calendar access via EventKit / Android Calendar Provider (Flutter
  `device_calendar`). macOS/iOS need the calendar entitlement + usage strings.
  Read-only first.
- Associate each event with persona(s) via heuristics first (match event
  title/notes against a persona's `ideal_tasks` / `trigger_conditions`
  keywords), with manual override. Optional AI classification later (see
  Decision C). Fits local-first.

**F2 — Suggest ideal persona(s) per event + time-block adjustments.**
- For each event: rank persona fit, and check whether it's scheduled inside the
  matched persona's peak window (reuse `Persona.energyStateAt` / peak times).
  If misaligned, suggest a better block. Deterministic, on-device, testable.
- Later: two-way calendar (write accepted adjustments back) — higher risk, gate
  behind explicit confirmation.

**F3 — "Fed / over-fed / starving" dashboard.**
- Evolve the existing Balance dashboard: actual weekly hours per persona become
  `completed-task durations + calendar time attributed to that persona`.
  Re-label to fed / over-fed / starving. On-device.

**F4 — Rebalancing suggestions.**
- (a) On-device: for starving personas, suggest activities/downtime that match
  their `ideal_tasks` and fit their peak windows and open calendar slots.
- (b) **Online (optional):** look up local events/classes/opportunities to feed
  starving personas — requires network + a third-party API (events/places).
  Off by default; see Decision C.

**F5 — Adaptive learning over time.**
- Use accumulated `energy_readings` + task/calendar actuals to detect that a
  persona's real peak differs from the survey answer (suggest adjusting the
  window) or that activity clusters don't map to any persona (suggest a new
  one). Surface as suggestions for user approval — never silently mutate.
  Realizes the original "adaptive personalization" intent, on-device.

**F6 — Additional suggestions (proposed):**
- **Daily briefing / "right now" coach:** given the time, calendar, and persona
  states, a short "who to be now and what to do" summary.
- **Notifications/reminders:** finally use the `reminder_style` answer collected
  at onboarding (local notifications; nudge check-ins / persona switches).
- **Persona-conflict detection:** flag overlapping events that demand different
  personas at once.
- **Energy trend chart:** predicted peak windows vs. actual check-ins — also the
  evidence feed for F5.
- **Quick "feed" logging:** log time spent on a persona without a full task.
- **Explainability:** every suggestion shows *why* (which signals drove it).
- **Data controls:** export / delete-all; a single master toggle for any online
  feature (ties to REQUIREMENTS §8.5).

### Prioritized: persona growth (higher priority than theme/distribution)

- **Manually add personas.** Let users create new personas after using the tool
  a while (pick from the preset archetype templates or build a fully custom one:
  name, emoji, energy windows, ideal tasks, weekly target). Expected common
  action once people settle in. Reuses the existing generator/templates.
- **Suggest new personas (and adjustments).** From observation/analysis of the
  user (calendar patterns, energy check-ins, unmatched events, task history),
  propose either a preset archetype or an entirely new persona — and suggest
  tweaks to existing personas' peak times. Surface as suggestions the user
  approves. Not needed immediately, but central to the "life coach" north star.
  Overlaps roadmap **F5** (adaptive learning); build the manual-add path first,
  then layer suggestions on top.

### Energizing vs. draining activities (design note — don't reinvent)

Goal: capture whether events/activities energize or drain the user, and use it
for balance and coaching. There is established science here — adopt it rather
than inventing a scheme.

**Frameworks to build on:**
- **Russell's circumplex model of affect** (valence × arousal). The vertical
  **arousal/activation** axis is literally "how energized vs. deactivated/tired"
  one feels; the horizontal **valence** axis is pleasant↔unpleasant. Energizing
  ≈ activating; draining ≈ deactivating/depleting. Widely used for momentary
  affect measurement.
- **Self-Determination Theory — subjective vitality** (Deci & Ryan; Ryan &
  Frederick's Subjective Vitality Scale). Key, actionable finding: *autonomous*
  (self-chosen) regulation can be vitalizing, while *controlled* (externally
  pressured) regulation depletes energy. So the same activity can energize or
  drain depending on autonomy/need-satisfaction (autonomy, competence,
  relatedness).
- **Mood Meter / RULER** (Yale, Marc Brackett; consumer app "How We Feel") — a
  practical valence×energy quadrant UI; good precedent for a simple picker.
- Supporting: effort–recovery model (Meijman & Mulder), Conservation of
  Resources (Hobfoll), Day Reconstruction Method / Experience Sampling
  (Kahneman) for measurement. **Caveat:** "ego depletion" (Baumeister) has
  well-known replication problems — don't build core logic on it.

**Proposed design for Multitudes (heuristics-first, on-device):**
- Represent each activity/event's **energy impact** on a bipolar scale
  (Draining −2 … 0 … +2 Energizing) — the circumplex arousal axis. Optionally
  keep valence as a secondary note.
- **Seed a guess, let the user correct (→ F5 learning):** derive an initial
  estimate from signals we already have — persona-fit + timing (event in the
  matched persona's peak → likely energizing; mismatch or trough → likely
  draining) and autonomy proxy (self-chosen vs. obligatory, e.g. work meeting
  the user didn't organize). SDT says autonomy is the strongest lever.
- **Reuse the existing energy check-ins** as ground truth: a lightweight
  post-event "how did that leave you?" (−2..+2 or 1–10) refines the estimate.
- **Use it for coaching:** net weekly energy per persona / overall; flag
  net-draining stretches; protect energizing blocks; suggest recovery when
  draining events cluster (ties to F4 rebalancing and F5 learning).

### Persona-matching improvements (partially DONE)

**Done (2026-08-17):** per-archetype keyword **lexicons** + composite scoring
with a **time-of-day prior** and a **work/personal domain prior**; manual
event→persona assignment (override) already shipped. This fixed the "matched
nothing on a real calendar" problem for common titles.

**Still deferred:**
- More event signals: attendees, location, all-day vs. timed, recurrence.
- Optional **semantic/LLM classification** (online-enrichment layer, Decision C)
  for titles with no lexicon/learned overlap (e.g. "Sync w/ Dana").
- User-editable lexicons / per-persona keywords; review/prune learned tokens.

**Learn-from-corrections: DONE (2026-08-17).** Manual assignments now teach the
matcher (token→persona, weighted); learned tokens create matches and outweigh
weak lexicon hits. This is the groundwork for F5 (suggest personas/adjustments).

**F2 (timing suggestions): DONE (2026-08-17)** — events scheduled in a
persona's trough (or off-peak) surface a suggestion to move to the persona's
peak window (inline hint + a Suggestions screen). Non-destructive; two-way
calendar write-back remains deferred.

### Outlook / external calendars

- **Local-first path (preferred):** add the Outlook/Exchange/O365 account to the
  OS Calendar (macOS System Settings → Internet Accounts). EventKit then exposes
  it through the existing calendar source — no new code, stays on-device.
- **Direct Microsoft Graph path (optional, online):** OAuth2 + `Calendars.Read`
  via MS Graph for accounts not in the OS calendar. Heavier: Azure app
  registration, browser OAuth, token storage, network; crosses the
  online-enrichment boundary (Decision C). Only if the OS-calendar route is
  insufficient.

### Work vs. personal calendar classification

Surface all calendars with their account/source, let the user tag each as
Work / Personal / Ignore (with sensible inference), persist locally, and use the
tag to filter events and (later) apply work-hours vs. personal-hours context to
matching and timing.

### Deferred: finer-grained event hiding

Per-event hide/unhide is implemented and persists locally (`hidden_events`).
Keyed on the calendar event identifier, so **recurring events are hidden as a
whole series** — accepted for now (2026-08-17). Revisit only if needed:
- Per-occurrence hiding for recurring events.
- Rule-based auto-hide (e.g. all-day events, events the user isn't organizing,
  keywords like OOO/PTO/leave/holiday).

### Deferred: package for tester distribution + feedback

Bundle the local-first Flutter app so others can install it and give feedback.
Options by platform/effort:
- **iOS/macOS:** TestFlight via App Store Connect (needs a paid Apple Developer
  account, bundle id, signing) — smoothest install + built-in tester feedback.
- **macOS direct:** a signed + notarized `.dmg` (needs Developer ID) users can
  download and run; simplest without App Store review.
- **Android:** signed APK / Play Internal Testing track.
- **Cross-platform:** Firebase App Distribution (iOS+Android) for quick tester
  builds without the store.
- **Feedback:** in-app "Send feedback" (email/form export) or a simple
  issues link; consider bundling an anonymized data export toggle.
Note: this is per-device install of the app itself — distinct from the old
"Remote Hosting for Testers" item, which assumed a shared server backend.

### Deferred: appearance / theme

Light / Dark / Match-system theme selection, persisted locally. App currently
uses a single Material 3 light-ish theme seeded from the brand color.

### Cross-cutting decisions (need resolution before building)

- **A. Calendar integration is on-device (EventKit).** Read-only to start; adds
  a sandbox entitlement + usage description. Low privacy risk.
- **B. Intelligence is heuristics-first.** Persona-fit, scheduling suggestions,
  fed/starving, and rebalancing are all deterministic on-device logic using data
  we already have (ideal_tasks, triggers, peak windows, energy readings, hours).
  Keep them private, offline, and covered by shared fixtures (as with the
  generator). This is also the cheapest and most explainable path.
- **C. Online-enrichment boundary.** Local-events lookup (F4b) and any cloud LLM
  are the only pieces needing network. Introduce an explicit **optional online
  layer**: off by default, user-consented, graceful offline degradation, and
  documented in ARCHITECTURE. Preserves the local-first/privacy promise while
  enabling connected features. Requires choosing provider(s) + key handling.

### Suggested build sequence (dependency order)

1. **F1** — calendar read + entitlements (foundation).
2. **F2** — persona-fit + schedule-alignment suggestions (needs F1 + energy model).
3. **F3** — fed/starving dashboard (extend Balance with calendar hours).
4. **F4a** — on-device rebalancing suggestions; then **F4b** as optional online.
5. **F5** — adaptive learning (needs accumulated data, so latest).
6. **F6** — weave in throughout (briefing, notifications, trends, explainability).

Cross-cutting **Phase 3 sync** (ARCHITECTURE §0.3) remains independent and can
land whenever multi-device/tester access is wanted.

---

## 1. Remote Hosting & Online Access for Testers

**Priority:** High  
**Status:** Not Started

### Objective
Enable remote access to Multitudes backend for external testers using a spare laptop as the host server.

### Requirements
- Configure spare laptop as dedicated server
- Set up secure remote access (domain/subdomain or dynamic DNS)
- Implement proper authentication and security measures
- Document deployment process for remote hosting

### Technical Considerations
- **Hosting Options:**
  - Self-hosted with port forwarding + dynamic DNS (e.g., DuckDNS, No-IP)
  - Cloudflare Tunnel (secure, no port forwarding needed)
  - Tailscale/ZeroTier VPN (private network for testers)
  - AWS/DigitalOcean/Heroku deployment

- **Security Requirements:**
  - HTTPS/SSL certificates (Let's Encrypt)
  - Rate limiting and DDoS protection
  - Firewall configuration
  - Regular security updates
  - Backup strategy

- **Network Setup:**
  - Static IP or dynamic DNS
  - Router port forwarding (if applicable)
  - Domain name registration (optional)

### Next Steps
1. Research and compare hosting options
2. Evaluate security requirements vs. ease of setup
3. Create deployment documentation
4. Test with small group of testers

---

## 2. User-Friendly Onboarding Survey

**Priority:** High  
**Status:** Not Started  
**Replaces:** Current "Add Context" technical interface

### Objective
Create an intuitive, conversational onboarding experience that automatically populates user personas, behavioral patterns, and preferences without requiring technical knowledge.

### Current Problem
The "Add Context" interface is too technical for average users:
- Requires understanding of context types (preference, pattern, stat, persona_affinity)
- Manual JSON-like input format
- No guidance or examples
- Overwhelming for non-technical users

### Proposed Solution: Intelligent Onboarding Survey

**Survey Characteristics:**
- **Conversational tone** - Natural language questions
- **Progressive disclosure** - Start simple, go deeper gradually
- **Multiple formats** - Multiple choice, sliders, free text
- **Smart defaults** - Suggest common responses
- **Skip functionality** - Nothing required, all optional
- **Visual feedback** - Show how responses build their profile
- **Gamification** - Progress bar, completion rewards

### Survey Structure (Draft)

#### Phase 1: Core Identity (~2-3 minutes)
**Purpose:** Establish basic personality framework

Questions:
1. "How do you typically approach new tasks?"
   - [ ] Jump right in and figure it out as I go
   - [ ] Plan thoroughly before starting
   - [ ] Start with research and examples
   - [ ] Ask others for guidance first

2. "When making decisions, you tend to:"
   - [ ] Go with your gut feeling
   - [ ] Analyze all the data
   - [ ] Seek consensus from others
   - [ ] Consider long-term consequences

3. "Your ideal work environment is:"
   - [ ] Quiet and focused
   - [ ] Collaborative and social
   - [ ] Flexible with variety
   - [ ] Structured and predictable

4. "When learning something new, you prefer:"
   - [ ] Hands-on experimentation
   - [ ] Reading documentation
   - [ ] Video tutorials
   - [ ] One-on-one guidance

#### Phase 2: Work Patterns (~2-3 minutes)
**Purpose:** Understand productivity rhythms

Questions:
1. "You're most productive:" (slider: Morning → Afternoon → Evening → Night)

2. "How do you prefer to tackle large projects?"
   - [ ] Break into small tasks and complete incrementally
   - [ ] Focus intensively until completion
   - [ ] Mix of focused work and breaks
   - [ ] Collaborative sprints with others

3. "Your attention span works best with:"
   - [ ] Short bursts (15-25 min) with breaks
   - [ ] Medium sessions (45-60 min)
   - [ ] Long deep work (2+ hours)
   - [ ] Varies by task and interest

4. "When you're stuck on a problem, you typically:"
   - [ ] Take a break and come back fresh
   - [ ] Power through until solved
   - [ ] Ask for help immediately
   - [ ] Research similar solutions online

#### Phase 3: Communication Preferences (~2 minutes)
**Purpose:** Optimize interaction style

Questions:
1. "For important information, you prefer:"
   - [ ] Detailed explanations with context
   - [ ] Quick summaries with key points
   - [ ] Visual aids and diagrams
   - [ ] Step-by-step instructions

2. "When giving feedback, you appreciate:"
   - [ ] Direct and straightforward
   - [ ] Balanced with positives
   - [ ] Gentle and constructive
   - [ ] Data-driven and objective

3. "Your response style is typically:"
   - [ ] Quick and concise
   - [ ] Thoughtful and thorough
   - [ ] Casual and conversational
   - [ ] Formal and professional

#### Phase 4: Personal Context (~2 minutes)
**Purpose:** Understand life context and goals

Questions:
1. "What areas of your life would you like support with?" (Multi-select)
   - [ ] Work productivity
   - [ ] Personal goals
   - [ ] Learning & growth
   - [ ] Health & wellness
   - [ ] Creative projects
   - [ ] Relationships
   - [ ] Financial planning
   - [ ] Other: _________

2. "Your current biggest challenge is:" (Free text, optional)

3. "One thing you'd like to improve:" (Free text, optional)

4. "Your top priority right now:" (Free text, optional)

#### Phase 5: Preferences (~1-2 minutes)
**Purpose:** Technical and interaction preferences

Questions:
1. "Reminder/notification style:"
   - [ ] Proactive - remind me frequently
   - [ ] Balanced - occasional reminders
   - [ ] Minimal - only when I ask
   - [ ] None - I'll check in myself

2. "Level of detail in responses:"
   - [ ] Maximum detail - I want to understand everything
   - [ ] Balanced - key points + context
   - [ ] Minimal - just what I need to know
   - [ ] Adaptive - adjust based on the situation

3. "Error handling preference:"
   - [ ] Show me errors and let me fix them
   - [ ] Try to auto-correct when possible
   - [ ] Suggest fixes but let me choose
   - [ ] Handle silently unless critical

### Mapping Survey to Context Types

**Survey Answer → Context Mapping Logic:**

```
Question: "How do you approach new tasks?"
Answer: "Jump right in" 
→ Creates:
  - preference: learning_style = "hands-on"
  - pattern: task_approach = "experimental"
  - persona_affinity: "Adventurer" = 0.8

Question: "Most productive:"
Answer: Morning (7-11am)
→ Creates:
  - preference: peak_hours = "07:00-11:00"
  - pattern: productivity_rhythm = "morning_person"
  - stat: energy_level_morning = 0.9
```

### Research References
- **Personality Assessment:** Big Five, MBTI patterns, Enneagram principles
- **UX Onboarding:** Duolingo, Calm app, Notion setup
- **Conversational Surveys:** Typeform, SurveyMonkey best practices
- **AI Assistant Onboarding:** ChatGPT custom instructions, Claude Projects
- **Gamification:** Progress indicators, completion rewards

### Technical Implementation
- Create new `/onboarding` route in API
- Design multi-step form in Streamlit
- Survey response parser that generates context items
- Option to skip survey and use manual context later
- Save progress (resume interrupted survey)
- Show "preview" of generated profile before finalizing

### Success Metrics
- Survey completion rate > 70%
- Time to complete < 10 minutes
- User satisfaction with generated profile
- Reduction in manual context additions needed

---

## 3. Simplified Feedback Interface

**Priority:** Medium  
**Status:** Not Started  
**Replaces:** Current "Submit Feedback" technical interface

### Objective
Create an intuitive feedback mechanism that non-technical users can easily use to improve their personalization.

### Current Problem
The "Submit Feedback" interface requires:
- Understanding of interaction types
- JSON-formatted data entry
- Technical knowledge of feedback types (accepted, rejected, modified)
- No clear context about what they're providing feedback on

### Proposed Solution: Contextual Feedback System

**Core Principles:**
- **In-context feedback** - Provide feedback at point of interaction
- **Simple options** - Thumbs up/down, star ratings
- **Natural language** - "This was helpful" vs technical terms
- **Implicit feedback** - Learn from usage patterns
- **Optional details** - Can elaborate if desired

### Feedback Types

#### 1. Quick Reactions (Always Available)
- 👍 Helpful / 👎 Not Helpful
- ⭐ Star rating (1-5)
- 💡 "This is interesting"
- ⏭️ "Skip this type in future"

#### 2. Contextual Prompts
Show feedback requests at natural moments:
- After completing a suggested task
- After a response is provided
- At end of session
- Weekly check-in

Example:
```
"I suggested you work on [task] this morning. Was that helpful?"
[👍 Yes] [👎 No] [✏️ Tell me more...]
```

#### 3. Natural Language Input
- "Tell me what didn't work..."
- "What would have been better?"
- "How can I improve?"
- Auto-categorize using AI

#### 4. Behavior-Based Learning
Implicit signals that don't require explicit feedback:
- Time spent on suggested activities
- Frequency of using certain features
- Patterns in when user engages
- Tasks marked complete vs. ignored

### Technical Implementation
- Simplified feedback API endpoints
- Real-time feedback UI components
- Background feedback processing
- Feedback aggregation and pattern detection
- Monthly feedback summary for user

### UI Mockup Ideas
```
┌────────────────────────────────────┐
│ Your Morning Briefing              │
├────────────────────────────────────┤
│ • Review project docs (9am)        │
│ • Team standup (10am)              │
│ • Focus time: coding (11am-1pm)    │
│                                    │
│ Was this helpful?                  │
│ [😊 Yes] [😐 Somewhat] [😞 No]     │
│                                    │
│ [✏️ Add details...] [⏭️ Skip]      │
└────────────────────────────────────┘
```

---

## 4. Enhanced Statistics & Analytics

**Priority:** Low  
**Status:** Placeholder  
**Location:** Future "Statistics" tab enhancement

### Objective
Provide meaningful insights into how the AI personalization is improving over time.

### Potential Features

#### Personal Analytics
- **Learning Progress:** How well does the system know you?
- **Prediction Accuracy:** Success rate of suggestions
- **Engagement Patterns:** When you interact most
- **Preference Evolution:** How your preferences change over time

#### Visualization Ideas
- Persona affinity radar chart (current vs. initial)
- Confidence scores over time
- Context growth timeline
- Interaction heatmap (day/hour patterns)
- Most/least successful suggestion types

#### Insights
- "You're 40% more engaged with morning tasks"
- "Your productivity peaks on Tuesdays"
- "You prefer detailed responses for technical topics"
- "Your learning style evolved from visual to hands-on"

#### Export Options
- Download personal data (GDPR compliance)
- Export to CSV for analysis
- Share anonymized insights
- Monthly progress reports

### Research Areas
- Privacy-preserving analytics
- Meaningful metrics for personalization
- User-friendly data visualization
- Longitudinal behavior analysis

---

## 5. Native Mobile & Web Application

**Priority:** Low (Long-term)  
**Status:** Not Started  
**Prerequisites:** Core system must be rock solid first

### Objective
Transform the Streamlit dashboard into a professional native mobile application (iOS/Android) and responsive web app for seamless cross-platform access to Multitudes.

### Current State
- Streamlit dashboard is desktop/browser-focused
- Not optimized for mobile touch interfaces
- Limited offline capabilities
- Not app store ready

### Proposed Solution: Multi-Platform Application

#### Platform Targets
1. **iOS Native App** (Swift/SwiftUI or React Native)
2. **Android Native App** (Kotlin or React Native)
3. **Progressive Web App** (PWA) for desktop browsers
4. **Tablet-optimized** interfaces for iPad/Android tablets

#### Technology Options

**Option A: React Native (Cross-platform)**
- Single codebase for iOS/Android
- FastAPI backend remains unchanged
- Native look and feel on both platforms
- Large ecosystem and community

**Option B: Flutter (Cross-platform)**
- Already in the project structure (aipa_project uses Flutter)
- Excellent performance and native compilation
- Beautiful Material Design and Cupertino widgets
- Hot reload for rapid development

**Option C: Native per Platform**
- SwiftUI for iOS, Jetpack Compose for Android
- Best performance and platform integration
- More development effort (2x codebase)
- Deepest native feature access

**Recommendation:** Start with **Flutter** since project already has Flutter infrastructure

#### Core Features for Mobile

**Must-Have:**
- Persona switching (quick tap to switch active persona)
- Energy check-ins (log current energy level)
- Task quick-add (voice or text)
- Today's focus (which persona needs attention)
- Quick balance view (visual persona health)
- Notifications (persona reminders, energy alerts)

**Nice-to-Have:**
- Widget support (iOS Home Screen, Android Home)
- Apple Watch / Wear OS complications
- Siri / Google Assistant integration
- Calendar integration (native)
- Location-based persona triggers
- Offline mode with sync

#### UI/UX Considerations

**Mobile-First Design:**
- Thumb-friendly navigation
- Swipe gestures (switch personas, dismiss notifications)
- Large touch targets (44x44pt minimum)
- Dark mode support
- Haptic feedback
- Portrait and landscape support

**Visual Identity:**
- Persona-specific color schemes
- Emoji-driven persona identification
- Clean, minimal interface
- Smooth animations and transitions
- Native platform conventions

#### Technical Architecture

```
┌─────────────────────────────────────┐
│   Flutter Mobile App (iOS/Android)  │
│   - Persona UI                      │
│   - Energy tracking                 │
│   - Task management                 │
│   - Local cache/offline             │
└──────────┬──────────────────────────┘
           │ REST API
           │ (existing FastAPI)
┌──────────▼──────────────────────────┐
│   Backend Services                  │
│   - Authentication (JWT)            │
│   - Persona CRUD                    │
│   - Energy readings                 │
│   - Task management                 │
│   - PostgreSQL + InfluxDB           │
└─────────────────────────────────────┘
```

#### Development Phases

**Phase A: API Stabilization**
- Ensure all REST endpoints are mobile-friendly
- Add pagination for large datasets
- Optimize for mobile network conditions
- Add offline-first sync capabilities

**Phase B: Core Mobile App**
- Authentication flow
- Persona management
- Basic task operations
- Energy logging
- Dashboard view

**Phase C: Enhanced Features**
- Push notifications
- Widget support
- Apple Watch / Wear OS
- Offline mode
- Voice commands

**Phase D: App Store Launch**
- Beta testing (TestFlight / Play Store Beta)
- App store optimization (screenshots, description)
- Privacy policy and terms
- App store submission
- Marketing materials

#### App Store Requirements

**iOS App Store:**
- Apple Developer account ($99/year)
- App privacy details
- App review guidelines compliance
- TestFlight beta testing
- Screenshots for all device sizes

**Google Play Store:**
- Google Play Console account ($25 one-time)
- Privacy policy URL
- Content rating questionnaire
- Store listing details
- APK/AAB upload

#### Monetization Considerations
- Free tier: Basic persona tracking (3 personas max)
- Premium tier: Unlimited personas, advanced analytics, cloud sync
- In-app purchases: Additional features, themes
- Subscription model: Monthly/yearly premium access

#### Privacy & Security
- All API calls over HTTPS
- JWT token storage in secure keychain
- Biometric authentication (Face ID, Touch ID, fingerprint)
- Local encryption for sensitive data
- GDPR compliance for EU users
- Data export and deletion

### Success Metrics
- App store rating > 4.5 stars
- Daily active users retention > 60%
- Session length > 5 minutes
- Feature usage balance across personas
- Positive user reviews mentioning "life-changing"

### Estimated Timeline
- **Planning & Design:** 2-3 weeks
- **Core Development:** 8-12 weeks
- **Testing & Refinement:** 3-4 weeks
- **App Store Submission:** 1-2 weeks
- **Total:** 3-4 months for v1.0 mobile app

### Dependencies
- ✅ Stable FastAPI backend
- ✅ Clear persona data models
- ✅ Comprehensive testing
- ⏳ User feedback from web version
- ⏳ Design system documentation

### Research & Inspiration
- **Apps to Study:**
  - Notion (cross-platform excellence)
  - Things 3 (beautiful task management)
  - Calm (wellness tracking)
  - Streaks (habit tracking)
  - Day One (journaling with personality)

---

## Implementation Priority

### Phase 1 (Immediate)
1. Remote hosting setup (enable tester access)
2. User-friendly onboarding survey ← **IN PROGRESS**

### Phase 2 (Near-term)
3. Simplified feedback interface

### Phase 3 (Future)
4. Enhanced statistics & analytics

### Phase 4 (Long-term)
5. Native mobile & web application

---

## Notes

- All enhancements should maintain the core principle: **privacy-first, user-controlled personalization**
- Keep technical interfaces available for power users (advanced mode toggle)
- Document changes in CHANGELOG.md
- Update REQUIREMENTS.md with new features
- Maintain backward compatibility with existing user data

---

**Last Updated:** 2025-12-16  
**Status:** Planning Phase  
**Version:** 2.0.0
