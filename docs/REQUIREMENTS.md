# Multitudes v2.0 - Requirements Document

**Version:** 2.0.0  
**Last Updated:** 2025-12-08  
**Status:** Initial Release

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

## 8. Non-Functional Requirements

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
| 2.0.0 | 2025-12-08 | Initial | Created requirements document |
