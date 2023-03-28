import 'package:flutter/material.dart';
import 'package:project_flutter/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../test/helpers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  testWidgets('Integration Test', (tester) async {
    await initAppTest(tester);
    await tapSingleButton(tester, find.text('Bitcoin'));
    expect(find.byKey(const Key('coins_details_price')), findsOneWidget);
    final price = find
        .byKey(const Key('coins_details_price'))
        .evaluate()
        .single
        .widget as Text;
    expect(price.data, contains('1.634.603,00'));
    await tapSingleButton(
      tester,
      find.byKey(
        const Key('coins_details_value_input'),
      ),
    );
    await tester.enterText(
      find.byKey(const Key('coins_details_value_input')),
      '100',
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(const Key('coins_details_quantity_box')),
      findsOneWidget,
    );
    await tapSingleButton(
      tester,
      find.byKey(
        const Key('coins_details_buy_button'),
      ),
    );
    expect(
      find.byKey(const Key('coins_purchase_snackbar')),
      findsOneWidget,
    );
  });
}
