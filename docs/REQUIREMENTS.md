# Multitudes v2.0 - Requirements Document

**Version:** 2.1.0  
**Last Updated:** 2026-08-17  
**Status:** Local-First Redesign

> **⚠️ Reading guide.** Section 0 (v2.1.0) states the **current product
> direction** and supersedes conflicting details in the historical sections
> (e.g. "web dashboard as primary interface", "mobile out of scope"). Historical
> sections are retained for context per our changelog convention.

---

## 0. Current Product Direction (v2.1.0 — Local-First)

### 0.1 What changed and why

Multitudes is a **single-user, privacy-first** assistant. The product now
targets running **self-contained on the user's own devices** (phone, tablet,
laptop) rather than depending on hosted server infrastructure. This makes it
genuinely private, usable offline, and cheap to run — and removes setup
friction (no databases or Docker to stand up).

### 0.2 User requirements (must have)

- **R0.1 — Runs with zero setup.** A fresh install works immediately with no
  external services, accounts, or configuration. *(Backend now satisfies this
  on a single SQLite file — Phase 0 complete.)*
- **R0.2 — Fully functional offline.** Core features (onboarding, viewing and
  switching personas, energy check-ins, balance view) work with no network.
  The device holds the source of truth.
- **R0.3 — Cross-platform from one codebase.** iOS, Android, and desktop via a
  Flutter client, with consistent behavior across platforms.
- **R0.4 — Optional multi-device sync.** Users may opt in to sync across their
  devices (and share with testers) via a self-hosted, logic-free server. Off by
  default; the app never requires it.
- **R0.5 — Privacy by default.** Data stays on-device unless the user enables
  sync. Export and delete-all remain available (carried from §8.5).

### 0.3 Non-functional requirements (current)

- **R0.6 — No behavioral drift across languages.** Persona/energy logic is
  authored and tested in Python and ported to Dart; both are verified against
  shared, generated fixtures so results stay identical. See ARCHITECTURE §0.4.
- **R0.7 — Portable data layer.** The same schema runs on on-device SQLite and
  an optional PostgreSQL sync server (dialect-neutral models).
- **R0.8 — Sync is safe and simple.** Differential, last-write-wins by
  timestamp, with soft-delete tombstones so no device silently loses data.
  See ARCHITECTURE §0.3.

### 0.4 Scope adjustments vs v2.0

- **Now in scope:** native mobile/tablet app (was "out of scope"); local-first
  operation; optional self-hosted sync.
- **Deprioritized:** the multi-database server stack (InfluxDB/Redis) and the
  heavy on-device LLM described in §8.3 Phase 3 (Llama 3.2 on-device) — revisit
  only if a concrete feature needs it.
- **Unchanged:** the persona philosophy (§1–2), the adaptive-personalization
  intent (§8), and privacy/data-control rights (§8.5).

---

## 1. Vision Statement

Multitudes is a personal AI assistant that recognizes and nurtures the multiple personas ("multitudes") within each user. Inspired by Walt Whitman's "Song of Myself" ("I am large, I contain multitudes"), the system helps users understand their different modes of being and optimize their productivity by balancing the needs of all their personas.

## 2. Core Philosophy

- **Users are not monolithic**: People operate in different modes with varying energy levels, priorities, and capabilities
- **Context-aware assistance**: The system adapts to which persona is currently active
- **Learning and growth**: The AI learns user patterns over time, becoming more personalized
- **Balance and nourishment**: Success means all personas are appropriately served, not just maximizing output

## 3. Primary Use Cases

### 3.1 Personal Productivity & Task Tracking
- Intelligent task management across multiple life domains
- Energy-aware scheduling (right task at right time for right persona)
- Automated task extraction from emails and calendar
- Priority management based on persona context

### 3.2 Persona Discovery & Management
- Interactive wizard to identify user's distinct personas
- Pattern recognition to suggest new personas
- Tracking which personas are over/under-served
- Persona attribute management (energy patterns, preferences)

### 3.3 Data Integration & Insights
- Aggregate data from Apple Mail, Apple Calendar, Gmail, Google Calendar, Outlook
- Generate contextual insights based on communication patterns
- Provide proactive scheduling recommendations
- Learn from user feedback and corrections

## 4. User Requirements

### 4.1 Must Have (v2.0)
- **Multi-source data integration**: Apple ecosystem (Mail, Calendar) as priority
- **Persona system**: Define, track, and balance multiple personas
- **Task management**: View, prioritize, and complete tasks
- **Web dashboard**: Streamlit-based interface for all features
- **Data persistence**: Store user data, preferences, and history
- **Basic AI insights**: Pattern recognition and simple recommendations

### 4.2 Should Have (v2.1-2.2)
- **Outlook integration**: Full support for Outlook Mail and Calendar
- **Gmail/Google Calendar**: Complete Google ecosystem support
- **Advanced learning**: Persona detection and automatic adjustments
- **Energy forecasting**: Predict user energy levels by time/day
- **Task routing**: Automatically assign tasks to appropriate personas
- **Contextual advice**: AI-generated guidance based on current state

### 4.3 Nice to Have (v2.3+)
- **Mobile companion app**: Flutter-based mobile interface
- **Voice interaction**: Natural language task creation
- **Team features**: Shared tasks and calendars
- **Integrations**: Slack, Jira, Todoist, etc.
- **Advanced analytics**: Deep insights and trend analysis

## 5. Platform Requirements

### 5.1 Current Phase
- **Desktop/Web**: Primary interface via web browser
- **Mac compatibility**: Native integration with Apple ecosystem
- **Cross-platform backend**: API-based architecture for future mobile support

### 5.2 Future Phases
- **Mobile apps**: iOS and Android native apps
- **Cloud deployment**: Self-hostable or SaaS offering
- **Multi-device sync**: Seamless experience across devices

## 6. Data Source Priorities

Priority order for integration:
1. **Apple Mail** (highest priority)
2. **Apple Calendar** (highest priority)
3. **Outlook Mail**
4. **Outlook Calendar**
5. **Gmail**
6. **Google Calendar**

## 7. AI & Learning Requirements

### 7.1 Core AI Capabilities
- **Pattern recognition**: Identify recurring behaviors and preferences
- **Persona detection**: Determine which persona is active based on context
- **Task classification**: Categorize tasks by persona affinity
- **Energy prediction**: Forecast user energy levels
- **Recommendation generation**: Suggest optimal task timing and prioritization

### 7.2 Learning System
- **Continuous adaptation**: System improves with usage
- **User feedback loops**: Corrections train the model
- **Privacy-first**: All learning happens locally or with user-controlled data
- **Explainable AI**: Users can understand why recommendations are made

## 8. User Personalization & Learning Strategy

### 8.1 Core Principle
**The system must become more specialized to each user over time without losing user-specific context.** This is a key differentiator and selling point.

### 8.2 Phased Implementation Approach

#### Phase 1: Adaptive Prompt Templates (MVP - Months 0-3)
**Implementation:**
- Store user patterns and preferences in PostgreSQL
- Dynamically construct AI prompts based on learned context
- No model training required - instant personalization

**Storage Requirements:**
- User preferences: 1-2 KB per user
- Persona definitions: 5-10 KB per user  
- Learned patterns: 10-20 KB per user
- Total: <50 KB per user

**Benefits:**
- Quick to implement (days not months)
- Low cost ($1-3/user/month)
- Immediate personalization
- Easy to explain and debug

**Example Context Stored:**
```python
{
    "work_style": "analytical, detail-oriented",
    "peak_energy_hours": [9, 10, 14, 15],
    "communication_preferences": "direct, bullet points",
    "learned_patterns": [
        "Prefers 25-minute work blocks",
        "Schedules creative tasks in morning",
        "Responds best to specific deadlines"
    ],
    "task_completion_stats": {
        "average_duration": "45min",
        "success_rate": 0.82,
        "preferred_categories": ["coding", "analysis"]
    }
}
```

#### Phase 2: RAG + Vector Embeddings (Months 3-6)
**Implementation:**
- Generate embeddings for all user interactions
- Store in vector database or PostgreSQL with pgvector
- Retrieve semantically relevant past contexts for AI prompts

**Storage Requirements:**
- ~5MB embeddings per 10,000 interactions
- $0.10-0.50/month per user for storage
- 50-100ms retrieval latency

**Benefits:**
- Deeper personalization through semantic understanding
- Can find relevant patterns even from months ago
- Explainable (show which past interactions influenced decisions)
- Privacy-preserving (embeddings don't reveal raw text)

**Technical Stack:**
- Embedding model: text-embedding-3-small (OpenAI) or MiniLM
- Storage: PostgreSQL with pgvector extension
- Retrieval: Top-K semantic similarity search

#### Phase 3: Local/Edge Learning (Months 6-12)
**Implementation:**
- Deploy lightweight models on user's device
- Process patterns locally for privacy
- Sync only aggregated insights to cloud

**Mobile Optimization:**
- Local model: Llama 3.2 1B (~600MB quantized)
- On-device embeddings: MobileNet/TinyBERT (20-50MB)
- Storage: SQLite with vector extension
- Full offline capability

**Benefits:**
- True privacy (data stays on device)
- Works offline (subway, airplane, etc.)
- Reduced API costs ($0.10-0.50/user/month)
- Faster inference (no network latency)

### 8.3 Mobile-First Architecture

**Critical Success Factor:** Design for eventual mobile deployment from day one.

#### Storage Abstraction
```python
class StorageBackend(ABC):
    """Portable storage that works on PostgreSQL or SQLite"""
    @abstractmethod
    def save_context(self, user_id, context): pass
    @abstractmethod
    def get_context(self, user_id): pass
```

#### Offline-First Features
- Queue tasks when offline, sync on WiFi
- Cache recent contexts (7 days) locally
- Differential privacy for cloud sync
- Progressive enhancement (works with/without AI)

#### Mobile Storage Budget
| Component | Size | Purpose |
|-----------|------|---------|
| Base App | 50MB | Flutter + UI |
| Local Model (optional) | 600MB | Llama 3.2 1B |
| User Data | 20MB | Contexts + embeddings |
| Cache | 30MB | Recent interactions |
| **Total** | **700MB** | Acceptable for modern devices |

### 8.4 Context Persistence Strategy

**Problem:** AI systems lose context over time, defeating personalization.

**Solutions:**
1. **Versioned Schemas**: Track how user data evolves
   - Migrate old data to new formats
   - Never lose historical context

2. **Context Decay Weighting**: Recent interactions matter more
   - Last 7 days: 1.0x weight
   - Last 30 days: 0.7x weight
   - Last 90 days: 0.4x weight
   - Older: 0.2x weight (never zero)

3. **Explicit Checkpointing**: Save persona states at key moments
   - After user edits persona manually
   - When major pattern detected
   - Monthly automated snapshots

4. **Feedback Loops**: Continuous learning from corrections
   - "Was this helpful?" after every AI suggestion
   - Track acceptance/rejection rates
   - Adjust weights based on feedback

5. **Semantic Deduplication**: Don't store redundant information
   - Merge similar contexts via embedding similarity
   - Keep most recent version of evolving patterns
   - Reduce storage by 60-70%

### 8.5 Privacy & Data Control

**User Data Rights:**
- Export all data in JSON format
- Delete specific contexts or all data
- Opt-out of cloud sync (local-only mode)
- View what data influenced each AI decision

**Security:**
- End-to-end encryption for sync
- Local data encrypted at rest
- No telemetry without explicit consent
- Open source core logic for auditability

### 8.6 Cost Comparison by Approach

| Approach | Storage/User | Compute/User | Total/Month | Implementation |
|----------|--------------|--------------|-------------|----------------|
| Fine-tuned Models | $5-10 | $20-50 | $25-60 | Not recommended |
| RAG + Embeddings | $0.10 | $2-5 | $2.10-5.10 | Phase 2 |
| Prompt Templates | $0.01 | $1-3 | $1.01-3.01 | Phase 1 ✓ |
| Local Learning | $0 | $0.50 | $0.50 | Phase 3 (mobile) |

### 8.7 Success Metrics for Personalization

**Quantitative:**
- Personalization accuracy: >80% correct persona detection
- Recommendation acceptance rate: >60%
- Time to valuable personalization: <1 week of usage
- Context retention: 90% of patterns retained after 90 days

**Qualitative:**
- Users report feeling "understood" by the system
- AI suggestions feel relevant and timely
- Users trust the system with sensitive information
- System adapts noticeably to changing patterns

### 8.8 Competitive Differentiation

**Unique Selling Points:**
1. **Works offline**: Unlike Notion AI, ChatGPT, etc.
2. **True learning**: Not just prompt engineering
3. **Privacy-first**: Data stays local by default
4. **Multi-persona**: Understands different modes of being
5. **Long-term memory**: Doesn't forget your patterns

**Tagline:** *"Your AI assistant that works on the subway and actually knows you."*

## 9. Non-Functional Requirements

### 8.1 Performance
- API response time: <100ms for standard requests
- Dashboard load time: <2 seconds
- Data sync: Complete within 30 seconds
- Real-time updates: <5 second latency

### 8.2 Security
- Secure credential storage (encrypted)
- JWT authentication for API access
- No plaintext sensitive data in logs
- Input validation on all user data
- Rate limiting on API endpoints

### 8.3 Reliability
- 99.9% uptime for local services
- Graceful degradation if data sources unavailable
- Automatic retry with exponential backoff
- Data backup and recovery capabilities

### 8.4 Maintainability
- Clean, well-documented code
- Comprehensive test coverage (>80%)
- Type hints throughout Python code
- Modular architecture for easy updates

## 9. Success Metrics

### 9.1 User Engagement
- Daily active usage rate
- Task completion rate improvement (vs baseline)
- Feature adoption rates
- User retention over time

### 9.2 System Performance
- Persona detection accuracy
- Recommendation acceptance rate
- Task routing success rate
- Energy prediction accuracy

### 9.3 Business Viability
- Time to value (onboarding to first benefit)
- User willingness to pay (conversion rate)
- Customer lifetime value
- Net Promoter Score (NPS)

## 10. Future Monetization Strategy

### 10.1 Freemium Model
- **Free tier**: Basic features, 1 data source, 3 personas
- **Pro tier**: All features, unlimited data sources, advanced AI
- **Teams tier**: Multi-user, shared resources, analytics

### 10.2 Pricing Targets (Future)
- Individual: $9.99-$14.99/month
- Professional: $24.99-$34.99/month
- Enterprise: Custom pricing

## 11. Out of Scope (v2.0)

- Mobile applications
- Multi-user/team features
- Third-party integrations beyond email/calendar
- Custom AI model training
- Public API for third-party developers
- White-label or enterprise deployment

---

## Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 2.1.0 | 2026-08-17 | — | Added Section 0: local-first product direction — zero-setup, offline-capable, cross-platform Flutter client, optional self-hosted sync, privacy by default. Brought mobile into scope; deprioritized multi-DB stack and on-device LLM. |
| 2.0.0 | 2025-12-08 | Initial | Created requirements document |
