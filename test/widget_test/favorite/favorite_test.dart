import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manga_time/views/favorite/favorite_screen.dart';
import 'package:manga_time/views/favorite/favorite_view_model.dart';
import 'package:provider/provider.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  CustomBindings();
  group('Favorite Screen', () {
    testWidgets(
        'should have title Favorite Screen and listview to display list of comic',
        (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider(
          create: (_) => FavoriteViewModel(),
          child: const MaterialApp(home: FavoriteScreen())));
      await tester.pumpAndSettle();
      expect(find.text("Favorite Screen"), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
