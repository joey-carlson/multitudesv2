import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/domain/calendar_classification.dart';

CalendarInfo _cal({required String title, String? account, String? type}) =>
    CalendarInfo(id: 'c', title: title, account: account, type: type);

void main() {
  group('inferCalendarKind', () {
    test('exchange type -> work', () {
      expect(inferCalendarKind(_cal(title: 'Calendar', type: 'exchange')),
          CalendarKind.work);
    });

    test('work-ish account/title -> work', () {
      expect(inferCalendarKind(_cal(title: 'Outlook', account: 'me@corp.com')),
          CalendarKind.work);
    });

    test('personal-ish -> personal', () {
      expect(inferCalendarKind(_cal(title: 'Home', account: 'iCloud')),
          CalendarKind.personal);
      expect(inferCalendarKind(_cal(title: 'Birthdays', type: 'birthday')),
          CalendarKind.personal);
    });

    test('unknown -> unset', () {
      expect(inferCalendarKind(_cal(title: 'Project X')), CalendarKind.unset);
    });
  });

  group('effectiveKind', () {
    final cal = _cal(title: 'Project X'); // infers unset

    test('override wins over inference', () {
      expect(effectiveKind(cal, {'c': CalendarKind.work}), CalendarKind.work);
    });

    test('unset override falls back to inference', () {
      expect(effectiveKind(cal, {'c': CalendarKind.unset}), CalendarKind.unset);
      expect(
        effectiveKind(_cal(title: 'Work', type: 'exchange'), const {}),
        CalendarKind.work,
      );
    });
  });
}
