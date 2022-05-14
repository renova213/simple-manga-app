import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manga_time/views/report/report_screen.dart';
import 'package:manga_time/views/report/report_view_model.dart';
import 'package:provider/provider.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  CustomBindings();
  group('Report Screen', () {
    testWidgets('Should have title Report Screen', (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider(
          create: (_) => ReportViewModel(),
          child: const MaterialApp(home: ReportScreen(judul: "Judul Komik"))));
      await tester.pumpAndSettle();
      expect(find.text("Report Screen"), findsOneWidget);
    });

    testWidgets('Should have manga title', (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider(
          create: (_) => ReportViewModel(),
          child: const MaterialApp(home: ReportScreen(judul: "Judul Komik"))));
      await tester.pumpAndSettle();
      expect(find.text("Judul Komik"), findsOneWidget);
    });
    testWidgets(
        'Should have 3 fields to collects name, email, and message, then show validator when user not fill the field after submit',
        (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider(
          create: (_) => ReportViewModel(),
          child: const MaterialApp(home: ReportScreen(judul: "Judul Komik"))));

      expect(find.byKey(const Key("name_field")), findsOneWidget);
      expect(find.byKey(const Key("email_field")), findsOneWidget);
      expect(find.byKey(const Key("message_field")), findsOneWidget);

      await tester.tap(find.byType(ElevatedButton));

      await tester.pumpAndSettle();

      expect(find.text("Form nama tidak boleh kosong"), findsOneWidget);
      expect(find.text("Form email tidak boleh kosong"), findsOneWidget);
      expect(find.text("Form pesan tidak boleh kosong"), findsOneWidget);
    });

    testWidgets('validator return null when user fill the field after submit',
        (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider(
          create: (_) => ReportViewModel(),
          child: const MaterialApp(home: ReportScreen(judul: "Judul Komik"))));

      await tester.enterText(find.byKey(const ValueKey("name_field")), "Nova");
      await tester.enterText(
          find.byKey(const ValueKey("email_field")), "test@gmail.com");
      await tester.enterText(find.byKey(const ValueKey("message_field")),
          "In chapter 1, there is an image that doesn't appear");

      await tester.tap(find.byType(ElevatedButton));

      await tester.pumpAndSettle();

      expect(find.text("Form nama tidak boleh kosong"), findsNothing);
      expect(find.text("Form email tidak boleh kosong"), findsNothing);
      expect(find.text("Form pesan tidak boleh kosong"), findsNothing);
    });
  });
}
