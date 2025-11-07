import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_arena_challenge/features/pokemon/presentation/widgets/pokemon_stats.dart';
import 'package:digital_arena_challenge/l10n/app_localizations.dart';

void main() {
  group('PokemonStats Widget', () {
    const tStats = {
      'hp': 45,
      'attack': 49,
      'defense': 49,
      'special-attack': 65,
      'special-defense': 65,
      'speed': 45,
    };

    testWidgets('should display all stat names', (tester) async {
      // act
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
          ],
          home: Scaffold(
            body: PokemonStats(stats: tStats),
          ),
        ),
      );

      // assert
      expect(find.text('HP'), findsOneWidget);
      expect(find.text('Attack'), findsOneWidget);
      expect(find.text('Defense'), findsOneWidget);
      expect(find.text('Sp. Attack'), findsOneWidget);
      expect(find.text('Sp. Defense'), findsOneWidget);
      expect(find.text('Speed'), findsOneWidget);
    });

    testWidgets('should display all stat values', (tester) async {
      // act
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
          ],
          home: Scaffold(
            body: PokemonStats(stats: tStats),
          ),
        ),
      );

      // assert
      expect(find.text('45'), findsNWidgets(2)); // HP and Speed both have 45
      expect(find.text('49'), findsNWidgets(2)); // Attack and Defense
      expect(find.text('65'), findsNWidgets(2)); // Special stats
    });

    testWidgets('should display progress indicators', (tester) async {
      // act
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
          ],
          home: Scaffold(
            body: PokemonStats(stats: tStats),
          ),
        ),
      );

      // assert
      expect(find.byType(LinearProgressIndicator), findsNWidgets(6));
    });

    testWidgets('should format stat names correctly', (tester) async {
      // act
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
          ],
          home: Scaffold(
            body: PokemonStats(stats: tStats),
          ),
        ),
      );

      // assert
      expect(find.text('Sp. Attack'), findsOneWidget);
      expect(find.text('Sp. Defense'), findsOneWidget);
      expect(find.text('special-attack'), findsNothing);
    });
  });
}
