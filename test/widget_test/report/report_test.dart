import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manga_time/view/report/report_screen.dart';
import 'package:manga_time/view/report/report_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  group('Report Screen', () {
    testWidgets('Should have title Report Screen', (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider(
          create: (_) => ReportViewModel(),
          child: const MaterialApp(home: ReportScreen(judul: "Judul Manga"))));
      await tester.pumpAndSettle();
      expect(find.text("Report Screen"), findsOneWidget);
    });

    testWidgets('Should have manga title', (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider(
          create: (_) => ReportViewModel(),
          child: const MaterialApp(home: ReportScreen(judul: "Judul Manga"))));
      await tester.pumpAndSettle();
      expect(find.text("Judul Manga"), findsOneWidget);
    });
  });
}
