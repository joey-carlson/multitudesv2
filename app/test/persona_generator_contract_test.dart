/// Cross-language contract test.
///
/// Loads the SAME fixtures the Python suite asserts against
/// (../tests/fixtures/persona_generation_cases.json) and verifies the Dart
/// persona generator produces identical output. If Python and Dart ever drift,
/// this test fails. See docs/ARCHITECTURE.md §0.4.
library;

import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/domain/persona_generator.dart';

void main() {
  // flutter test runs with the package root (app/) as the working directory.
  final fixtureFile = File('../tests/fixtures/persona_generation_cases.json');
  final data = jsonDecode(fixtureFile.readAsStringSync()) as Map<String, dynamic>;
  final cases = (data['cases'] as List).cast<Map<String, dynamic>>();
  const eq = DeepCollectionEquality();

  group('persona generator matches shared fixtures', () {
    // Sanity: fixtures exist and were loaded.
    test('fixtures are present', () {
      expect(cases, isNotEmpty);
    });

    for (final testCase in cases) {
      test(testCase['name'] as String, () {
        final input = (testCase['input'] as Map).cast<String, dynamic>();
        final expected = testCase['expected'] as List;

        final personas = generatePersonasFromSurvey('fixture-user', input);
        final actual = personas.map((p) => p.toFixtureMap()).toList();

        expect(
          eq.equals(actual, expected),
          isTrue,
          reason: 'Dart output diverged from the Python spec for '
              '"${testCase['name']}".\nExpected: $expected\nActual:   $actual',
        );
      });
    }
  });
}
