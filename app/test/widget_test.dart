import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/data/database.dart';
import 'package:multitudes/domain/persona.dart';
import 'package:multitudes/domain/persona_generator.dart';
import 'package:multitudes/ui/home_screen.dart';

void main() {
  testWidgets('HomeScreen renders a generated persona', (tester) async {
    // Arrange: generate a persona via the shared domain logic
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final List<Persona> personas = generatePersonasFromSurvey('u1', {
      'archetypes_selection': [
        '🧠 The Professional - Responsible, structured, goal-focused'
      ],
      'custom_persona_names': 'Executive Emma',
      'overall_energy_pattern': 'Early morning (7am-9am) - Pre-business hours',
    });

    // Act
    await tester.pumpWidget(
        MaterialApp(home: HomeScreen(personas: personas, db: db)));

    // Assert
    expect(find.text('Executive Emma'), findsOneWidget);
    expect(find.textContaining('07:00–09:00'), findsOneWidget);
  });
}
