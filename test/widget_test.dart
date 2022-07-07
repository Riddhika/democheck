import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mvvm_structure/main.dart';

void main() {
  testWidgets('Flutter MVVM Demo test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
  });
}
