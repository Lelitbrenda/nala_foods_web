import 'package:flutter_test/flutter_test.dart';
import 'package:nala_foods_web/main.dart';

void main() {
  testWidgets('Nala Foods app renders without error', (WidgetTester tester) async {
    await tester.pumpWidget(const NalaFoodsApp());
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(NalaFoodsApp), findsOneWidget);
  });
}
