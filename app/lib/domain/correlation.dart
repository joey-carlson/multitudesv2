/// Correlation analytics (depth improvement): aggregate the energy impact of
/// activities by different keys (persona, calendar type, time of day) so the
/// user can see what actually energizes vs. drains them. Pure + on-device.
library;

/// Average energy impact for a group, with how many samples informed it.
class ImpactAverage<K> {
  ImpactAverage({required this.key, required this.avg, required this.count});
  final K key;
  final double avg;
  final int count;
}

/// Group [samples] (key → impact value, e.g. −2..+2) by key, average each, and
/// return them sorted most-energizing first. Groups with fewer than [minCount]
/// samples are dropped.
List<ImpactAverage<K>> averageImpactByKey<K>(
  List<(K, int)> samples, {
  int minCount = 1,
}) {
  final sums = <K, int>{};
  final counts = <K, int>{};
  for (final (key, impact) in samples) {
    sums[key] = (sums[key] ?? 0) + impact;
    counts[key] = (counts[key] ?? 0) + 1;
  }
  final out = <ImpactAverage<K>>[];
  for (final key in sums.keys) {
    final c = counts[key]!;
    if (c < minCount) continue;
    out.add(ImpactAverage(key: key, avg: sums[key]! / c, count: c));
  }
  out.sort((a, b) => b.avg.compareTo(a.avg));
  return out;
}

/// Coarse part-of-day bucket for a given hour (used as a correlation key).
String partOfDay(int hour) {
  if (hour >= 5 && hour <= 11) return 'Morning';
  if (hour >= 12 && hour <= 16) return 'Afternoon';
  if (hour >= 17 && hour <= 21) return 'Evening';
  return 'Night';
}
