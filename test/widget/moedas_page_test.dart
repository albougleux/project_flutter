import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project_flutter/models/moeda.dart';
import 'package:project_flutter/pages/moedas_page.dart';
import 'package:project_flutter/repository/moedas_controller.dart';

import '../helpers.dart';
import 'moedas_page_test.mocks.dart';

@GenerateMocks([CoinsController])
void main() {
  late final MockCoinsController controller;
  setUpAll(() {
    controller = MockCoinsController();
  });

  Future<void> createWidget(
    WidgetTester tester, {
    List<Coin> coinlist = Helpers.coinList,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MoedasPage(
          controller: controller,
          coinList: coinlist,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('Test Moedas Page', () {
    testWidgets('Selected Coins', (tester) async {
      when(controller.selected).thenReturn(Helpers.coinList);
      when(controller.isSelected(any)).thenReturn(true);
      await createWidget(tester);
      expect(find.byType(MoedasPage), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byKey(const Key('coins_title_selected')), findsOneWidget);
      expect(
        find.text('${Helpers.coinList.length} selecionadas'),
        findsOneWidget,
      );
      expect(find.byKey(const Key('favorite_button')), findsOneWidget);
      expect(
        find.text('FAVORITAR'),
        findsOneWidget,
      );
    });
    testWidgets('No coins selected', (tester) async {
      when(controller.selected).thenReturn([]);
      when(controller.isSelected(any)).thenReturn(false);
      await createWidget(tester);
      expect(find.byType(MoedasPage), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byKey(const Key('coins_title_selected')), findsNothing);
      expect(
        find.text('${Helpers.coinList.length} selecionadas'),
        findsNothing,
      );
      expect(find.byKey(const Key('favorite_button')), findsNothing);
      expect(
        find.text('FAVORITAR'),
        findsNothing,
      );
    });
    testWidgets('Bitcoin Selected', (tester) async {
      when(controller.selected).thenReturn([Helpers.coinList.elementAt(0)]);
      when(controller.isSelected(any)).thenReturn(true);
      await createWidget(tester);
      expect(find.byKey(const Key('coins_title_selected')), findsOneWidget);
      expect(
        find.text('1 selecionadas'),
        findsOneWidget,
      );
      expect(find.byKey(const Key('favorite_button')), findsOneWidget);
      expect(
        find.text('FAVORITAR'),
        findsOneWidget,
      );
    });
    testWidgets('First 2 Selected', (tester) async {
      when(controller.selected)
          .thenReturn(Helpers.coinList.getRange(0, 2).toList());
      when(controller.isSelected(any)).thenReturn(true);
      await createWidget(tester);
      expect(find.byKey(const Key('coins_title_selected')), findsOneWidget);
      expect(
        find.text('2 selecionadas'),
        findsOneWidget,
      );
    });
  });
}
