import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:digital_arena_challenge/features/pokemon/presentation/widgets/type_badge.dart';

void main() {
  group('TypeBadge Widget', () {
    testWidgets('should display pokemon type correctly', (tester) async {
      // arrange
      const type = 'fire';

      // act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TypeBadge(type: type),
          ),
        ),
      );

      // assert
      expect(find.text('FIRE'), findsOneWidget);
    });

    testWidgets('should have correct color for fire type', (tester) async {
      // arrange
      const type = 'fire';

      // act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TypeBadge(type: type),
          ),
        ),
      );

      // assert
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.orange));
    });

    testWidgets('should have correct color for water type', (tester) async {
      // arrange
      const type = 'water';

      // act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TypeBadge(type: type),
          ),
        ),
      );

      // assert
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.blue));
    });

    testWidgets('should have correct color for grass type', (tester) async {
      // arrange
      const type = 'grass';

      // act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TypeBadge(type: type),
          ),
        ),
      );

      // assert
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.green));
    });

    testWidgets('should display text in uppercase', (tester) async {
      // arrange
      const type = 'electric';

      // act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TypeBadge(type: type),
          ),
        ),
      );

      // assert
      expect(find.text('ELECTRIC'), findsOneWidget);
      expect(find.text('electric'), findsNothing);
    });
  });
}
