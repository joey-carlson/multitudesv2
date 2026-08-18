/// Balance trends (depth improvement): compare a persona's recent attention to
/// the prior period so the dashboard can flag personas trending toward
/// starvation rather than only showing a snapshot.
library;

enum TrendDirection {
  rising('↑', 'trending up'),
  steady('→', 'steady'),
  falling('↓', 'trending down');

  const TrendDirection(this.arrow, this.label);
  final String arrow;
  final String label;
}

/// Classify a persona's trend from [recent] vs [prior] hours (equal-length
/// windows). Uses relative change with a dead-band [threshold] so small
/// wobbles read as steady. Both zero → steady.
TrendDirection classifyTrend(double recent, double prior,
    {double threshold = 0.15}) {
  if (recent == 0 && prior == 0) return TrendDirection.steady;
  final base = prior == 0 ? recent : prior;
  final change = (recent - prior) / base;
  if (change > threshold) return TrendDirection.rising;
  if (change < -threshold) return TrendDirection.falling;
  return TrendDirection.steady;
}
