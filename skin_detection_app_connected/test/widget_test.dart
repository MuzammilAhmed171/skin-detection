import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skin_detection_app/skin_counselling_page.dart';

void main() {
  testWidgets('Skin Counselling Page smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SkinCounsellingPage(),
      ),
    );

    // Verify main header and features
    expect(find.text('AI Skin Counselling'), findsOneWidget);
    expect(find.text('AI Skin Counselling & Care System'), findsOneWidget);
    expect(find.text('Skin Counselling Features'), findsOneWidget);
    expect(find.text('Complete Skin Counselling in 4 Easy Steps'), findsOneWidget);
    expect(find.text('1. Analysis'), findsOneWidget);
    expect(find.text('2. Treatment'), findsOneWidget);
    expect(find.text('3. Skin Care'), findsOneWidget);
    expect(find.text('4. Doctor Consultation'), findsOneWidget);
  });
}
