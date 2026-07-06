import 'package:flutter_test/flutter_test.dart';

import 'package:wisdomly/main.dart';

void main() {
  testWidgets('Turn the Page button smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const WisdomlyApp());
    await tester.pumpAndSettle();

    expect(find.text('TURN THE PAGE'), findsOneWidget);

    await tester.tap(find.text('TURN THE PAGE'));
    await tester.pumpAndSettle();

    expect(find.text('TURN THE PAGE'), findsOneWidget);
  });
}
